SD - Surat Dunia, which translates from Indonesian as "News from the World".

# Getting started

Please bear in mind this project is still work in progress. I open-source it if viewers are interested in a full-stack Rails-React example, but I don't recommend using it for real use-case yet.

## Run Rails (compile webpack as well)

- `bin/rails s`

## Run Tests

- `bin/rspec`

## Regenerate graphql schema

- `bin/rails graphql:dump_schema`
- `yarn run introspect-schema`
- `yarn run generate-apollo-types`

## Run storybook

- `yarn run storybook`