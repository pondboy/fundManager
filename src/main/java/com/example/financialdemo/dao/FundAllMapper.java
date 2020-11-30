package com.example.financialdemo.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.financialdemo.domain.entity.FundAll;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/17 16:05
 */
@Mapper
public interface FundAllMapper extends BaseMapper<FundAll> {

    @Select("select * from fund_all")
    public List<FundAll> all();
}
