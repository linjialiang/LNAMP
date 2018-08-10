# `phpcms` 推送相关

## `phpcms v9` 在删除推送的数据时会报错
> 编辑该文件 `/phpcms/model/content_model.class.php`
> - 将461行 注释掉
> - 修改完成后 需要更新缓存

```php
<?php
// ...

private function update_category_items($catid,$action = 'add',$cache = 0) {
    $this->category_db = pc_base::load_model('category_model');
    if($action=='add') {
        $this->category_db->update(array('items'=>'+=1'),array('catid'=>$catid));
    }  else {
        //$this->category_db->update(array('items'=>'-=1'),array('catid'=>$catid));//注释掉这句
    }
    if($cache) $this->cache_items();
}

//...
```

## `phpcms v9` 推送时添加 自定义字段（主表）
> 编辑该文件 `/phpcms/modules/content/classes/push_api.class.php`
> - 在 `'sysadd'=>1` 下面（46行下面）按照 `'字段名'=>'$r['字段名']` 的格式在下面添加需要推送的主表字段
> - 修改完成后 需要更新缓存

```php
<?php
// ...
foreach($id_arr as $id) {
    $this->db->table_name = $tablename;
    $r = $this->db->get_one(array('id'=>$id));
    $linkurl = preg_match('/^http:\/\//',$r['url']) ? $r['url'] : siteurl($siteid).$r['url'];
    foreach($ids as $catid) {
        $siteid = $siteids[$catid];
        $this->categorys = getcache('category_content_'.$siteid,'commons');
        $modelid = $this->categorys[$catid]['modelid'];
        $this->db->set_model($modelid);
            $newid = $this->db->insert(
            array('title'=>$r['title'],
                'style'=>$r['style'],
                'thumb'=>$r['thumb'],
                'keywords'=>$r['keywords'],
                'description'=>$r['description'],
                'status'=>$r['status'],
                'catid'=>$catid,
                'url'=>$linkurl,
                'sysadd'=>1,
                'username'=>$r['username'],
                'inputtime'=>$r['inputtime'],
                'updatetime'=>$r['updatetime'],
                'zidingyi01'=>$r['zidingyi01'], // 自定义字段1（主表）
                'zidingyi02'=>$r['zidingyi02'], // 自定义字段2（主表）
                'zidingyi03'=>$r['zidingyi03'], // 自定义字段3（主表）
                'islink'=>1
            ),true);
            $this->db->table_name = $this->db->table_name.'_data';
            $this->db->insert(array('id'=>$newid));
            $hitsid = 'c-'.$modelid.'-'.$newid;
            $this->hits_db->insert(array('hitsid'=>$hitsid,'catid'=>$catid,'updatetime'=>SYS_TIME));
    }
}


//...
```

## `phpcms v9` 推送时添加 自定义字段（_data表）
> 编辑该文件 `/phpcms/modules/content/classes/push_api.class.php`
> 1. 找到69行，并注释掉 `$this->db->insert(array('id'=>$newid));`
> 2. 在69行下面添加内容（见代码）
> 3. 使用 `'字段名'=>'$info['字段名']` 的格式在下面添加需要推送的副表字段
> 4. 修改完成后 需要更新缓存
```php
<?php
// ...
foreach($ids as $catid) {
    $siteid = $siteids[$catid];
    $this->categorys = getcache('category_content_'.$siteid,'commons');
    $modelid = $this->categorys[$catid]['modelid'];
    $this->db->set_model($modelid);
        $newid = $this->db->insert(
        array('title'=>$r['title'],
            'style'=>$r['style'],
            'thumb'=>$r['thumb'],
            'keywords'=>$r['keywords'],
            'description'=>$r['description'],
            'status'=>$r['status'],
            'catid'=>$catid,
            'url'=>$linkurl,
            'sysadd'=>1,
            'username'=>$r['username'],
            'inputtime'=>$r['inputtime'],
            'updatetime'=>$r['updatetime'],                            
            'islink'=>1
        ),true);
        $this->db->table_name = $this->db->table_name.'_data';
        // $this->db->insert(array('id'=>$newid));  // 注释官方的
        // 推送_data表字段内容，需要添加下面代码
        $info = $this->db->get_content($catid,$id);
        $this->db->insert(
            array(
                'id'=>$newid,   // 这个必须存在
                'zidingyi1'=>$info['zidingyi1'], // 自定义字段1（_data表）
                'zidingyi2'=>$info['zidingyi2'], // 自定义字段2（_data表）
                'zidingyi3'=>$info['zidingyi3'], // 自定义字段3（_data表）
                )
        );
        $hitsid = 'c-'.$modelid.'-'.$newid;
        $this->hits_db->insert(array('hitsid'=>$hitsid,'catid'=>$catid,'updatetime'=>SYS_TIME));
}
//...
```
