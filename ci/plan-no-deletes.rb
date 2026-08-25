#!/usr/bin/env ruby
##[>] 🤖🤖
# Fails when a saved plan contains a delete. This root owns the cluster every
# pipeline in the group runs on: a delete here stops all CI, so it is surfaced
# before a human reads the plan rather than after an apply.
require 'json'

plan = JSON.parse(File.read(ARGV.fetch(0, 'tf/plan.json')))
deletes = plan.fetch('resource_changes', []).select do |c|
  c.dig('change', 'actions').to_a.include?('delete')
end

if deletes.empty?
  puts 'plan contains no deletes'
  exit 0
end

warn "plan contains #{deletes.size} delete(s):"
deletes.each { |c| warn "  #{c['address']}" }
exit 1
##[<] 🤖🤖
