package com.example.financialdemo.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.financialdemo.dao.ResourceMapper;
import com.example.financialdemo.domain.dto.TreeNode;
import com.example.financialdemo.domain.entity.Resource;
import com.example.financialdemo.domain.enums.ResourceType;
import com.example.financialdemo.service.ResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/27 22:01
 */
@Service
public class ResourceServiceImpl implements ResourceService {

    @Autowired
    private ResourceMapper resourceMapper;

    @Override
    public List<Resource> getAllResources() {
        return resourceMapper.selectList(new QueryWrapper<Resource>());
    }

    @Override
    public Resource getResourceById(Integer id) {
        return resourceMapper.selectOne(new QueryWrapper<Resource>().lambda().eq(Resource::getId,id));
    }

    @Override
    public List<TreeNode> loadResources() {
        List<TreeNode> out = new ArrayList<>();
        TreeNode root = new TreeNode();

        //查询所有的资源 并组合树形结构
        List<Resource> resources = getAllResources();
        Map<Integer,TreeNode> map = new HashMap<>();
        for(Resource resource : resources) {
            TreeNode node = new TreeNode();
            node.setId(resource.getId());
            node.setPId(resource.getParentId());
            node.setName(resource.getResourceName());
            node.setIcon(ResourceType.getEnumByCode(resource.getResourceType()).value());
            node.setChildren(new ArrayList<>());
            map.put(resource.getId(),node);
        }


        for(Resource resource : resources) {
            if(resource.getParentId()==0) {
                root = map.get(resource.getId());
                root.setOpen(true);
            } else {
                map.get(resource.getParentId()).getChildren().add(map.get(resource.getId()));
            }
        }

        out.add(root);
        return out;
    }

    @Override
    public List<TreeNode> loadAssignResources(Integer roleId) {
        List<TreeNode> out = new ArrayList<>();
        TreeNode root = new TreeNode();

        //基于角色查询已添加资源
        List<Integer> resourceIds = resourceMapper.getRoleResources(roleId);

        //查询所有的资源 并组合树形结构
        List<Resource> resources = getAllResources();
        Map<Integer,TreeNode> map = new HashMap<>();
        for(Resource resource : resources) {
            TreeNode node = new TreeNode();
            node.setId(resource.getId());
            node.setPId(resource.getParentId());
            node.setName(resource.getResourceName());
            node.setIcon(ResourceType.getEnumByCode(resource.getResourceType()).value());
            node.setChildren(new ArrayList<>());
            map.put(resource.getId(),node);
        }


        for(Resource resource : resources) {
            if(resourceIds.contains(resource.getId())) {
                map.get(resource.getId()).setChecked(true);
                map.get(resource.getId()).setOpen(true);
            }

            if(resource.getParentId()==0) {
                root = map.get(resource.getId());
                root.setOpen(true);
            } else {
                map.get(resource.getParentId()).getChildren().add(map.get(resource.getId()));
            }
        }

        out.add(root);
        return out;
    }

    @Override
    public int insertResource(Resource resource) {
        Resource isExist = resourceMapper.selectOne(new QueryWrapper<Resource>().lambda().eq(Resource::getResourceName, resource.getResourceName())
                .eq(Resource::getResourceUrl, resource.getResourceUrl()));
        if(isExist!=null) {
            return 0;
        }
        return resourceMapper.insert(resource);
    }

    @Override
    public int updateResource(Resource resource) {
        return resourceMapper.update(resource,new QueryWrapper<Resource>().lambda().eq(Resource::getId,resource.getId()));
    }

    @Override
    public int deleteResource(Integer id) {
        return resourceMapper.delete(new QueryWrapper<Resource>().lambda().eq(Resource::getId,id));
    }
}
