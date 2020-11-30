package com.example.financialdemo.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.financialdemo.dao.FundOptionMapper;
import com.example.financialdemo.domain.dto.Fund;
import com.example.financialdemo.domain.entity.FundOption;
import com.example.financialdemo.service.FundOptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/17 16:08
 */
@Service
public class FundOptionImpl implements FundOptionService {

    @Value("${application.doctorxiong}")
    private String uri;

    @Autowired
    private FundOptionMapper fundOptionMapper;

    @Override
    public IPage<FundOption> pageQuery(Page page, String queryText) {
        if(queryText==null) {
            return fundOptionMapper.selectPage(page,null);
        } else {
            return fundOptionMapper.selectPage(page,new QueryWrapper<FundOption>().lambda().like(FundOption::getFundCode,queryText)
                    .or().like(FundOption::getFundName,queryText));
        }
    }

    @Override
    public int deleteFundById(Integer id) {
        return fundOptionMapper.delete(new QueryWrapper<FundOption>().lambda().eq(FundOption::getId,id));
    }

    @Override
    public int deleteFundByIds(List<Integer> ids) {
        return fundOptionMapper.deleteBatchIds(ids);
    }

    @Override
    public int insertFund(Fund fund) {
        FundOption isExist = fundOptionMapper.selectOne(new QueryWrapper<FundOption>().lambda().eq(FundOption::getFundCode, fund.getFundCode()));
        if(isExist!=null) {
            return 0;
        }
        FundOption fundOption = new FundOption();
        RestTemplate restTemplate = new RestTemplate();
        String fundCode = fund.getFundCode();
        String url = uri + "/v1/fund?code=" + fundCode;
        String json = restTemplate.getForObject(url, String.class);
        JSONArray datas = JSON.parseObject(json).getJSONArray("data");
        JSONObject data = datas.getJSONObject(0);
        if(data==null || data.isEmpty()) {
            return 0;
        } else {
            fundOption.setFundCode(data.getString("code"));
            fundOption.setFundName(data.getString("name"));
            fundOption.setFundType(data.getString("type"));
            fundOption.setMonthGrowth(data.getString("lastMonthGrowth")+"%");
            fundOption.setThreeMonthsGrowth(data.getString("lastThreeMonthsGrowth")+"%");
            fundOption.setSixMonthsGrowth(data.getString("lastSixMonthsGrowth")+"%");
            fundOption.setYearGrowth(data.getString("lastYearGrowth")+"%");
            fundOption.setManager(data.getString("manager"));

            return fundOptionMapper.insert(fundOption);
        }
    }
}
