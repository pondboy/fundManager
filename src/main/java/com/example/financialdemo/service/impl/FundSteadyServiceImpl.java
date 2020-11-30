package com.example.financialdemo.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.financialdemo.dao.FundAllMapper;
import com.example.financialdemo.dao.FundSteadyMapper;
import com.example.financialdemo.domain.dto.Fund;
import com.example.financialdemo.domain.entity.FundSteady;
import com.example.financialdemo.service.FundSteadyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;


import java.text.DecimalFormat;
import java.util.List;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/17 16:08
 */
@Service
public class FundSteadyServiceImpl implements FundSteadyService {

    @Value("${application.doctorxiong}")
    private String uri;

    @Autowired
    private FundSteadyMapper fundSteadyMapper;
    @Autowired
    private FundAllMapper fundAllMapper;

    @Override
    public IPage<FundSteady> pageQuery(Page page, String queryText) {
        if(queryText==null) {
            return fundSteadyMapper.selectPage(page,null);
        } else {
            return fundSteadyMapper.selectPage(page,new QueryWrapper<FundSteady>().lambda().like(FundSteady::getFundCode,queryText)
                    .or().like(FundSteady::getFundName,queryText));
        }
    }

    @Override
    public int deleteFundById(Integer id) {
        return fundSteadyMapper.delete(new QueryWrapper<FundSteady>().lambda().eq(FundSteady::getId,id));
    }

    @Override
    public int deleteFundByIds(List<Integer> ids) {
        return fundSteadyMapper.deleteBatchIds(ids);
    }

    @Override
    public int insertFund(Fund fund) {
        FundSteady isExist = fundSteadyMapper.selectOne(new QueryWrapper<FundSteady>().lambda().eq(FundSteady::getFundCode, fund.getFundCode()));
        if(isExist!=null) {
            return 0;
        }
        FundSteady fundSteady = new FundSteady();
        RestTemplate restTemplate = new RestTemplate();
        String fundCode = fund.getFundCode();
        String url = uri + "/v1/fund?code=" + fundCode;
        String json = restTemplate.getForObject(url, String.class);
        JSONArray datas = JSON.parseObject(json).getJSONArray("data");
        JSONObject data = datas.getJSONObject(0);
        if(data==null || data.isEmpty()) {
            return 0;
        } else {
            fundSteady.setFundCode(data.getString("code"));
            fundSteady.setFundName(data.getString("name"));
            fundSteady.setFundType(data.getString("type"));
            fundSteady.setNetWorth(data.getString("netWorth"));
            fundSteady.setExpectGrowth(data.getString("expectGrowth")+"%");
            fundSteady.setDayGrowth(data.getString("dayGrowth")+"%");
            fundSteady.setMonthGrowth(data.getString("lastMonthGrowth")+"%");
            fundSteady.setThreeMonthsGrowth(data.getString("lastThreeMonthsGrowth")+"%");
            fundSteady.setSixMonthsGrowth(data.getString("lastSixMonthsGrowth")+"%");
            fundSteady.setYearGrowth(data.getString("lastYearGrowth")+"%");
            fundSteady.setManager(data.getString("manager"));

            //添加金额
            fundSteady.setInvestment(fund.getInvestment());
            String all = fundAllMapper.all().get(0).getAll();
            Double ration = Double.valueOf(fund.getInvestment())/Double.valueOf(all)*100;
            DecimalFormat format = new DecimalFormat("#.####");
            fundSteady.setInvestmentRation(format.format(ration)+"%");

            return fundSteadyMapper.insert(fundSteady);
        }
    }
}
