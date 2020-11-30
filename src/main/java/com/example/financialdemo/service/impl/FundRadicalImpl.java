package com.example.financialdemo.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.financialdemo.dao.FundAllMapper;
import com.example.financialdemo.dao.FundRadicalMapper;
import com.example.financialdemo.domain.dto.Fund;
import com.example.financialdemo.domain.entity.FundRadical;
import com.example.financialdemo.service.FundRadicalService;
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
public class FundRadicalImpl implements FundRadicalService {

    @Value("${application.doctorxiong}")
    private String uri;

    @Autowired
    private FundRadicalMapper fundRadicalMapper;
    @Autowired
    private FundAllMapper fundAllMapper;

    @Override
    public IPage<FundRadical> pageQuery(Page page, String queryText) {
        if(queryText==null) {
            return fundRadicalMapper.selectPage(page,null);
        } else {
            return fundRadicalMapper.selectPage(page,new QueryWrapper<FundRadical>().lambda().like(FundRadical::getFundCode,queryText)
                    .or().like(FundRadical::getFundName,queryText));
        }
    }

    @Override
    public int deleteFundById(Integer id) {
        return fundRadicalMapper.delete(new QueryWrapper<FundRadical>().lambda().eq(FundRadical::getId,id));
    }

    @Override
    public int deleteFundByIds(List<Integer> ids) {
        return fundRadicalMapper.deleteBatchIds(ids);
    }

    @Override
    public int insertFund(Fund fund) {
        FundRadical isExist = fundRadicalMapper.selectOne(new QueryWrapper<FundRadical>().lambda().eq(FundRadical::getFundCode, fund.getFundCode()));
        if(isExist!=null) {
            return 0;
        }
        FundRadical fundRadical = new FundRadical();
        RestTemplate restTemplate = new RestTemplate();
        String fundCode = fund.getFundCode();
        String url = uri + "/v1/fund?code=" + fundCode;
        String json = restTemplate.getForObject(url, String.class);
        JSONArray datas = JSON.parseObject(json).getJSONArray("data");
        JSONObject data = datas.getJSONObject(0);
        if(data==null || data.isEmpty()) {
            return 0;
        } else {
            fundRadical.setFundCode(data.getString("code"));
            fundRadical.setFundName(data.getString("name"));
            fundRadical.setFundType(data.getString("type"));
            fundRadical.setNetWorth(data.getString("netWorth"));
            fundRadical.setExpectGrowth(data.getString("expectGrowth")+"%");
            fundRadical.setDayGrowth(data.getString("dayGrowth")+"%");
            fundRadical.setMonthGrowth(data.getString("lastMonthGrowth")+"%");
            fundRadical.setThreeMonthsGrowth(data.getString("lastThreeMonthsGrowth")+"%");
            fundRadical.setSixMonthsGrowth(data.getString("lastSixMonthsGrowth")+"%");
            fundRadical.setYearGrowth(data.getString("lastYearGrowth")+"%");
            fundRadical.setManager(data.getString("manager"));

            //添加金额
            fundRadical.setInvestment(fund.getInvestment());
            String all = fundAllMapper.all().get(0).getAll();
            Double ration = Double.valueOf(fund.getInvestment())/Double.valueOf(all)*100;
            DecimalFormat format = new DecimalFormat("#.####");
            fundRadical.setInvestmentRation(format.format(ration)+"%");

            return fundRadicalMapper.insert(fundRadical);
        }
    }
}
