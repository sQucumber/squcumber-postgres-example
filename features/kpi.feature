Feature: Our Business KPIs

  Background:
    Given the SQL files in the path "sql":
      | file    |
      | kpi.sql |
    And their table dependencies:
      | table        |
      | dwh.order    |
      | dwh.tracking |

  Scenario: KPIs are reported correctly
    Given the existing table dwh.tracking:
      | request_timestamp   | request_id   | user_id |
      | 2016-09-27 22:33:55 | jDKWIue1kDsw | QKDksl1 |
      | 2016-09-27 11:22:33 | nbM2mQ9MGJEg | QKDksl1 |
      | 2016-09-28 12:13:14 | AYT9dQBzFNSc | PqOA9kD |
    And the existing table dwh.order:
      | order_timestamp     | order_id     |
      | 2016-09-27 23:55:59 | ufK6HbuzkFwX |
    When the given SQL files are executed
    And the resulting table "dwh.kpi" is queried, ordered by "reference_date"
    Then the result exactly matches visitors and unique visitors being counted correctly:
      | reference_date | visitor_count | unique_visitor_count |
      | 2016-09-27     | 2             | 1                    |
      | 2016-09-28     | 1             | 1                    |
    And the result exactly matches the sales attributed correctly:
      | reference_date | sales_count |
      | 2016-09-27     | 0           |
      | 2016-09-28     | 1           |
