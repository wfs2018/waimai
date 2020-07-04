/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2020/7/4 10:22:05                            */
/*==============================================================*/


drop table if exists administrator;

drop table if exists comment;

drop table if exists customer_discount_list;

drop table if exists deliver_income;

drop table if exists deliveryman;

drop table if exists discount;

drop table if exists jidansongquan;

drop table if exists merchant;

drop table if exists "order";

drop table if exists order_detail;

drop table if exists product;

drop table if exists product_categories;

drop table if exists reduction;

drop table if exists user;

/*==============================================================*/
/* Table: administrator                                         */
/*==============================================================*/
create table administrator
(
   staff_id             int not null,
   staff_name           varchar(20) not null,
   staff_pwd            varchar(20) not null,
   primary key (staff_id)
);

/*==============================================================*/
/* Table: comment                                               */
/*==============================================================*/
create table comment
(
   merchant_id          int not null,
   user_id              int not null,
   product_id           int not null,
   comment_content      varchar(10),
   comment_data         timestamp,
   comment_level        int,
   comment_image        longblob,
   primary key (merchant_id, user_id, product_id)
);

/*==============================================================*/
/* Table: customer_discount_list                                */
/*==============================================================*/
create table customer_discount_list
(
   merchant_id          int not null,
   user_id              int not null,
   discount_id          int not null,
   de_amount            int,
   de_deadline          timestamp,
   primary key (merchant_id, user_id, discount_id)
);

/*==============================================================*/
/* Table: deliver_income                                        */
/*==============================================================*/
create table deliver_income
(
   deliveryman_id       int not null,
   product_id           int not null,
   deliver_time         timestamp not null,
   user_evalute         varchar(50),
   per_income           float(10) not null,
   primary key (deliveryman_id, product_id)
);

/*==============================================================*/
/* Table: deliveryman                                           */
/*==============================================================*/
create table deliveryman
(
   deliveryman_id       int not null,
   deliveryman_name     varchar(10) not null,
   deliveryman_date_in  date not null,
   deliveryman_level    varchar(10) not null,
   primary key (deliveryman_id)
);

/*==============================================================*/
/* Table: discount                                              */
/*==============================================================*/
create table discount
(
   discount_id          int not null,
   youhui_money         float(10) not null,
   discount_required    int not null,
   valid_start_time     timestamp not null,
   valid_end_time       timestamp not null,
   primary key (discount_id)
);

/*==============================================================*/
/* Table: jidansongquan                                         */
/*==============================================================*/
create table jidansongquan
(
   merchant_id          int not null,
   discount_id          int not null,
   user_id              int not null,
   yidingdanshu         int not null,
   primary key (merchant_id, discount_id, user_id)
);

/*==============================================================*/
/* Table: merchant                                              */
/*==============================================================*/
create table merchant
(
   merchant_id          int not null,
   merchant_name        varchar(20) not null,
   merchant_level       int not null,
   avg_consumption      float(10) not null,
   total_sales          int not null,
   primary key (merchant_id)
);

/*==============================================================*/
/* Table: "order"                                               */
/*==============================================================*/
create table "order"
(
   order_id             int not null,
   reduction_id         int,
   deliveryman_id       int,
   merchant_id          int,
   discount_id          int,
   user_id              int,
   origin_money         float(10) not null,
   end_money            float(10) not null,
   pay_money_time       timestamp not null,
   arr_time             timestamp not null,
   order_state          varchar(10) not null,
   primary key (order_id)
);

/*==============================================================*/
/* Table: order_detail                                          */
/*==============================================================*/
create table order_detail
(
   product_id           int not null,
   order_id             int not null,
   order_amount         int not null,
   order_money          float(10) not null,
   order_discountt_per  float(10) not null,
   primary key (product_id, order_id)
);

/*==============================================================*/
/* Table: product                                               */
/*==============================================================*/
create table product
(
   product_id           int not null,
   categories_id        int,
   product_name         varchar(10) not null,
   product_price        float(10) not null,
   product_discount_price float(10) not null,
   primary key (product_id)
);

/*==============================================================*/
/* Table: product_categories                                    */
/*==============================================================*/
create table product_categories
(
   categories_id        int not null,
   categories_bar_name  varchar(20) not null,
   commodity_sum        int not null,
   primary key (categories_id)
);

/*==============================================================*/
/* Table: reduction                                             */
/*==============================================================*/
create table reduction
(
   reduction_id         int not null,
   merchant_id          int,
   reduction_money      float(10) not null,
   youhui_money         float(10) not null,
   is_cat_discount      bool not null,
   primary key (reduction_id)
);

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   user_id              int not null,
   user_name            varchar(10) not null,
   user_gender          bool not null,
   user_pwd             varchar(10) not null,
   user_phone           varchar(10) not null,
   user_mailbox         varchar(20) not null,
   city                 varchar(10) not null,
   vip_begin_time       timestamp not null,
   is_vip               bool not null,
   vip_stop_time        timestamp not null,
   primary key (user_id)
);

alter table comment add constraint FK_comment foreign key (merchant_id)
      references merchant (merchant_id) on delete restrict on update restrict;

alter table comment add constraint FK_comment2 foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table comment add constraint FK_comment3 foreign key (product_id)
      references product (product_id) on delete restrict on update restrict;

alter table customer_discount_list add constraint FK_customer_discount_list foreign key (merchant_id)
      references merchant (merchant_id) on delete restrict on update restrict;

alter table customer_discount_list add constraint FK_customer_discount_list2 foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table customer_discount_list add constraint FK_customer_discount_list3 foreign key (discount_id)
      references discount (discount_id) on delete restrict on update restrict;

alter table deliver_income add constraint FK_deliver_income foreign key (deliveryman_id)
      references deliveryman (deliveryman_id) on delete restrict on update restrict;

alter table deliver_income add constraint FK_deliver_income2 foreign key (product_id)
      references product (product_id) on delete restrict on update restrict;

alter table jidansongquan add constraint FK_jidansongquan foreign key (merchant_id)
      references merchant (merchant_id) on delete restrict on update restrict;

alter table jidansongquan add constraint FK_jidansongquan2 foreign key (discount_id)
      references discount (discount_id) on delete restrict on update restrict;

alter table jidansongquan add constraint FK_jidansongquan3 foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table "order" add constraint FK_Relationship_1 foreign key (merchant_id)
      references merchant (merchant_id) on delete restrict on update restrict;

alter table "order" add constraint FK_Relationship_2 foreign key (reduction_id)
      references reduction (reduction_id) on delete restrict on update restrict;

alter table "order" add constraint FK_Relationship_3 foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table "order" add constraint FK_Relationship_4 foreign key (deliveryman_id)
      references deliveryman (deliveryman_id) on delete restrict on update restrict;

alter table "order" add constraint FK_Relationship_5 foreign key (discount_id)
      references discount (discount_id) on delete restrict on update restrict;

alter table order_detail add constraint FK_order_detail foreign key (product_id)
      references product (product_id) on delete restrict on update restrict;

alter table order_detail add constraint FK_order_detail2 foreign key (order_id)
      references "order" (order_id) on delete restrict on update restrict;

alter table product add constraint FK_Relationship_7 foreign key (categories_id)
      references product_categories (categories_id) on delete restrict on update restrict;

alter table reduction add constraint FK_Relationship_8 foreign key (merchant_id)
      references merchant (merchant_id) on delete restrict on update restrict;

