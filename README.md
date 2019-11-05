
# Detect an issue comment on a pull request

This action detects if an issue comment event happens on a pull request.

## Versions

See [Releases](https://github.com/jmatsu/detect-issue-comment-to-pr-action/releases) page.

## Inputs and Outpus

See *action.yml* of your version.

## Example

Please make sure your workflow will run on issue_comment events.

```yaml
on: 
  issue_comment
```

Add this action to steps.

```yaml
- uses: jmatsu/detect-issue-comment-to-pr-action@<tag>
  id: filter
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
- run: echo "I'm a pull request (${{ steps.filter.outputs.pull_number }})"
  if: steps.filter.outputs.is_pull_request == 'true'
- run: echo "I'm not a pull request"
  if: steps.filter.outputs.is_pull_request != 'true'
```

For more detail, please read *action.yml* and [workflow examples](.github/workflows)

## License

[MIT License](LICENSE)
