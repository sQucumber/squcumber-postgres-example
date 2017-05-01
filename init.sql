create schema if not exists dwh;

create table if not exists dwh.tracking (
    request_timestamp timestamp not null
  , request_id        char(12)  not null
  , user_id           char(7)   not null
);


create table if not exists dwh.order (
    order_timestamp timestamp not null
  , order_id        char(12)  not null
);
