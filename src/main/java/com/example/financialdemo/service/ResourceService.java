package com.example.financialdemo.service;

import com.example.financialdemo.domain.dto.TreeNode;
import com.example.financialdemo.domain.entity.Resource;

import java.util.List;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/27 22:00
 */
public interface ResourceService {

    public List<Resource> getAllResources();

    public Resource getResourceById(Integer id);

    public List<TreeNode> loadResources();

    public List<TreeNode> loadAssignResources(Integer roleId);

    public int insertResource(Resource resource);

    public int updateResource(Resource resource);

    public int deleteResource(Integer id);

}
