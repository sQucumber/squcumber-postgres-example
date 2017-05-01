drop table if exists _visits;
create temporary table _visits as
  select
      request_timestamp::date    as reference_date
    , count(*)                   as visitor_count
    , count(distinct request_id) as unique_visitor_count
  from
      dwh.tracking
  group by
      reference_date
;

drop table if exists _sales;
create temporary table _sales as
  select
      order_timestamp::date as reference_date
    , count(*)              as sales_count
  from
      dwh.order
  group by
      reference_date
;

create table dwh.kpi as
  select
      reference_date
    , visitor_count
    , unique_visitor_count
    , sales_count
  from
      _visits
  full outer join
      _sales using(reference_date)
;
