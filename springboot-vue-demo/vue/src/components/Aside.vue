<template>
  <el-menu
      style="width: 200px;min-height: calc(100vh - 50px);background:linear-gradient(0deg,#1deca4,#61b9dc)"
      :uniqueOpened="true"
      default-active="/news"
      class="el-menu-vertical-demo"
      router
      background-color="inherit"
      text-color="#fff"
      active-text-color="#ffd04b">
    <el-submenu index="/1">
      <template #title>系统管理</template>
      <el-menu-item index="/user" v-if="user.role===1">用户管理</el-menu-item>
    </el-submenu>
    <el-menu-item index="/book">书籍管理</el-menu-item>
    <el-menu-item index="/news">新闻管理</el-menu-item>
  </el-menu>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Aside",
  data(){
    return{
      user:{},
    }
  },
  created() {
    let userStr =sessionStorage.getItem("user") || '{}';
    this.user = JSON.parse(userStr);
//请求后端服务器，确认当前登录用户的合法性
    request.get("/api/user/"+this.user.id).then(res=>{
      if (res.code==='0'){
        this.user = res.data;
      }
    });
  },
  methods:{

  }
}
</script>

<style scoped>

</style>