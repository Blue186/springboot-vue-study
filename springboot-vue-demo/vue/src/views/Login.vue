<template>
<div style="width: 100%;height: 100vh; background: linear-gradient(90deg,#3cadeb,#9c88ff);display: flex;justify-content: center;align-items: center">
  <div style="width: 300px; height: 380px;box-shadow: 0 5px 15px rgba(0, 0, 0, .8); display: flex;justify-content: center;align-items: center;">
    <el-form :model="form" size="normal" style="height: 100% ;width: 220px;" ref="form" :rules="rules">
      <div style="width: 100%;height: 40px;margin-top:10px;line-height: 40px;text-align: center">
        <span style="color: white;font-weight: 900;font-size: 30px;">Login</span>
      </div>
      <el-form-item style="margin-top: 50px" prop="username">
        <el-input v-model="form.username"  prefix-icon="el-icon-user-solid" placeholder="请输入用户名"></el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input v-model="form.password" prefix-icon="el-icon-lock" placeholder="请输入密码" show-password></el-input>
      </el-form-item>
      <el-form-item>
        <el-button style="color: white; border-radius: 30px;width: 100%;height: 50px;background: linear-gradient(90deg,#3cadeb,#9c88ff);" @click="login">登录</el-button>
      </el-form-item>
      <el-form-item style="text-align: center; color: white;">
        <a @click="toRegister" style="font-size: 16px;font-weight: 500;opacity: 0.8;text-decoration: underline">注册</a>
      </el-form-item>
    </el-form>
  </div>
</div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Login",
  data(){
    return{
      form:{},
      rules: {
        username: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
        ],
      }
    }
  },
  created() {
    sessionStorage.removeItem("user");
  },
  methods:{
    toRegister(){
      this.$router.push("/register")
    },
    login(){
      this.$refs['form'].validate((valid) => {
        if (valid) {
          request.post("/api/user/login",this.form).then(res => {
            console.log(res);
            if (res.code==='0'){
              this.$message({
                type: "success",
                message: "登录成功"
              })
              console.log("res.date:"+res.data)
              sessionStorage.setItem("user",JSON.stringify(res.data));//缓存用户信息
              this.$router.push("/");//登录成功后的页面跳转
            }else {
              this.$message({
                type: "error",
                message: res.msg
              })
            }
          })
        } else {
          console.log('error submit!!');
          return false;
        }
      });

    }
  }
}
</script>

<style scoped>

</style>
