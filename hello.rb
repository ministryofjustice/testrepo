#!/usr/bin/env ruby

require "net/http"
require "json"
require "uri"

GITHUB_API_URL = "https://api.github.com/graphql"

def run_query(json)
  headers = {"Authorization" => "bearer #{token}"}

  uri = URI.parse(GITHUB_API_URL)
  resp = Net::HTTP.post(uri, json, headers)

  resp.body
end

puts "Hello from ruby"
# pp ENV
# puts "Github event..."
# puts File.read("/home/runner/work/_temp/_github_workflow/event.json")

query = <<EOF
{
  resource(url: "https://github.com/ministryofjustice/testrepo/issues/15") {
    ... on Issue {
      projectCards {
        nodes {
          id
        }
      }
      repository {
        projects(search: "testproject", first: 10, states: [OPEN]) {
          nodes {
            id
            columns(first: 100) {
              nodes {
                id
                name
              }
            }
          }
        }
        owner {
          ... on Organization {
            projects(search: "testproject", first: 10, states: [OPEN]) {
              nodes {
                id
                columns(first: 100) {
                  nodes {
                    id
                    name
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
EOF

puts run_query(query)
