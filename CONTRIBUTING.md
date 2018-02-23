## Submitting Changes

1. Fork the repository.
2. Run `mix deps.get`.
3. Run `mix test` to make sure everything is going right.
4. Create a topic branch.
5. Add tests for your unimplemented feature or bug fix.
6. Run `mix test`. If your tests pass, return to step 5. They are supposed to be failing first.
7. Implement your feature or bug fix.
8. Re-run `mix test`. If your specs fail, return to step 5. Your tests are supposed to be passing now.
9. Thoroughly document and comment your code.
10. Run `mix docs && open doc/index.html` and make sure your the ex_doc pages load and looks like you expect.
11. Add, commit, and push your changes.
12. Submit a pull request.
