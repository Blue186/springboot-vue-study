<template>
  <div style="padding-left:10px; padding-right: 10px; width: calc(100vw - 200px)">
    <!--    功能趋于-->
    <div style="margin: 10px 0">
      <el-button type="warning" plain @click="add">新增</el-button>
      <el-button type="primary" plain>导入</el-button>
      <el-button type="primary" plain>导出</el-button>
    </div>
    <!--    搜索区域-->
    <div style="margin: 10px 0">
      <el-input v-model="search" placeholder="请输入关键字" style="width: 20%" clearable></el-input>
      <el-button style="margin-left: 5px; background-color: #5defc1; color: white" @click="load" plain>查询</el-button>
    </div>
    <el-table
        :data="tableData"
        border
        stripe
        style="width: 100%">
      <el-table-column
          prop="id"
          label="ID"
          sortable>
      </el-table-column>
      <el-table-column
          prop="title"
          label="标题">
      </el-table-column>
      <el-table-column
          prop="author"
          label="作者">
      </el-table-column>
      <el-table-column
          prop="time"
          label="发布时间">
      </el-table-column>

      <el-table-column
          fixed="right"
          label="操作">

        <template #default="scope">
          <div style="display: flex; align-content: space-between">
            <el-button @click="details(scope.row)" type="primary">详情</el-button>
            <el-button @click="handleEdit(scope.row)" type="primary">编辑</el-button>
            <el-popconfirm
                title="确定删除吗？" @confirm="handleDelete(scope.row.id)">
              <template #reference>
                <el-button type="danger">删除</el-button>
              </template>
            </el-popconfirm>
          </div>
        </template>
      </el-table-column>

    </el-table>



    <div style="margin: 10px 0">
      <el-pagination
          background
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="currentPage4"
          :page-sizes="[5, 10, 20]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
      <!--弹窗-->
      <el-dialog
          title="提示"
          v-model="dialogVisible"
          width="50%">
        <el-form :model="form" label-width="120px">
          <el-form-item label="标题">
            <el-input v-model="form.title" style="width: 50%"></el-input>
          </el-form-item>

          <div id="div1">

          </div>
        </el-form>
        <template #footer>
          <span class="dialog-footer">
            <el-button @click="dialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
          </span>
        </template>
      </el-dialog>

      <el-dialog
          title="详情"
          v-model="vis"
          width="50%">

          <el-card>
            <div v-html="detail.content" style="min-height: 150px;">

            </div>
          </el-card>
      </el-dialog>

    </div>
  </div>
</template>

<script>

import E from 'wangeditor';
import request from "@/utils/request";
let editor;
let Edi;
export default {
  name: 'News',
  components: {

  },
  data() {
    return {
      form: {},
      search:'',
      currentPage4: 1,
      pageSize: 10,
      total:0,
      dialogVisible:false,
      tableData: [],
      detail:{},
      vis:false
    }
  },
  created() {
    this.load();
  },
  mounted() {

  },
  methods:{
    load(){
      request.get("/api/news",{
        params: {
          pageNum: this.currentPage4,
          pageSize: this.pageSize,
          search: this.search
        }
      }).then(res =>{
        console.log(res);
        this.tableData = res.data.records;
        this.total = res.data.total;
      })
    },

    creatDom(){
      editor = new E('#div1');//富文本编辑器创建
      // 配置 server 接口地址
      editor.config.uploadImgServer = 'http://localhost:9090/files/editor/upload';
      editor.config.uploadFileName = 'file';
      editor.create();
    },

    add(){
      this.dialogVisible = true;
      this.form = {};

      this.$nextTick(()=>{
        this.creatDom();
      });
    },
    save(){
      this.form.content = editor.txt.html();//获取富文本编辑器中的值，放到form中


      if (this.form.id){//更新
        request.put("/api/news",this.form).then(res =>{
          console.log(res);
          if (res.code==='0'){
            this.$message({
              type: "success",
              message: "更新成功"
            })
          }else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
          this.load();//刷新表格数据
          this.dialogVisible = false;//关闭弹窗
        });
      }else {//新增
        let userStr = sessionStorage.getItem("user") ||'{}';
        let user = JSON.parse(userStr);
        this.form.author = user.nickName;//赋值

        request.post("/api/news",this.form).then(res =>{
          console.log(res);
          if (res.code==='0'){
            this.$message({
              type: "success",
              message: "新增成功"
            })
          }else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
          this.load();//刷新表格数据
          this.dialogVisible = false;//关闭弹窗
        });
      }

    },
    handleEdit(row){
      this.form = JSON.parse((JSON.stringify(row)));
      this.dialogVisible = true;
      this.$nextTick(()=>{
        this.creatDom();
        editor.txt.html(row.content);
      });
    },
    handleSizeChange(pageSize){//改变当前页面个数
      this.pageSize = pageSize;
      this.load();
    },
    handleCurrentChange(pageNum){//改变当前页码
      this.currentPage4 = pageNum;
      this.load();
    },
    handleDelete(id){
      console.log(id);
      request.delete("/api/news/"+id).then(res => {
        if (res.code==='0'){
          this.$message({
            type: "success",
            message: "删除成功"
          })
        }else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
        this.load()//重新加载
      });
    },

    filesUploadSuccess(res){
      console.log(res);
      this.form.cover = res.data;
      this.load();
    },
    details(row){
      this.detail = row;
      this.vis = true;
    }

  }
}
</script>
