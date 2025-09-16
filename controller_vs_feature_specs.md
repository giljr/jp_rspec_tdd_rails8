# Controller Specs vs Feature Specs

| Aspect                        | Controller Specs                                             | Feature Specs (System/Integration)                                                     |
| ----------------------------- | ------------------------------------------------------------ | -------------------------------------------------------------------------------------- |
| **Purpose**                   | Test the behavior of a single controller in isolation.       | Test the full user workflow through the application.                                   |
| **Scope**                     | Focused on actions: `GET`, `POST`, `PATCH`, `DELETE`.        | Focused on user interactions: clicking links, filling forms, navigation.               |
| **Stack Tested**              | Controller layer (may mock models, views).                   | Full stack: controllers, models, views, routing, JS, etc.                              |
| **Real Requests**             | Typically simulates requests using `get`, `post`, etc.       | Simulates browser behavior using Capybara or similar tools.                            |
| **Database Interaction**      | Can mock/stub models; can use test DB.                       | Uses test database; often with real records to simulate full workflow.                 |
| **View Rendering**            | Can be tested optionally, usually stubbed.                   | Views are rendered fully, including HTML and JS.                                       |
| **Example**                   | `expect(response).to have_http_status(:success)`             | `visit new_user_path; fill_in 'Email', with: 'test@example.com'; click_on 'Sign Up'`   |
| **Speed**                     | Fast, isolated, lightweight.                                 | Slower, because it goes through the full stack.                                        |
| **When to Use**               | Ensure controller action responds/handles correctly params.  | To test complete user stories and end-to-end behavior.                                 |
| ----------------------------- | ------------------------------------------------------------ | -------------------------------------------------------------------------------------- |
