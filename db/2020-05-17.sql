create table if not exists `fund_steady` (
  `id` int(11) not null auto_increment comment '自增稳健型基金主键',
  `fund_code` varchar(32) null comment '基金代码',
  `fund_name` varchar(64) null comment '基金名称',
  `fund_type` varchar(32) null comment '基金类型',
  `net_worth` varchar(32) null comment '当前基金单位净值',
  `expect_growth` varchar(32) null comment '当前基金单位净值估算日涨幅,单位为百分比',
  `day_growth` varchar(32) null comment '单位净值日涨幅,单位为百分比',
  `month_growth` varchar(32) null comment '单位净值月涨幅,单位为百分比',
  `three_months_growth` varchar(32) null comment '单位净值三月涨幅,单位为百分比',
  `six_months_growth` varchar(32) null comment '单位净值六月涨幅,单位为百分比',
  `year_growth` varchar(32) null comment '单位净值年涨幅,单位为百分比',
  `manager` varchar(32) null comment '基金经理',
  `investment` varchar(32) null comment '投入基金额度',
  `investment_ration` varchar(32) null comment '投入基金额度占比',
  primary key (`id`)
) ENGINE = InnoDB auto_increment=1 default charset = utf8;

create table if not exists `fund_radical` (
   `id` int(11) not null auto_increment comment '自增激进型基金主键',
   `fund_code` varchar(32) null comment '基金代码',
   `fund_name` varchar(64) null comment '基金名称',
   `fund_type` varchar(32) null comment '基金类型',
   `net_worth` varchar(32) null comment '当前基金单位净值',
   `expect_growth` varchar(32) null comment '当前基金单位净值估算日涨幅,单位为百分比',
   `day_growth` varchar(32) null comment '单位净值日涨幅,单位为百分比',
   `month_growth` varchar(32) null comment '单位净值月涨幅,单位为百分比',
   `three_months_growth` varchar(32) null comment '单位净值三月涨幅,单位为百分比',
   `six_months_growth` varchar(32) null comment '单位净值六月涨幅,单位为百分比',
   `year_growth` varchar(32) null comment '单位净值年涨幅,单位为百分比',
   `manager` varchar(32) null comment '基金经理',
   `investment` varchar(32) null comment '投入基金额度',
   `investment_ration` varchar(32) null comment '投入基金额度占比',
   primary key (`id`)
) ENGINE = InnoDB auto_increment=1 default charset = utf8;

create table if not exists `fund_option` (
    `id` int(11) not null auto_increment comment '自选基金主键',
    `fund_code` varchar(32) null comment '基金代码',
    `fund_name` varchar(64) null comment '基金名称',
    `fund_type` varchar(32) null comment '基金类型',
    `net_worth` varchar(32) null comment '当前基金单位净值',
    `expect_growth` varchar(32) null comment '当前基金单位净值估算日涨幅,单位为百分比',
    `day_growth` varchar(32) null comment '单位净值日涨幅,单位为百分比',
    `month_growth` varchar(32) null comment '单位净值月涨幅,单位为百分比',
    `three_months_growth` varchar(32) null comment '单位净值三月涨幅,单位为百分比',
    `six_months_growth` varchar(32) null comment '单位净值六月涨幅,单位为百分比',
    `year_growth` varchar(32) null comment '单位净值年涨幅,单位为百分比',
    `manager` varchar(32) null comment '基金经理',
    primary key (`id`)
) ENGINE = InnoDB auto_increment=1 default charset = utf8;