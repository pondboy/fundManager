create table if not exists `stock_hold` (
    `id` int(11) not null auto_increment comment '股票策略主键',
    `fund_code` varchar(32) null comment '股票代码',
    `fund_name` varchar(64) null comment '股票名称',
    `net_worth` varchar(32) null comment '今日开盘价',
    `expect_growth` varchar(32) null comment '昨日收盘价',
    `day_growth` varchar(32) null comment '实时价格',
    `three_months_growth` varchar(32) null comment '开盘后价格涨幅,单位为百分比',
    `six_months_growth` varchar(32) null comment '开盘截至目前最高价',
    `year_growth` varchar(32) null comment '单开盘截至目前最低价',
    `manager` varchar(32) null comment '止盈规则',
    `manager` varchar(32) null comment '止损规则',
    primary key (`id`)
) ENGINE = InnoDB auto_increment=1 default charset = utf8;


create table if not exists `stock_hold` (
    `id` int(11) not null auto_increment comment '持有股票主键',
    `fund_code` varchar(32) null comment '股票代码',
    `fund_name` varchar(64) null comment '股票名称',
    `net_worth` varchar(32) null comment '今日开盘价',
    `expect_growth` varchar(32) null comment '昨日收盘价',
    `day_growth` varchar(32) null comment '实时价格',
    `three_months_growth` varchar(32) null comment '开盘后价格涨幅,单位为百分比',
    `six_months_growth` varchar(32) null comment '开盘截至目前最高价',
    `year_growth` varchar(32) null comment '单开盘截至目前最低价',
    `manager` varchar(32) null comment '止盈规则',
    `manager` varchar(32) null comment '止损规则',
    primary key (`id`)
) ENGINE = InnoDB auto_increment=1 default charset = utf8;


