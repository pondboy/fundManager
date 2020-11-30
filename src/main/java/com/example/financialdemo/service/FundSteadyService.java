package com.example.financialdemo.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.financialdemo.domain.dto.Fund;
import com.example.financialdemo.domain.entity.FundSteady;

import java.util.List;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/17 16:07
 */
public interface FundSteadyService {

    public IPage<FundSteady> pageQuery(Page page,String queryText);

    public int deleteFundById(Integer id);

    public int deleteFundByIds(List<Integer> ids);

    public int insertFund(Fund fund);
}
