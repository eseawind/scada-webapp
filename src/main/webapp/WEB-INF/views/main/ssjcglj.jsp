<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>生产监控</title>        
        <link rel="stylesheet" type="text/css" href="${ctx}/static/dhtmlx/dhtmlx-zz.css">
        <link rel="stylesheet" type="text/css" href="${ctx}/static/style/css.css">
        <script type="text/javascript">
            var objUrl='${ctx}';
            var username='${username}';
        </script>
        <script src="${ctx}/static/dhtmlx/dhtmlx.js"></script>
        <script src="${ctx}/static/jquery/jquery-1.7.1.min.js"></script>
        <script src="${ctx}/static/js/highcharts.src.js"></script>
        <script src="${ctx}/static/js/chart.js"></script>
        <script src="${ctx}/static/js/chart1.js"></script>
        <script src="${ctx}/static/js/math.js"></script>
        <script src="${ctx}/static/js/common.js" type="text/javascript"></script>
        <script src="${ctx}/static/js/My97DatePicker/WdatePicker.js"></script>
        <script type="text/javascript" src="${ctx}/static/jquery/jquery.tmpl.min.js"></script>
        <script type="text/javascript" src="${ctx}/static/jquery/jquery.atmosphere.js"></script>
        <script type="text/javascript" src="${ctx}/static/jquery/jQuery.Tip.js"></script>
        <script type="text/javascript" src="${ctx}/static/jquery/jquery.comet.js"></script>
        <script type="text/javascript" src="${ctx}/static/js/util.js"></script>
        <script type="text/javascript" src="${ctx}/static/application.js"></script>
        <script type="text/javascript" src="${ctx}/static/gis/swfobject.js"></script>
        <script type="text/javascript" src="${ctx}/static/gis/gis.js"></script>
        <script>
            // 刷新标识
            var refFlag = true;
            var wellId_Gis;
            var dhxWins,dhxWins1,dhxWins2,dhxTabbar,dhLayout,lo,lc,ld,lh,Grid,Grid2,Grid3,dhxd,dhxd1,dhxd2,dhxd3,gr,yggr,yggr1,yggr2,rtugr,ygjgr;
            var dtu ='<div id="dt" style="width:100%; height:100%; background-color:#C3F"><img src="${ctx}/static/img/djgyt22.jpg"  style="width:100%; height:100%"></img></div>';
            var dtu1='<div id="dt1" style="width:100%; height:100%; background-color:#C3F"><img src="${ctx}/static/img/sgt.png"  style="width:100%; height:100%" /></div>';
            var dtu2='<div id="dt2" style="width:100%; height:100%; background-color:#C3F"><img src="${ctx}/static/img/dlt.png"  style="width:100%; height:100%" /></div>';
            var dtu3='<div id="dt3" style="width:100%; height:100%; background-color:#C3F"><img src="${ctx}/static/img/dgt.png"  style="width:100%; height:100%" /></div>';
            var dtu4='<div id="dt4" style="width:100%; height:100%; background-color:#C3F"><img src="${ctx}/static/img/yggl.png"  style="width:100%; height:100%" /></div>';
            var xb='<div id="gtc"  style="width:100%;height:100%;border-style:groove; border-width:1px;float:left" ><table><tr><td  style="width:250px" align="center">B相电压5次谐波:0.1</td><td  style="width:250px" align="center">B相电压7次谐波:0.2</td></tr><tr><td  style=" width:250px" align="center">B相电压11次谐波:0.3</td><td  style="width:250px" align="center">B相电压13次谐波:0.4</td></tr><tr><td  style="width:250px" align="center">B相电压17次谐波:0.5</td><td  style="width:250px" align="center">B相电压19次谐波:0.6</td></tr></table></div>';
            var gtdb='<div id="y"style="width:500px;height:30px;float:left;font-size:14px;"><table><tr><td  style="width:350px" align="left">&nbsp;&nbsp;&nbsp;日期:&nbsp;<input id="gtStart" type="text" onClick="WdatePicker({readOnly:true,dateFmt:\'yyyy/MM/dd HH时\'})" style="width:100px;"/>～<input id="gtEnd" type="text" onClick="WdatePicker({readOnly:true,dateFmt:\'yyyy/MM/dd HH时\'})" style="width:100px;"/>&nbsp;<button type="button" style="background:#81d4ff" onclick="run2();">查询</button></td></tr></table></div>';
            var ew='<div id="y" style="width:186px;height:100px;float:left;font-size:14px;"><table><tr><td style="width:250px" align="left">&nbsp;&nbsp;&nbsp;用户名:&nbsp;<input id="kz_name" name="kz_name" type="text" value="" style="width:95px;"/></td></tr><tr style="height:10px"></tr><tr><td  style="width:250px" align="left">&nbsp;&nbsp;&nbsp;密&nbsp;&nbsp;&nbsp;&nbsp;码:&nbsp;<input id="kz_password" name="kz_password" type="password" value=""  style="width:95px;"/></td></tr><tr style="height:10px"></tr><tr><td  style="width:250px" align="left">&nbsp;&nbsp;&nbsp;操作原因:&nbsp;<input id="kz_content" name="kz_content" type="text" value=""  style="width:80px;"/></td></tr><tr style="height:10px"></tr></table></div><div id="k" style="width:186px;height:60px;float:left"><table><tr><td style="width:98px;" align="center"><button type="button" style="background:#81d4ff" onclick="qd();">确定</button></td><td style="width:98px;" align="center"><button type="button" style="background:#81d4ff" onclick="qx();">取消</button></td></tr></table></div>';
            var anniu='<div id="k" style="width:186px;height:60px;float:left"><table><tr><td style="width:98px;" align="center"><button type="button" id="kz_kaijing" style="background:#81d4ff" onclick="kj();">开井</button></td><td style="width:98px;" align="center"><button type="button" id="kz_tingjing" style="background:#81d4ff" onclick="tj();">停井</button></td></tr></table></div>';
            var sd='<div id="y"style="width:180px;height:30px;float:left;"><table><tr><td style="width:250px" align="center">油井状态:开井</td></tr></table></div><div id="k" style="width:186px;height:60px;float:left"><table><tr><td style="width:98px;" align="center"><button type="button" style="background:#81d4ff" onclick="qdd();">确定</button><td><td style="width:98px;" align="center"><button type="button" style="background:#81d4ff" onclick="qxx();">取消</button><td></tr></table></div>';
            var yt='<div id="y"style="width:186px;height:100px;float:left;font-size:14px;"><table><tr><td style="width:250px" align="left">&nbsp;&nbsp;&nbsp;用户名:&nbsp;<input id="tc_name" name="tc_name" type="text" value="" style="width:95px;"/></td></tr><tr style="height:10px"></tr><tr><td  style="width:250px" align="left">&nbsp;&nbsp;&nbsp;密&nbsp;&nbsp;&nbsp;&nbsp;码:&nbsp;<input id="tc_password" name="tc_password" type="password" value=""  style="width:95px;"/></td></tr><tr style="height:10px"></tr><tr><td  style="width:250px" align="left">&nbsp;&nbsp;&nbsp;操作原因:&nbsp;<input id="tc_content" name="tc_content" type="text" value=""  style="width:80px;"/></td></tr><tr style="height:10px"></tr></table></div><div id="k" style="width:186px;height:60px;float:left"><table><tr><td style="width:98px;" align="center"><button type="button" style="background:#81d4ff" onclick="qd1();">确定</button><td><td style="width:98px;" align="center"><button type="button" style="background:#81d4ff" onclick="qx1();">取消</button><td></tr></table></div>';
            var yc='<div id="k" style="width:186px;height:60px;float:left"><table><tr><td style="width:98px;" align="center"><button type="button" style="background:#81d4ff" onclick="tc();">调参</button><td><td style="width:98px;" align="center"><button type="button" style="background:#81d4ff" onclick="tc_qx();">取消</button><td></tr></table></div>';
            var ytc='<div id="y"style="width:380px;height:60px;float:left"><table border="0" width="100%"><tr><td style="width:150px; " align="left">上行冲程(m)：<input id="tc_scch" name="tc_scch" type="text" value="" style="width:20px;"/></td><td style="width:150px; " align="left">上行冲次(min<SUP>-1</SUP>)：<input id="tc_scci" name="tc_scci" type="text" value="" style="width:20px;"/></td></tr><tr><td style="width:150px; ba" align="left">下行冲程(m)：<input id="tc_xcch" name="tc_xcch" type="text" value="" style="width:20px;"/></td><td style="width:150px; " align="left">下行冲次(min<SUP>-1</SUP>)：<input id="tc_xcci" name="tc_xcci"  type="text" value="" style="width:20px;"/></td></tr></table></div><div id="k" style="width:100%;height:60px;float:left"><table width="100%"><tr><td style="width:50%;" align="center"><button type="button" style="background:#81d4ff" onclick="qd2();">确定</button><td><td style="width:50%;" align="center"><button type="button" style="background:#81d4ff" onclick="qx2();">取消</button><td></tr></table></div>';

            // 选择曲线信息
            var rid_sel = '';
            var cid_sel = '';
            var flag_sel = '';
             
            var rid_sel_2 = '';
            var cid_sel_2 = '';
            var flag_sel_2 = '';
             
             // 选择井信息
            var selEndTagState = '';
            
            $(function () {
                wellId_Gis = ${info.id};
                
                // 页面布局设置
                createTabble();
                createGrid();
                createWindows();
                createWindows1();
                createWindow();
                createwind();
                createwind1();
                createwind2();
                createwi();
                createWin();
            });
            
            /**
             * 页面初始化
             * @returns {undefined}
             */
            function doOnLoad(){
                //工况信息
                createygGr();
                //Rtu状态
                creatertuGr();
                //电气参数
                createygdqGr();
                createygdqGr1();
                createygdqGr2();
                //井基本信息
                createygxnGr();
                // 设置电气参数
                createDq();
                // 示功图 电流曲线 电功图 有功功率曲线
                createAllQx('${info.code}');
                // 设置传感器设备信息
                createCgqGrid();
            }
           
           /**
            * 初始化曲线显示
            * @returns {undefined}
            */
            function initTab1(){
                 // tab1
                switch(flag_sel){
                    case '0':
                        doGrClick(rid_sel, cid_sel);
                        break;
                    case '3':
                        showGtqx(rid_sel, cid_sel);
                        break;
                    case '4':
                        showDyqx(rid_sel, cid_sel);
                        break;                        
                    case '5':                        
                        $("#gtStart").val(rid_sel);
                        $("#gtEnd").val(cid_sel);
                        run2();
                        break;
                    default:
                        if(gr.getRowsNum() > 0){                            
                            doGrClick(gr.getRowId(0), 0);
                        }
                }
            }
            /**
             * 初始化曲线显示
             * @returns {undefined}
             */
            function initTab2(){
                // tab2
                switch(flag_sel_2){
                    case '1':
                        doFzZzGrClick(rid_sel_2, cid_sel_2);
                        break;
                    case '2':
                        doFzGrClick(rid_sel_2, cid_sel_2);
                        break;
                    default:
                        if(yggr.getRowsNum() > 0){                            
                            doFzGrClick(yggr.getRowId(0), 0);
                        }
                }
            }

            /**
              * 电气参数信息点击
              * @param {type} dy_code
              * @param {type} dy_title
              * @returns {undefined}
              */
            function showDyqx(dy_code, dy_title){

                    rid_sel = dy_code;
                    cid_sel = dy_title;
                    flag_sel = '4';
                    
                    $("#container").html('');
                    $("#ssqxTitle").html('&nbsp&nbsp&nbsp（' + dy_title + '曲线）');
                    // 获得工况信息
                    $.ajax({
                        type: 'POST',
                        url: '${ctx}/realtime/linedata',
                        data:{code:'${info.code}',group:'DIAN_YC',varName:dy_code},
                        dateType:'json',
                        success: function(json){

                            var xAxisData = [];
                            var yAxisData = [];
                            $.each(json,function(key, value){

                                xAxisData.push(value.value);
                                
                                var dateTmp = new Date(value.date)
                                yAxisData.push(dateTmp.getHours() + ':' + dateTmp.getMinutes());
                            });

                            var ys;
                            if(j > 2){
                                j = 0;
                            }
                            ys = yse[j];	
                            te(xAxisData, dy_title, '', ys, yAxisData, 'container');//alert(xAxisData + '----' + yAxisData);
                            j += 1;
                        }
                    }); 
                            
                    $("#ssqx4").css("display","block");
                    $("#gtdb").css("display","none");                   
                }
                
                /**
             * 功图曲线显示
             * @returns {undefined}
             */
            function showGtqx(p_gtParKey, p_gtParTitle){
                
                rid_sel = p_gtParKey;
                cid_sel = p_gtParTitle;
                flag_sel = '3';
                    
                var dateNow = new Date();
                var dateBefore =  new Date(dateNow.getTime() - 1000 * 60 * 60);
                
                var startDate = dateBefore.getFullYear() + '/' + (dateBefore.getMonth() + 1) + '/' + dateBefore.getDate() + ' ' 
                        + dateBefore.getHours() + ':' + dateBefore.getMinutes();
                var endDate = dateNow.getFullYear() + '/' + (dateNow.getMonth() + 1) + '/' + dateNow.getDate() + ' ' 
                        + dateNow.getHours() + ':' + dateNow.getMinutes();
                
                // 获得井基本信息
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/realtime/arraywelldata',
                    data:{code:'${info.code}', startDate:startDate, endDate:endDate},
                    dateType:'json',
                    success: function(json){
                        // 横坐标
                        var str_xAxis = [];
                        // 纵坐标
                        var str_yAxis = [];
                        
                        $.each(json, function(key, value) {   
                            
                            str_xAxis.push(value[p_gtParKey]);
                                
                            var dateTmp = new Date(value.time)
                            str_yAxis.push(dateTmp.getHours() + ':' + dateTmp.getMinutes());
                        }); 
                        
                        var ys;
                        if(j > 2){
                            j = 0;
                        }
                        ys = yse[j];	//alert(str_xAxis + '----' + str_yAxis);
                        te(str_xAxis, p_gtParTitle, '', ys, str_yAxis, 'container');
                        j += 1;                           
                    }
                });
                      
                $("#ssqxTitle").html('&nbsp&nbsp&nbsp（' + p_gtParTitle + '）');
                $("#ssqx4").css("display","block");
                $("#gtdb").css("display","none");
            }
            
            /**
             * 信息点击
             * @param {type} gr_rId
             * @param {type} gr_cInd
             * @returns {undefined}             
             * */
            function doFzGrClick(gr_rId, gr_cInd){
                    
                    rid_sel_2 = gr_rId;
                    cid_sel_2 = gr_cInd;
                    flag_sel_2 = '2';
                    
                    var tmpName = gr_rId.split('||');
                    $("#dqqxTitle").html('&nbsp&nbsp&nbsp（' + tmpName[1] + '曲线）');
                    // 获得工况信息
                    $.ajax({
                        type: 'POST',
                        url: '${ctx}/realtime/linedata',
                        data:{code:'${info.code}',group:tmpName[2],varName:tmpName[0]},
                        dateType:'json',
                        success: function(json){

                            var xAxisData = [];
                            var yAxisData = [];
                            $.each(json,function(key, value){

                                xAxisData.push(value.value);
                                
                                var dateTmp = new Date(value.date)
                                yAxisData.push(dateTmp.getHours() + ':' + dateTmp.getMinutes());
                            });

                            var ys;
                            if(j > 2){
                                j = 0;
                            }
                            ys = yse[j];	
                            te(xAxisData, tmpName[1], '', ys, yAxisData, 'container2');//alert(xAxisData + '----' + yAxisData);
                            j += 1;
                        }
                    });                    
                }  
              
            /**
            * 电力信息

             * @returns {undefined}             */
            function createygdqGr(){
                yggr=new dhtmlXGridObject('ygdq1');
				yggr.setImagePath("${ctx}/static/dhtmlx/js/gridcodebase/imgs/");
				//dqgr.setNoHeader(true);//隐藏表头
				yggr.setHeader(["电力"]);
				yggr.setInitWidths("*");
				yggr.setColAlign("left");
				yggr.setColTypes("ro");
				yggr.init();
				// 获得电力信息
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/realtime/groupinfo',
                    data:{code:'${info.code}',group:'DIAN_YC'},
                    dateType:'json',
                    success: function(json){

                        var dataInfo = new Object();
                        dataInfo.rows = [];

                        $.each(json,function(key, value){

                            var dataItem = new Object();
                                dataItem.id = value.key + '||' + value.name + '||DIAN_YC';
                                dataItem.data = [];
                                dataItem.data.push(value.name + '：' + formatNumber(value.value, 2));

                                dataInfo.rows.push(dataItem);
                        });

                        yggr.parse(dataInfo,'json');                       
                        
                        initTab2();
                    }
                });                          
                 
                // 事件绑定
                yggr.attachEvent('onRowSelect', doFzGrClick); 
            }
             
            /**
            * 电量信息

             * @returns {undefined}             */
            function createygdqGr1(){
                yggr1=new dhtmlXGridObject('ygdq2');
				yggr1.setImagePath("js/gridcodebase/imgs/");
				//dqgr.setNoHeader(true);//隐藏表头
				yggr1.setHeader(["电量"]);
				yggr1.setInitWidths("*");
				yggr1.setColAlign("left");
				yggr1.setColTypes("ro");
				yggr1.init();
				// 获得电量信息
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/realtime/groupinfo',
                    data:{code:'${info.code}',group:'DIAN_YM'},
                    dateType:'json',
                    success: function(json){

                        var dataInfo = new Object();
                        dataInfo.rows = [];

                        $.each(json,function(key, value){

                            var dataItem = new Object();
                                dataItem.id = value.key + '||' + value.name + '||DIAN_YM';
                                dataItem.data = [];
                                dataItem.data.push(value.name + '：' + formatNumber(value.value, 2));

                                dataInfo.rows.push(dataItem);
                        });

                        yggr1.parse(dataInfo,'json');
                        initTab2();
                    }
                }); 
                // 事件绑定
                yggr1.attachEvent('onRowSelect', doFzGrClick); 
            }
            
            /**
             * 信息点击
             * @param {type} gr_rId
             * @param {type} gr_cInd
             * @returns {undefined}             
             * */
            function doFzZzGrClick(gr_rId, gr_cInd){
                    
                    rid_sel_2 = gr_rId;
                    cid_sel_2 = gr_cInd;
                    flag_sel_2 = '1';
                    
                    var tmpName = gr_rId.split('||');
                    $("#dqqxTitle").html('&nbsp&nbsp&nbsp（' + tmpName[1] + '）');
                    
                    var xAxisData = [];
                    var yAxisData = [];
                    
                    var colors = Highcharts.getOptions().colors;
                    
                    $.each(xbJson, function(key, value){

                        if(value.key == (tmpName[0] + '_array')){
                        
                            var valueTmp = value.value.split(',');// alert(valueTmp);
                            for(var loopTmp = 0; loopTmp < valueTmp.length; loopTmp++){
                                
                                xAxisData.push(loopTmp + 1); 
                                
                                var dataTmp = new Object();
                                dataTmp.y = accDiv(Math.round(accMul(valueTmp[loopTmp], 1000)), 1000);
                                dataTmp.color = colors[loopTmp % 9];

                                yAxisData.push(dataTmp);
                            }
                            
                            return false;
                        }                        
                    });

                    te1(xAxisData, tmpName[1], '', '', yAxisData, 'container2');//alert(xAxisData + '----' + yAxisData);
                }  
                
            var xbJson;
            /**
             * 谐波信息
             * @returns {undefined}
             */
            function createygdqGr2(){
                yggr2=new dhtmlXGridObject('ygdq3');
				yggr2.setImagePath("js/gridcodebase/imgs/");
				//dqgr.setNoHeader(true);//隐藏表头
				yggr2.setHeader(["谐波"]);
				yggr2.setInitWidths("*");
				yggr2.setColAlign("left");
				yggr2.setColTypes("ro");
				yggr2.init();
				// 获得电量信息
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/realtime/groupinfo',
                    data:{code:'${info.code}',group:'DIAN_XB'},
                    dateType:'json',
                    success: function(json){

                        xbJson = json;
                        var dataInfo = new Object();
                        dataInfo.rows = [];

                        $.each(json,function(key, value){

                            if(value.key.indexOf("_array") < 0){
                                
                            
                            var dataItem = new Object();
                                dataItem.id = value.key + '||' + value.name + '||DIAN_XB';
                                dataItem.data = [];
                                dataItem.data.push(value.name + '：' + formatNumber(value.value, 2));

                                dataInfo.rows.push(dataItem);
                                }
                        });

                        yggr2.parse(dataInfo,'json');
                        initTab2();
                    }
                });
                // 事件绑定
                yggr2.attachEvent('onRowSelect', doFzZzGrClick); 
            }
            /**
             * 页面布局设置
             * @returns {undefined}
             */
            function createTabble(){
                dhxTabbar=new dhtmlXTabBar('tabbl');
                dhxTabbar.setImagePath("${ctx}/static/dhtmlx/imgs/");
                dhxTabbar.addTab("tab1", "监测信息", "100px");
                dhxTabbar.addTab("tab2", "辅助信息", "100px");
                dhxTabbar.setTabActive("tab1");
                dhxTabbar.cells("tab1").attachObject("gk");
                dhxTabbar.cells("tab2").attachObject("fz");
            }
            var yse=['black','blue'];
            var j=0;
            var dyDate= [0.57,0.52,0.56,0.59,0.55,0.6,0.57,0.5,0.57,0.55,0.6,0.52,0.57,0.5,0.5,0.56,0.59,0.53,0.58,0.56,0.54,0.6,0.51,0.59,0.55,0.51,0.59,0.52,0.58,0.54,0.59,0.52,0.51,0.57,0.53,0.54,0.58,0.5,0.53,0.53,0.59,0.57,0.56,0.51,0.54,0.6,0.51,0.6,0.52,0.53,0.58,0.53,0.51,0.59,0.59,0.6,0.54,0.57,0.51,0.51,0.58,0.55,0.6,0.6,0.6,0.58,0.59,0.55,0.52,0.56,0.52,0.53,0.59,0.54,0.55,0.58,0.55,0.5,0.6,0.55,0.57,0.57,0.51,0.51,0.51,0.59,0.59,0.53,0.54,0.54,0.54,0.6,0.6,0.5,0.59,0.53,0.58,0.5,0.53,0.55,0.59,0.59,0.53,0.54,0.56,0.51,0.53,0.59,0.56,0.5,0.51,0.57,0.6,0.55,0.57,0.5,0.53,0.54,0.54,0.57,0.54,0.58,0.58,0.59,0.54,0.57,0.52,0.6,0.55,0.5,0.56,0.55,0.52,0.55,0.57,0.55,0.59,0.52,0.56,0.6,0.51,0.6,0.54,0.6,0.59,0.53,0.52,0.51,0.54,0.52,0.52,0.57,0.58,0.54,0.58,0.59,0.51,0.52,0.53,0.53,0.54,0.5,0.58,0.59,0.58,0.54,0.54,0.53,0.59,0.55,0.6,0.58,0.51,0.51,0.56,0.57,0.55,0.57,0.6,0.51,0.51,0.55,0.5,0.55,0.54,0.52,0.6,0.53,0.59,0.6,0.59,0.58,0.54,0.6,0.55,0.56,0.5,0.52,0.57,0.57,0.51,0.55,0.51,0.53,0.57,0.56,0.6,0.54,0.56,0.55,0.51,0.51,0.51,0.52,0.51,0.52,0.59,0.54,0.54,0.57,0.51,0.59,0.6,0.58,0.53,0.56,0.53,0.5,0.53,0.53,0.58,0.51,0.54,0.53,0.51,0.6,0.58,0.5,0.52,0.56,0.52,0.5,0.56,0.52,0.52,0.53,0.53,0.55,0.56,0.5,0.54,0.52,0.6,0.56,0.57,0.56,0.53,0.53,0.55,0.51,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null];
            
            /**
             * 信息点击
             * @param {type} gr_rId
             * @param {type} gr_cInd
             * @returns {undefined}             
             * */
            function doGrClick(gr_rId, gr_cInd){
                
                rid_sel = gr_rId;
                cid_sel = gr_cInd;
                flag_sel = '0';
                    
                    $("#ssqx4").css("display","block");
					$("#gtdb").css("display","none");
                    
                    var tmpName = gr_rId.split('||');
                    $("#ssqxTitle").html('&nbsp&nbsp&nbsp（' + tmpName[1] + '曲线）');
                    // 获得工况信息
                    $.ajax({
                        type: 'POST',
                        url: '${ctx}/realtime/linedata',
                        data:{code:'${info.code}',group:tmpName[2],varName:tmpName[0]},
                        dateType:'json',
                        success: function(json){

                            var xAxisData = [];
                            var yAxisData = [];
                            $.each(json,function(key, value){

                                xAxisData.push(value.value);
                                
                                var dateTmp = new Date(value.date)
                                yAxisData.push(dateTmp.getHours() + ':' + dateTmp.getMinutes());
                            });

                            var ys;
                            if(j > 2){
                                j = 0;
                            }
                            ys = yse[j];	
                            te(xAxisData, tmpName[1], '', ys, yAxisData, 'container');//alert(xAxisData + '----' + yAxisData);
                            j += 1;
                        }
                    });                    
                } 

            /**
             * 设置工况信息
             * @returns {undefined}
             */
            function createygGr(){
                
                gr=new dhtmlXGridObject('yg');
                gr.setImagePath("${ctx}/static/dhtmlx/js/gridcodebase/imgs/");
                gr.setNoHeader(true);               // 隐藏表头
                gr.setHeader(["序号"]);
                gr.setInitWidths("*");
                gr.setColAlign("left");
                gr.setColTypes("ro");
                gr.init();                        
                        
                // 获得工况信息
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/realtime/groupinfo',
                    data:{code:'${info.code}',group:'YOU_JING'},
                    dateType:'json',
                    success: function(json){

                        var youjingData = new Object();
                        youjingData.rows = [];

                        $.each(json,function(key, value){

                            if(value.key == 'qi_ting_zhuang_tai'){
                                if(value.value == 'false'){
                                    $("#youjingState").attr("src","${ctx}/static/img/hongse.png");
                                }else{
                                    $("#youjingState").attr("src","${ctx}/static/img/lse.png");
                                }
                            }else{

                                var youjingItem = new Object();
                                youjingItem.id = value.key + '||' + value.name + '||YOU_JING';
                                youjingItem.data = [];
//                                youjingItem.data.push(value.name + '：' + value.value);
                                if(value.value == 'false'){
                                    youjingItem.data.push(value.name + '：' + '<img src="${ctx}/static/img/hongse.png"/>');
                                }else if(value.value == 'true'){
                                    youjingItem.data.push(value.name + '：' + '<img src="${ctx}/static/img/lse.png"/>');
                                }else{
                                    youjingItem.data.push(value.name + '：' + formatNumber(value.value, 2));
                                }
                                youjingData.rows.push(youjingItem);
                            }
                        });

                        gr.parse(youjingData,'json');
                        
                        initTab1();
                    }
                });  
                
                // 事件绑定
                gr.attachEvent('onRowSelect', doGrClick);
            }
            
            /**
             * 设置RTU状态
             * @returns {undefined}
             */
            function creatertuGr(){
                
                rtugr=new dhtmlXGridObject('rtu');
                rtugr.setImagePath("${ctx}/static/dhtmlx/js/gridcodebase/imgs/");
                rtugr.setNoHeader(true);                   // 隐藏表头
                rtugr.setHeader(["序号","名称"]);
                rtugr.setInitWidths("129,*");
                rtugr.setColAlign("left,center");
                rtugr.setColTypes("ro,img");
                rtugr.init();
                
                // 获得RTU状态信息
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/realtime/groupinfo',
                    data:{code:'${info.code}',group:'RTU_ZHUANG_TAI'},
                    dateType:'json',
                    success: function(json){

                        var youjingData = new Object();
                        youjingData.rows = [];

                        $.each(json,function(key, value){

                            var youjingItem = new Object();
                            youjingItem.id = value.key + '||' + value.name + '||RTU_ZHUANG_TAI';
                            youjingItem.data = [];
                            youjingItem.data.push(value.name);
                            
                            if(value.value == 'false'){
                                youjingItem.data.push('${ctx}/static/img/hongse.png');
                            }else{
                                youjingItem.data.push('${ctx}/static/img/lse.png');
                            }

                                youjingData.rows.push(youjingItem);
                        });

                        rtugr.parse(youjingData,'json');
                        initTab1();
                    }
                });  
                   
                // 事件绑定
                rtugr.attachEvent('onRowSelect', doGrClick);
            }
            
            // 电气参数标题项目
            var strDqTitle = ',u_a,u_b,u_c,i_a,i_b,i_c,gl_ys,';
            /**
             * 设置电气参数
             * @returns {undefined}
             */
            function createDq(){

                // 获得电气参数信息
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/realtime/groupinfo',
                    data:{code:'${info.code}',group:'DIAN_YC'},
                    dateType:'json',
                    success: function(json){

                        $.each(json,function(key, value){

                            if(strDqTitle.indexOf(',' + value.key + ',') >= 0){
                                        
                                $("#dq_" + value.key).html(formatNumber(value.value, 2));
                            }
                        });
                        
                        initTab1();
                    }
                }); 
            }
            
            /**
            * 设置传感器运行信息
            * @returns {undefined}             
            * */
            function createGrid(){
                Grid= new dhtmlXGridObject('cgqyx2');
                Grid.setImagePath("js/gridcodebase/imgs/");
                Grid.setHeader(["传感器名","通讯状态","运行时间","剩余工作时间","剩余电量","标定"]);
                Grid.setInitWidths("145,60,115,115,115,*");
                Grid.setColAlign("center,center,center,center,center,center");
                Grid.setColTypes("ro,img,ro,ro,ro,img");
                Grid.init();
            
                Grid2= new dhtmlXGridObject('gr');
                Grid2.setImagePath("${ctx}/static/dhtmlx/js/gridcodebase/imgs/");
                Grid2.setHeader(["设备名称","出厂厂家","型号","序号","设备地址"]);
                Grid2.setInitWidths("120,200,120,70,*");
                Grid2.setColAlign("center,center,center,center,center");
                Grid2.setColTypes("ro,ro,ro,ro,ro");
                Grid2.init();
            
                // 获得传感器运行信息
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/realtime/sensor',
                    data:{code:'${info.code}'},
                    dateType:'json',
                    success: function(json){

                        var dataInfo = new Object();
                        dataInfo.rows = [];

                        $.each(json,function(key, value){

                            var dataItem = new Object();
                            dataItem.id = value.nickname;
                            dataItem.data = [];
                            dataItem.data.push(value.sensorname);  
                            if(value.cgq_rtu_status == 'false'){
                                dataItem.data.push('${ctx}/static/img/hongse.png');
                            }else{
                                dataItem.data.push('${ctx}/static/img/lse.png');
                            }
                            dataItem.data.push(formatNumber(value.cgq_rtu_time, 2));
                            dataItem.data.push(formatNumber(value.cgq_remained_time, 2));
                            dataItem.data.push(formatNumber(value.cgq_remained_dianliang, 2));                                    
                                    
                            if(value.cgq_rtu_status == 'false'){
                                dataItem.data.push('${ctx}/static/img/hongse.png');
                            }else{
                                dataItem.data.push('${ctx}/static/img/lse.png');
                            }

                            dataInfo.rows.push(dataItem);
                        });

                        Grid.parse(dataInfo,'json');
                    }
                });
            }
            /**
            * 设置传感器设备信息
            * @returns {undefined}             
            * */
            function createCgqGrid(){
            
                Grid2= new dhtmlXGridObject('gr');
                Grid2.setImagePath("${ctx}/static/dhtmlx/js/gridcodebase/imgs/");
                Grid2.setHeader(["设备名称","出厂厂家","型号","序号","设备地址"]);
                Grid2.setInitWidths("120,200,120,70,*");
                Grid2.setColAlign("center,center,center,center,center");
                Grid2.setColTypes("ro,ro,ro,ro,ro");
                Grid2.init();
            
                // 获得传感器设备信息
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/realtime/sensordevice',
                    data:{code:'${info.code}'},
                    dateType:'json',
                    success: function(json){

                        var dataInfo = new Object();
                        dataInfo.rows = [];

                        $.each(json,function(key, value){

                            var dataItem = new Object();
                            dataItem.id = value.id;
                            dataItem.data = [];
                            dataItem.data.push(value.name);
                            dataItem.data.push(value.manufacture);                                    
                            dataItem.data.push(value.type);
                            dataItem.data.push(value.number);
                            dataItem.data.push(value.address); 

                            dataInfo.rows.push(dataItem);
                        });

                        Grid2.parse(dataInfo,'json');
                    }
                });
            }
            
            /**
            * 设置井基本信息
            * @returns {undefined}             
            * */
            function createygxnGr(){
                ygjgr=new dhtmlXGridObject('jjb');
                ygjgr.setImagePath("${ctx}/static/dhtmlx/js/gridcodebase/imgs/");
                ygjgr.setNoHeader(true);//隐藏表头
                ygjgr.setHeader(["序号","名称"]);
                ygjgr.setInitWidths("315,*");
                ygjgr.setColAlign("left,left");
                ygjgr.setColTypes("ro,ro");
                ygjgr.init();
                
                // 获得井基本信息
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/realtime/etinfo',
                    data:{code:'${info.code}'},
                    dateType:'json',
                    success: function(json){

                        var loopId = 0;
                        var dataInfo = new Object();
                        dataInfo.rows = [];
                        
                        var dataItem;
                        
                        $.each(json,function(key, value){

                            loopId += 1;
                            if((loopId + 1) % 2 == 0){
                                
                                dataItem = new Object();
                                dataItem.id = loopId;
                                dataItem.data = [];
                            }
                            dataItem.data.push(key + ":" + value);  
                            
                            if(loopId % 2 == 0){
                                dataInfo.rows.push(dataItem);
                            }
                        });
                        
                        if((loopId + 1) % 2 == 0){
                            dataInfo.rows.push(dataItem);
                        }
                        
                        ygjgr.parse(dataInfo,'json');
                    }
                });
            }
            
            /**
             * 功图对比查询框生成
             * @returns {undefined}
             */
            function createWin(){
                dhxd4 = new dhtmlXWindows();
                dhxd4.attachViewportTo(document.body);
                dhxd4.createWindow("wa",800,200,350,65);
                dhxd4.window("wa").button('minmax2').hide();
                dhxd4.window("wa").button('minmax1').hide();
                dhxd4.window("wa").button('park').hide();
                dhxd4.window("wa").hide();
            }
            
            /**
             * 功图对比查询显示
             * @returns {undefined}
             */
            function sj(){
                if(!refFlag) return true;
                // 刷新标识
                refFlag = false;
                dhxd4.window("wa").show();
                dhxd4.window("wa").setText("功图对比");
                dhxd4.attachEvent("onClose", function(win){
                    dhxd4.window("wa").hide(); 
                    // 刷新标识
                    refFlag = true;
                });
                dhxd4.window("wa").attachHTMLString(gtdb);
            }
/**
             * 调参、控制弹出框
             * @returns {undefined}
             */
            function createwind(){
                dhxd = new dhtmlXWindows();
                dhxd.attachViewportTo(document.body);
                dhxd.createWindow("wi",800,200,200,180);
                dhxd.window("wi").button('minmax2').hide();
                dhxd.window("wi").button('minmax1').hide();
                dhxd.window("wi").button('park').hide();
                dhxd.window("wi").hide();
            }
            
            /**
             * 控制弹出框(开井、关井)
             * @returns {undefined}
             */
            function createwind1(){
                dhxd1 = new dhtmlXWindows();
                dhxd1.attachViewportTo(document.body);
                dhxd1.createWindow("wi1",800,200,180,70);
                dhxd1.window("wi1").button('minmax2').hide();
                dhxd1.window("wi1").button('minmax1').hide();
                dhxd1.window("wi1").button('park').hide();
                dhxd1.window("wi1").hide();
            }
            
            /**
             * 开井确认操作
             * @returns {undefined}
             */
            function createwind2(){
                dhxd2= new dhtmlXWindows();
                dhxd2.attachViewportTo(document.body);
                dhxd2.createWindow("wi2",800,200,180,100);
                dhxd2.window("wi2").button('minmax2').hide();
                dhxd2.window("wi2").button('minmax1').hide();
                dhxd2.window("wi2").button('park').hide();
                dhxd2.window("wi2").hide();
            }
            
            /**
             * 调参
             * @returns {undefined}
             */
            function createwi(){
                dhxd3= new dhtmlXWindows();
                dhxd3.attachViewportTo(document.body);
                dhxd3.createWindow("wi3",872,173,400,130);
                dhxd3.window("wi3").button('minmax2').hide();
                dhxd3.window("wi3").button('minmax1').hide();
                dhxd3.window("wi3").button('park').hide();
                dhxd3.window("wi3").hide();
            }
            
            /**
             * 远程控制
             * @returns {undefined}
             */
            function yckz(){
                if(!refFlag) return true;
                // 刷新标识
                refFlag = false;
                dhxd.window("wi").show();
                dhxd.window("wi").setText("远程控制");
                dhxd.attachEvent("onClose", function(win){
                    dhxd.window("wi").hide(); 
                    // 刷新标识
                    refFlag = true;
                });
                dhxd.window("wi").attachHTMLString(ew);
            }
            
            /**
             * 远程调参
             * @returns {undefined}
             */
            function yctc(){
                if(!refFlag) return true;
                // 刷新标识
                refFlag = false;
                dhxd.window("wi").show();
                dhxd.window("wi").setText("远程调参");
                dhxd.attachEvent("onClose", function(win){
                    dhxd.window("wi").hide(); 
                    // 刷新标识
                    refFlag = true;
                });
                dhxd.window("wi").attachHTMLString(yt);
            }
    
            /**
             * 远程控制窗口--确定事件
             * @returns {undefined}             
             * */
            function qd(){
                
                if($.trim($("#kz_name").val()) == ""){
                    alert("请输入用户名！");
                    return false;
                }else if($.trim($("#kz_password").val()) == ""){
                    alert("请输入密码！");
                    return false;
                }else if($.trim($("#kz_content").val()) == ""){
                    alert("请输入操作原因！");
                    return false;
                }
            
                // 用户验证
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/alarm/mobileLogin',
                    data:{username:$.trim($("#kz_name").val()),password:$.trim($("#kz_password").val())},
                    dateType:'json',
                    success: function(json){
                        if(json.state == "1"){
                            dhxd.window("wi").hide();
                            dhxd1.window("wi1").show();
                            dhxd1.window("wi1").setText("远程控制");
                            dhxd1.attachEvent("onClose", function(win){
                                dhxd1.window("wi1").hide(); 
                                // 刷新标识
                                refFlag = true;
                            });
                            dhxd1.window("wi1").attachHTMLString(anniu);

                            if(selEndTagState == "false"){
                                $("#kz_tingjing").attr({'disabled':'disabled'});
                                $("#kz_kaijing").removeAttr('disabled');
                            }else{                                
                                $("#kz_kaijing").attr({'disabled':'disabled'});
                                $("#kz_tingjing").removeAttr('disabled');
                            }  
                        }else{
                            alert("用户名或密码错误！");
                            return false;
                        }                        
                    }
                });                                
            }

            /**
             * 远程控制--取消
             * @returns {undefined}             
             * */
            function qx(){
                // 刷新标识
                refFlag = true;
                dhxd.window("wi").hide();
            }
            
            /**
             * 开井操作
             * @returns {undefined}             
             * */
            function kj(){
            
                dhxd1.window("wi1").hide();
                dhxd2.window("wi2").show();
                dhxd2.window("wi2").setText("远程控制");
                dhxd2.attachEvent("onClose", function(win){
                    dhxd2.window("wi2").hide(); 
                    // 刷新标识
                    refFlag = true;
                });
                dhxd2.window("wi2").attachHTMLString(sd);                 
            }
            
            /**
             * 停井操作
             * @returns {undefined}             
             * */
            function tj(){
                
                // 用户验证
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/manage/saveYkData',
                    data:{id:${info.id},state:"0",content:$.trim($("#kz_content").val())},
                    dateType:'json',
                    success: function(json){
                        if(json.state == "1"){
                            alert("调控成功！");
                        }else{
                            alert("调控发生错误，请重新操作或与管理员联系！");
                            return false;
                        }                        
                    }
                });
                  
                // 刷新标识
                refFlag = true;
                dhxd1.window("wi1").hide();	
            }
            
            /**
             * 开井确定操作
             * @returns {undefined}             
             * */
            function qdd(){
            
                // 用户验证
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/manage/saveYkData',
                    data:{id:${info.id},state:"1",content:$.trim($("#kz_content").val())},
                    dateType:'json',
                    success: function(json){
                        // 刷新标识
                        refFlag = true;
                        if(json.state == "1"){
                            alert("调控成功！");
                        }else{
                            alert("调控发生错误，请重新操作或与管理员联系！");
                            return false;
                        }                        
                    }
                });
                
                dhxd2.window("wi2").hide();	
            }
            
            /**
             * 开井取消操作
             * @returns {undefined}             
             * */
            function qxx(){
                // 刷新标识
                refFlag = true;
                dhxd2.window("wi2").hide();
            }
            
            /**
             * 远程调参窗口
             * @returns {Boolean}
             */
            function qd1(){
                 
                if($.trim($("#tc_name").val()) == ""){
                    alert("请输入用户名！");
                    return false;
                }else if($.trim($("#tc_password").val()) == ""){
                    alert("请输入密码！");
                    return false;
                }else if($.trim($("#tc_content").val()) == ""){
                    alert("请输入操作原因！");
                    return false;
                }
            
                // 用户验证
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/alarm/mobileLogin',
                    data:{username:$.trim($("#tc_name").val()),password:$.trim($("#tc_password").val())},
                    dateType:'json',
                    success: function(json){
                        if(json.state == "1"){
                            
                            dhxd.window("wi").hide();
                            dhxd1.window("wi1").show();
                            dhxd1.window("wi1").setText("远程调参");
                            dhxd1.attachEvent("onClose", function(win){
                                dhxd1.window("wi1").hide(); 
                                // 刷新标识
                                refFlag = true;
                            });
                            dhxd1.window("wi1").attachHTMLString(yc);
                        }else{
                            alert("用户名或密码错误！");
                            return false;
                        }                        
                    }
                }); 
            }
            
            /**
             * 远程调参--取消
             * @returns {undefined}             
             * */
            function qx1(){
                // 刷新标识
                refFlag = true;
                dhxd.window("wi").hide();
            }
            
            var tc_scch;
            var tc_scci;
            var tc_xcch;
            var tc_xcci;
            
            /**
             * 远程调参--确定
             * @returns {undefined}
             */
            function tc(){
                dhxd1.window("wi1").hide();
                dhxd3.window("wi3").show();
                dhxd3.window("wi3").setText("远程调参");
                dhxd3.attachEvent("onClose", function(win){
                    dhxd3.window("wi3").hide(); 
                    // 刷新标识
                    refFlag = true;
                }); 
            
                // 用户验证
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/manage/getYtData',
                    data:{id:${info.id}},
                    dateType:'json',
                    success: function(json){
                
                        dhxd3.window("wi3").attachHTMLString(ytc);
                        if(json != ""){
                            
                            tc_scch = (json.tc_scch == null ? "0" : json.tc_scch);
                            tc_scci = (json.tc_scci == null ? "0" : json.tc_scci);
                            tc_xcch = (json.tc_xcch == null ? "0" : json.tc_xcch);
                            tc_xcci = (json.tc_xcci == null ? "0" : json.tc_xcci);
                            
                            $("#tc_scch").val(tc_scch);
                            $("#tc_scci").val(tc_scci);
                            $("#tc_xcch").val(tc_xcch);
                            $("#tc_xcci").val(tc_xcci);
                        }                       
                    }
                });
            }
            
            /**
             * 远程调参--取消
             * @returns {undefined}
             */
            function tc_qx(){
               dhxd1.window("wi1").hide();
            }
            
            /**
             * 调参--确定
             * @returns {undefined}
             */
            function qd2(){
                
                if($.trim($("#tc_scch").val()) == ""){
                    alert("请输入上行冲程！");
                    return false;
                }else if($.trim($("#tc_scci").val()) == ""){
                    alert("请输入上行冲次！");
                    return false;
                }else if($.trim($("#tc_xcch").val()) == ""){
                    alert("请输入下行冲程！");
                    return false;
                }else if($.trim($("#tc_xcci").val()) == ""){
                    alert("请输入下行冲次！");
                    return false;
                }
            
                // 用户验证
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/manage/saveYtData',
                    data:{id:${info.id},content:$.trim($("#tc_content").val()),
                        scch:$.trim($("#tc_scch").val()) + "||" + tc_scch,scci:$.trim($("#tc_scci").val()) + "||" + tc_scci,
                        xcch:$.trim($("#tc_xcch").val()) + "||" + tc_xcch,xcci:$.trim($("#tc_xcci").val()) + "||" + tc_xcci},
                    dateType:'json',
                    success: function(json){
                        if(json.state == "1"){
                            alert("调参成功！");
                            dhxd3.window("wi3").hide();
                            // 刷新标识
                            refFlag = true;
                        }else{
                            alert("调参发生错误，请重新操作或与管理员联系！");
                            return false;
                        }                        
                    }
                }); 
            }
            
            /**
             * 调参--取消
             * @returns {undefined}
             */
            function qx2(){
                // 刷新标识
                refFlag = true;
                dhxd3.window("wi3").hide();
            }
            /**
             * 浮动窗口
             * @returns {undefined}
             */
            function createWindows(){
                dhxWins = new dhtmlXWindows();
                dhxWins.attachViewportTo(document.body);
                dhxWins.createWindow("win",200,100,1000,500);
                dhxWins.window("win").button('minmax2').hide();
                dhxWins.window("win").button('minmax1').hide();
                dhxWins.window("win").button('park').hide();
                dhxWins.window("win").hide();	
            }
            /**
             * 浮动窗口
             * @returns {undefined}
             */
            function createWindow(){
                dhxWins2 = new dhtmlXWindows();
                dhxWins2.attachViewportTo(document.body);
                dhxWins2.createWindow("win2",600,200,400,150);
                dhxWins2.window("win2").button('minmax2').hide();
                dhxWins2.window("win2").button('minmax1').hide();
                dhxWins2.window("win2").button('park').hide();
                dhxWins2.window("win2").hide();	
            }
            /**
             * 抽油杆受力分析
             * @returns {undefined}
             */
            function cyfslfx(){
                if(!refFlag) return true;
                // 刷新标识
                refFlag = false;
                dhxWins2.window("win2").show();
                dhxWins2.window("win2").setText("抽油杆受力分析");
                dhxWins2.attachEvent("onClose", function(win){
                    dhxWins2.window("win2").hide(); 
                    // 刷新标识
                    refFlag = true;
                });
                Grid3=dhxWins2.window("win2").attachGrid();;
                Grid3.setImagePath("${ctx}/static/dhtmlx/js/gridcodebase/imgs/");
                Grid3.setHeader(["序号","杆级","最大载荷","最小载荷"]);
                Grid3.setInitWidths("70,100,100,*");
                Grid3.setColAlign("center,center,center,center");
                Grid3.setColTypes("ed,ed,ed,ed");
                Grid3.setEditable(false);
                Grid3.init();
                
                // 获得井基本信息
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/realtime/cygshouli',
                    data:{code:'${info.code}'},
                    dateType:'json',
                    success: function(json){

                        var dataInfo = new Object();
                        dataInfo.rows = [];
                        
                        var dataItem;
                        
                        $.each(json,function(key, value){

                            dataItem = new Object();
                            dataItem.id = key + 1;
                            dataItem.data = [];
                                
                            dataItem.data.push(key + 1);
                            dataItem.data.push(value.index);
                            dataItem.data.push(value.minZaihe);
                            dataItem.data.push(value.maxZaiHe);
                            
                            dataInfo.rows.push(dataItem);
                        });
                        
                        Grid3.parse(dataInfo,'json');
                    }
                });
            }
            /**
            * 显示浮动窗口

             * @returns {undefined}             */
    function wins(){
	dhxWins.window("win").show();
	}
	/**
     * 浮动窗口
     * @returns {undefined}
     */
    function createWindows1(){
	dhxWins1 = new dhtmlXWindows();
	dhxWins1.attachViewportTo(document.body);
	dhxWins1.createWindow("win1",600,150,400,130);
	dhxWins1.window("win1").button('minmax2').hide();
	dhxWins1.window("win1").button('minmax1').hide();
	dhxWins1.window("win1").button('park').hide();
	dhxWins1.window("win1").hide();	
	}
    /**
     * 工况图片
     * @returns {Boolean}
     */
        function ztwin(){
            if(!refFlag) return true;
            // 刷新标识
            refFlag = false;
            dhxWins.window("win").show();
            dhxWins.window("win").setText("工况");
            dhxWins.attachEvent("onClose", function(win){
                dhxWins.window("win").hide(); 
                // 刷新标识
                refFlag = true;
   			});
            dhxWins.window("win").attachHTMLString(dtu);
        }
        
            /**
            * 即时功图读取
            * @returns {undefined}             
            * */
            function run1(){
                // 示功图 电流曲线 电功图 有功功率曲线
                createAllQx('${info.code}');
            }
            
            // 示功图
            var options1 = {
                chart: {
                    renderTo: '',
                    type: 'spline',
                    //borderWidth:1,
                    plotBorderWidth:1,
                    reflow:'true'
                },
                title: {
                    text: ''
                },
                xAxis: {
                    categories: [],
                    gridLineWidth:1,
                    title:{},
                    max:0
                },
                yAxis: {
                    title: {},
                    min:0				
                },
                tooltip: {
                    formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                    this.x +': '+ this.y +this.series.options.unit;//取得数据源中的值
                    }
                },
                legend: {
                    layout: 'horizontal',
                    align: 'center',
                    enabled:false,
                    verticalAlign: 'top',
                    x: -10,
                    y: -10,
                    borderWidth: 0
                },
                plotOptions: {
                    spline: {
                        marker: {
                            enabled: false,
                            states: {
                                hover: {
                                    enabled: true,
                                    symbol: 'circle',
                                    radius: 5,
                                    lineWidth: 1
                                }
                            }	
                        }
                    }
                },
                series: []
            }
            
            /**
             * 功图对比查询
             * @returns {undefined}
             */
            function run2(){
                
                if($("#gtStart").val() == ''){
                    alert('请选择查询开始日期！');
                    return;
                }else if($("#gtEnd").val() == ''){
                    alert('请选择查询截至日期！');
                    return;
                }
                
                var nowDate = new Date(dateSysNow);
                var startDate = new Date($("#gtStart").val().replace("时", "") + ':00:00');
                var endDate = new Date($("#gtEnd").val().replace("时", "") + ':00:00');
                
                if(endDate > nowDate || startDate > nowDate){
                    alert('选择查询日期不能大于当前时间，请重新选择！');
                    return;
                }else if(endDate < startDate){
                    alert('截至查询日期不能小于开始查询日期，请重新选择！');
                    return;
                }else if(parseInt(Math.abs(endDate - startDate)/1000/60/60) > 24){
                    alert('查询日期相差不能大于24小时，请重新选择！');
                    return;
                }
                
                rid_sel = $("#gtStart").val();
                cid_sel = $("#gtEnd").val();
                flag_sel = '5';
                    
                // 获得井基本信息
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/realtime/arraywelldata',
                    data:{code:'${info.code}', startDate:$("#gtStart").val().replace("时", "") + ':00', endDate:$("#gtEnd").val().replace("时", "") + ':00'},
                    dateType:'json',
                    success: function(json){
                        // 载荷，示功图纵坐标
                        var str_xAxis = [];
                        // 位移，示功图横坐标
                        var str_yAxis = [];
                        
                        $("#gtdb").html('');                        
                        $("#ssqxTitle").html('&nbsp&nbsp&nbsp（功图对比）');
                        $.each(json, function(key, value) {   
                            
                            $("#gtdb").append("<div id='container_gtdb_" + key + "' style='width: 200px; height: 100%; margin: 0 auto; float:left;'></div>");

                            var series = { 
                                data: []            
                            };  
                            
                            str_xAxis = value.weiyi;
                            str_yAxis = value.zaihe;
                            
                            var weiyiTmp1 = 0;
                            options1.series = [];
                            series.name = '示功图';
                            series.unit = 'm';
                            for (var i=0; i<str_xAxis.length; i++){

                                if((Number(str_xAxis[i])) > weiyiTmp1){
                                    weiyiTmp1 = str_xAxis[i];
                                }
                                series.data.push([str_xAxis[i],str_yAxis[i]]);
                            }
                            options1.chart.renderTo = 'container_gtdb_' + key;
                            var dateTmp = new Date(value.time);
                            options1.xAxis.max = Math.ceil(weiyiTmp1);
                            options1.xAxis.title.text = dateTmp.getFullYear() + "-" + (dateTmp.getMonth() + 1) + "-" 
                                    + dateTmp.getDate() + " " + dateTmp.getHours() + ":" + dateTmp.getMinutes();
                            options1.yAxis.title.text = '示&nbsp;&nbsp;功&nbsp;&nbsp;图';
                            options1.series.push(series);
                            new Highcharts.Chart(options1);                              
                        }); 
                    }
                });
                
                $("#ssqx4").css("display","none");
                $("#gtdb").css("display","block");
                dhxd4.window("wa").hide(); 
                // 刷新标识
                refFlag = true;
            }
            /**
            * 曲线显示

             * @param {type} i
             * @returns {undefined}             */
            function qxa(i){
                $("#ssqx4").css("display","block");
                $("#gtdb").css("display","none");
                var dqcs= document.all("dq"+i).innerHTML; 
                var qname=dqcs.split('：');
                var dqname=qname[0];
                if(j>2){
                    j=0;
                    }
                var ys=yse[j];
                te(dyDate,dqname,"V",ys);
                j+=1;
            }
            
            var i=1;
            /**
             * 工况信息拉伸
             * @returns {undefined}
             */
            function bd(){
                if(i%2==0){
                    $("#gk2").css("display","block");
                    $("#ba1").css("display","block");
                    $("#rtu").css("display","block");
                    $("#ba5").css("display","block");
                    $("#gk1").css("width","426px");
                    $("#gk4").css("width","424px");
                    $("#tb").css("width","175px");
                    $("#yg").css("width","172px");
                    $("#gkk1").css("width","110px");
                }else{
                    $("#gk2").css("display","none");
                    $("#ba1").css("display","none");
                    $("#rtu").css("display","none");
                    $("#ba5").css("display","none");
                    $("#gk1").css("width","631px");
                    $("#gk4").css("width","628px");
                    $("#tb").css("width","382px");
                    $("#yg").css("width","378px");
                    $("#gkk1").css("width","370px");
                    
				}
                i++;
                
                createygGr();
            }      
            
            // 弹出功图(4个)
            function sgtwin(p_flag){
                
                switch(p_flag){
                    // 示功图
                    case 1:
                        createSgForShow('${info.code}');
                        dhxWins.window("win").show();
                        dhxWins.window("win").setText("示功图");
                        dhxWins.attachEvent("onClose", function(win){
                            $("#dt1").hide();
                            dhxWins.window("win").hide(); 
                        });
                        $("#dt1").show();
                        dhxWins.window("win").attachObject("dt1");
                        break;
                    // 电流曲线
                    case 2:
                        createDlForShow('${info.code}');
                        dhxWins.window("win").show();
                        dhxWins.window("win").setText("电流曲线");
                        dhxWins.attachEvent("onClose", function(win){
                            $("#dt2").hide();
                            dhxWins.window("win").hide(); 
                        });
                        $("#dt2").show();
                        dhxWins.window("win").attachObject("dt2");
                        break;
                    // 功率曲线
                    case 3:
                        createDgForShow('${info.code}');
                        dhxWins.window("win").show();
                        dhxWins.window("win").setText("功率曲线");
                        dhxWins.attachEvent("onClose", function(win){
                            $("#dt3").hide();
                            dhxWins.window("win").hide(); 
                        });
                        $("#dt3").show();
                        dhxWins.window("win").attachObject("dt3");
                        break;
                    // 功率因数曲线
                    case 4:
                        createYgglForShow('${info.code}');
                        dhxWins.window("win").show();
                        dhxWins.window("win").setText("变频器输出功率曲线");
                        dhxWins.attachEvent("onClose", function(win){
                            $("#dt4").hide();
                            dhxWins.window("win").hide(); 
                        });
                        $("#dt4").show();
                        dhxWins.window("win").attachObject("dt4");
                        break;
                }
            }
        </script>
    </head>
    <body>
        <!--主界面-->
            <div id="zz" style="width:3845px; height:717px;border:1px solid #000;">
                <!--数据-->
                <div id="ssjcm" style="width:1280px; height:69px;  float:left; font-size: 0 " >
                    <%@ include file="ssjcCommon.jsp"%> 
                    <!--标签页 监测信息-->
                   <div id="tabbl" style="width:1280px; height:570px; float:left" ></div>
    	<div id="gk" style="width:1280px; height:560px" >
         <div id="ba" style="width:1280px; height:5px;  float:left" ></div>
         <div id="baa" style="width:5px; height:22px;  float:left" ></div>
         <div id="gk1" style="width:426px; height:22px;font-size:14px;line-height:25px; font-weight:bold; background-color:#FFE0BB; float:left">
            <table width="100%">
                <tr>
                    <td width="95%">&nbsp工&nbsp;&nbsp;&nbsp况</td>
                    <td style="text-align:left" width="5%"><a onclick="bd();" style="cursor:hand;text-decoration:none">《 </a></td>
                </tr>
            </table>
         </div>
         <div id="ba1" style="width:5px; height:22px; background-color:#FFF; float:left"></div>
         <div id="gk2" style="width:200px;font-size:14px;line-height:25px; font-weight:bold; height:22px; background-color:#C6CEFD; float:left">
         &nbspRTU&nbsp;&nbsp;&nbsp状&nbsp;&nbsp;&nbsp态
          </div>
          <div id="ba2" style="width:7px; height:22px; background-color:#FFF; float:left"></div>
           <div id="gk3" style="width:630px;font-size:14px;line-height:25px; font-weight:bold; height:22px; background-color:#a9d3ff;float:left">
         &nbsp功&nbsp;&nbsp;&nbsp图
          </div>
          <div id="bas" style="width:5px; height:22px;  float:left"></div>
          <div id="wai" style="width:636px; height:365px; float:left">
          	<div id="ba4" style="width:5px; height:154px;  float:left"></div>
             <div id="gk4" style="width:424px; height:152px; background-color:#FFF8EF;border:1px solid #FFBC6C; float:left">
          <div id="gkk" style="width:245px; height:152px; float:left ">
           <a  ondblclick="ztwin();" style="cursor:hand;text-decoration:none"><img src="${ctx}/static/img/djgyt22.jpg"  style="width:100%; height:151px" /></a>
          </div>
          
          <div id="gkk1" style="width:175px;height:153px; float:left">
            <div id="tb" style="width:175px; height:35px;float:left; font-size:14px; line-height:40px">
              &nbsp;&nbsp;&nbsp;油井启停：<img src="${ctx}/static/img/hongse.png"/>
            </div>
            <div id="yg" style="width:172px; height:107px; float:left;margin-left: 5px">
            </div>
     	  </div>
         </div>
         <!--RTU状态-->
          <div id="ba5" style="width:5px; height:154px;  float:left"></div>
          <div id="rtu" style="width:198px; height:152px;border:1px solid #BAC3FD;float:left">
              
           </div>
           <div id="ba8" style="width:636px; height:5px;  float:left"></div>
           <div id="ba8" style="width:5px; height:80px;  float:left"></div>
            <!--电气参数-->
              <div id="dqcs" style="width:629px; height:79px; float:right; border:1px solid #b4da72; float:left;background-color:#fbfff3">
                <div id="dqcs1" style=" width:629px; height:10; float:left;font-size:14px;line-height:25px; font-weight:bold; background-color:#d2e8ab">
                   &nbsp电&nbsp;&nbsp;&nbsp气&nbsp;&nbsp;&nbsp参&nbsp;&nbsp;&nbsp数
                </div>
                <div  id="dq0" class="cssdiv"  style="width:127px; height:23px;font-size:14px ;line-height:30px;float:left;cursor:pointer" onclick="showDyqx('u_a', 'A相电压');">
                    A相电压：<span id="dq_u_a">0</span>
                </div>
                <div id="dq1" class="cssdiv" style="width:127px; height:23px;font-size:14px;line-height:30px;float:left;cursor:pointer" onclick="showDyqx('u_b', 'B相电压');">
                    B相电压：<span id="dq_u_b">0</span>
                </div>
                <div id="dq2" class="cssdiv" style="width:127px; height:23px;font-size:14px;line-height:30px;float:left;cursor:pointer" onclick="showDyqx('u_c', 'C相电压');">
                    C相电压：<span id="dq_u_c">0</span>
                </div>
                <div id="dq6" class="cssdiv"  style="width:160px; height:23px;font-size:14px;line-height:30px;float:left;cursor:pointer" onclick="showDyqx('gl_ys', '平均功率因数');">
                    平均功率因数：<span id="dq_gl_ys">0</span>
                </div>
                <div  id="dq3" class="cssdiv"  style="width:127px; height:23px;font-size:14px;line-height:30px;float:left;cursor:pointer" onclick="showDyqx('u_a', 'A相电流');">
                    A相电流：<span id="dq_i_a">0</span>
                </div>
                <div  id="dq4" class="cssdiv"  style="width:127px; height:23px;font-size:14px;line-height:30px;float:left;cursor:pointer" onclick="showDyqx('i_b', 'B相电流');">
                    B相电流：<span id="dq_i_b">0</span>
                </div>
                <div  id="dq5" class="cssdiv"  style="width:127px; height:23px;font-size:14px;line-height:30px;float:left;cursor:pointer" onclick="showDyqx('i_c', 'C相电流');">
                    C相电流：<span id="dq_i_c">0</span>
                </div>
                
              </div>
              <div id="baq" style="width:636px; height:5px;  float:left"></div>
              <div id="ba9" style="width:5px; height:90px; float:left"></div>
             <!--传感器运行-->
              <div id="cgqyx" style="width:629px; height:115px; float:right; border:1px solid #fdbbfd; float:left">
            <div id="cgqyx1" style="width:629px; height:10; float:left;font-size:14px;line-height:25px; font-weight:bold; background-color:#fde7fd" >
            &nbsp传&nbsp;&nbsp;&nbsp感&nbsp;&nbsp;&nbsp器&nbsp;&nbsp;&nbsp运&nbsp;&nbsp;&nbsp行
            </div>
            <div id="cgqyx2" style=" width:628px; height:95px; float:left"></div>
          </div>
              
          </div>
           <!--功图-->
          <div id="ba6" style="width:7px; height:154px; float:left"></div>
          <div id="gt" style="width:630px; height:365px; border: 1px border #96c2ff; float:left">
          	<div style="width:629px;height:20px; background-color:#eef7ff;padding-top: 10px;padding-left:20px;">
                <div id="gt3" style="width:125px; float:left;padding-left:20px;background-repeat:no-repeat;  background-image: url(${ctx}/static/img/jsgt.png);">
                    <a onclick="run1();" style="cursor: hand;font-size:14px">即时功图读取</a>
                </div>
                <div id="gt4" style="width:105px; height:10; float:left;padding-left:20px;background-repeat:no-repeat;  background-image: url(${ctx}/static/img/gtdb.png);">
                    <a  onclick="sj();" style="cursor: hand;font-size:14px">功图对比</a>
                </div>
                <div id="gt5" style="width:131px; height:10; float:left;padding-left:20px;background-repeat:no-repeat;  background-image: url(${ctx}/static/img/cygsl.png);">
                    <a onclick="cyfslfx()" style=" cursor: hand;font-size:14px">抽油杆受力分析</a>
                </div>
                <div id="gt6" style="width:265px; height:10; float:left">
                </div>
             </div>
            <div id="gt7" style="width:160px; height:30px; font-size:14px;float:left; line-height:30px;background-color:#deeeff" align="center" >
                <a onclick="sgtwin(1);" style="cursor: hand;text-decoration:none">&nbsp示&nbsp功&nbsp图</a>
            </div>
            <div id="gt8" style="width:160px; height:30px;font-size:14px; float:left;line-height:30px; background-color:#deeeff" align="center" >
                <a onclick="sgtwin(2);" style="cursor: hand;text-decoration:none">&nbsp电&nbsp流&nbsp曲&nbsp线</a>
            </div>
            <div id="gt9" style="width:160px; height:30px; font-size:14px;float:left; line-height:30px;background-color:#deeeff" align="center" >
                <a onclick="sgtwin(3);" style="cursor: hand;text-decoration:none">&nbsp;功&nbsp;率&nbsp;曲&nbsp;线</a>
            </div>
            <div id="gt10" style="width:150px; height:30px;font-size:14px; float:left;line-height:30px; background-color:#deeeff" align="center" >
                <a onclick="sgtwin(4);" style="cursor: hand;text-decoration:none">变频器输出功率曲线</a>
            </div>
            <div id="gtt" style="width:158px; height:150px; line-height:30px;float:left">
                <div id="containerr" style="height:158px;width:150px; "></div>
            </div>
            <div id="gtt1" style="width:158px; height:10; float:left">
                <div id="containerr1" style="height:158px;width:150px; "></div>
            </div>
            <div id="gtt2" style="width:158px; height:10; float:left ">
                <div id="containerr2" style="height:158px;width:150px; "></div>
            </div>
            <div id="gtt3" style="width:120px; height:10; float:left " >
                <div id="containerr3" style="height:158px;width:150px; "></div>
            </div>
                <div id="gtcs" style="width:630px; height:25px; float:left;line-height:30px;font-size:14px; background-color:#deeeff">
                <table>
                <tr style="height:10px">&nbsp功&nbsp;&nbsp;&nbsp图&nbsp;&nbsp;&nbsp参&nbsp;&nbsp;&nbsp数
                </tr>
                 </table>
                </div>
                  <div id="gtc1" onclick="showGtqx('maxZaihe', '最大载荷');" style="cursor:hand; width:210px;line-height:25px; height:25px; font-size:14px;float:left; border-right:solid; border-right-color:#C4E1FF; border-right-width:1px " >
                                &nbsp;&nbsp;&nbsp;&nbsp;最大载荷(KN)：<span id="maxZaihe"></span>
                            </div>
                            <div id="gtc2" onclick="showGtqx('minZaihe', '最小载荷');" style="cursor:hand; width:210px; line-height:25px;height:25px; float:left; border-right:solid; border-right-color:#C4E1FF; border-right-width:1px;font-size:14px ">
                                &nbsp;&nbsp;&nbsp;&nbsp;最小载荷(KN)：<span id="minZaihe"></span>
                            </div>   
                            <div id="gtc3" onclick="showGtqx('bengXiao', '泵效');" style="cursor:hand; width:208px; line-height:25px;height:25px;font-size:14px; float:left">
                                &nbsp;&nbsp;&nbsp;&nbsp;泵效：<span id="bengXiao"></span>
                            </div>
                            <div id="gtc4" onclick="showGtqx('shangChongChengTime', '上冲程时间');" style="cursor:hand; width:210px; line-height:25px;height:25px; float:left; border-right:solid; border-right-color:#C4E1FF; border-right-width:1px;font-size:14px; background-color:#deeeff ">
                                &nbsp;&nbsp;&nbsp;&nbsp;上冲程时间(s)：<span id="shangChongChengTime"></span>
                            </div>
                            <div id="gtc5" onclick="showGtqx('xiaChongChengTime', '下冲程时间');" style="cursor:hand; width:210px; height:25px; line-height:25px;float:left; border-right:solid; border-right-color:#C4E1FF; border-right-width:1px;font-size:14px; background-color:#deeeff " >
                                &nbsp;&nbsp;&nbsp;&nbsp;下冲程时间(s)：<span id="xiaChongChengTime"></span>
                            </div>
                            <div id="gtc6" onclick="showGtqx('chongCi', '冲次');" style="cursor:hand; width:208px;line-height:25px; font-size:14px;height:25px; float:left; background-color:#deeeff" >
                                &nbsp;&nbsp;&nbsp;&nbsp;冲次(min<SUP>-1</SUP>)：<span id="chongCi"></span>
                            </div>
                            <div id="gtc7" onclick="showGtqx('nenghaoShang', '上冲程能耗');" style="cursor:hand; width:210px; line-height:25px;height:25px;font-size:14px; float:left; border-right:solid; border-right-color:#C4E1FF; border-right-width:1px " >
                                &nbsp;&nbsp;&nbsp;&nbsp;上冲程能耗(kWh)：<span id="nenghaoShang"></span>
                            </div>
                            <div id="gtc8" onclick="showGtqx('nenghaoXia', '下冲程能耗');" style="cursor:hand; width:210px;line-height:25px;font-size:14px; height:25px; float:left; border-right:solid; border-right-color:#C4E1FF; border-right-width:1px ">
                                &nbsp;&nbsp;&nbsp;&nbsp;下冲程能耗(kWh)：<span id="nenghaoXia"></span>
                            </div>
                            <div id="gtc9" onclick="showGtqx('pingHengDu', '平衡度');" style="cursor:hand; width:208px;line-height:25px; font-size:14px;height:25px; float:left" >
                                &nbsp;&nbsp;&nbsp;&nbsp;平衡度：<span id="pingHengDu"></span>
                            </div>
                            <div id="gtc10" onclick="showGtqx('riHaoDian', '单井日耗电量');" style="cursor:hand; width:210px;line-height:25px;font-size:14px; height:25px; float:left; border-right:solid; border-right-color:#C4E1FF; border-right-width:1px ; background-color:#deeeff">
                                &nbsp;&nbsp;&nbsp;&nbsp;日耗电量(kWh)：<span id="riHaoDian"></span>
                            </div>
                            <div id="gtc11" onclick="showGtqx('dianBiaoNum', '当前电表数');" style="cursor:hand; width:210px;line-height:25px; font-size:14px;height:25px; float:left; border-right:solid; border-right-color:#C4E1FF; border-right-width:1px; background-color:#deeeff " >
                                &nbsp;&nbsp;&nbsp;&nbsp;当前电表数：<span id="dianBiaoNum"></span>
                            </div>
                            <div id="gtc12" onclick="showGtqx('chanYeLiang', '产液量');" style="cursor:hand; width:208px; font-size:14px;line-height:25px;height:25px; float:left; background-color:#deeeff" >
                                &nbsp;&nbsp;&nbsp;&nbsp;产液量(t/d)：<span id="chanYeLiang"></span>
                            </div>                    
                             <div id="gtc13" style="width:208px; font-size:14px;line-height:25px;height:25px; float:left; border-right:solid; border-right-color:#C4E1FF; border-right-width:1px ">
                                &nbsp;&nbsp;&nbsp;&nbsp;诊断：<span id="falutDiagnoseInfo"></span>
                            </div> 
                    <div id="gtc14" style="width:210px;line-height:25px; height:30px; float:left; border-right:solid; border-right-color:#C4E1FF; border-right-width:1px " >
                    </div>
          </div>
         <div id="bia13" style="width:1280px;  height:5px;float:left; ""></div>
          <div id="bia2" style="width:5px;  height:17px; float:left "></div>
          <div id="ssqx3" style="width:315px; font-size:14px; font-weight:bold;height:10; float:left; background-color:#9fdfae" align="left" class="ss2">
            &nbsp油&nbsp;&nbsp;&nbsp罐
            </div>	
            <div id="bias" style="width:5px;  height:17px; float:left "></div>
            <div id="ssqxw" style="width:315px; font-size:14px; font-weight:bold;height:10; float:left; background-color:#9fdfae" align="left" class="ss2">
            &nbsp投&nbsp;&nbsp;&nbsp球&nbsp;&nbsp;&nbsp机
            </div>	
            <div id="biaq" style="width:5px;  height:17px; float:left "></div>
            <div id="ssqx23" style="width:315px; font-size:14px; font-weight:bold;height:10; float:left; background-color:#9fdfae" align="left" class="ss2">
            &nbsp水&nbsp;&nbsp;&nbsp套&nbsp;&nbsp;&nbsp炉
            </div>	
            <div id="biaq" style="width:5px;  height:17px; float:left "></div>
            <div id="ssqx23" style="width:310px; font-size:14px; font-weight:bold;height:10; float:left; background-color:#9fdfae" align="left" class="ss2">
            &nbsp中&nbsp;&nbsp;&nbsp频&nbsp;&nbsp;&nbsp除&nbsp;&nbsp;&nbsp蜡
            </div>	
            <div id="biaq1" style="width:5px;  height:17px; float:left "></div>
            <div id="biaq2" style="width:5px;  height:30px;  float:left "></div>
            <div id="yg" style="width:313px;  height:28px; background-color:#f5ffdc;border: 1px border #9fdfae; float:left; line-height:20px ">
            <table>
                     <tr>
                        <td  style="width:156px; font-size:14px; font-weight:bold" align="center">油温：500</td>
                        <td  style="width:156px; font-size:14px; font-weight:bold" align="center">液位：260</td>
                        <td  style="width:156px; font-size:14px; font-weight:bold" align="center">传感器：RTU</td>
                     </tr>
                </table>
            </div>
            <div id="biaq3" style="width:5px;  height:30px;  float:left "></div>
            <div id="tqj" style="width:313px;  height:28px;background-color:#f5ffdc; border: 1px border #9fdfae; float:left; line-height:20px ">
            <table>
                     <tr>
                        <td  style="width:156px; font-size:14px; font-weight:bold" align="center">状态：运行</td>
                        <td  style="width:156px; font-size:14px; font-weight:bold" align="center">投球数：200</td>
                        <td  style="width:156px; font-size:14px; font-weight:bold" align="center">频率：20</td>
                     </tr>
                </table>
            </div>
            <div id="biaq4" style="width:5px;  height:30px;  float:left "></div>
            <div id="stl" style="width:313px;  height:28px;background-color:#f5ffdc; border: 1px border #9fdfae; float:left; line-height:20px ">
            <table>
                     <tr>
                        <td  style="width:234px; font-size:14px; font-weight:bold" align="center">水温：500</td>
                        <td  style="width:234px; font-size:14px; font-weight:bold" align="center">水压：300</td>
                     </tr>
                </table>
            </div>
            <div id="biaq5" style="width:5px;  height:30px;  float:left "></div>
            <div id="zpcl" style="width:308px;  height:28px; background-color:#f5ffdc; border: 1px border #9fdfae; float:left; line-height:20px ">
            <table>
                     <tr>
                        <td  style="width:155px; font-size:14px; font-weight:bold" align="center">状态：OFF</td>
                        <td  style="width:155px; font-size:14px; font-weight:bold" align="center">电流大小：300</td>
                     </tr>
                </table>
            </div>
            <div id="biaq12" style="width:5px;  height:30px;  float:left "></div>
            <div id="biaq123" style="width:1280px;  height:5px;  float:left "></div>
            <div id="bi" style="width:5px;  height:19px;float:left "></div>
         <div id="ssqx2" style="width:1268px; height:135px; border: 1px border #8ed4ff; float:left" class="ss1">
          	<div id="ssqx3" style="width:1268px; font-size:14px; font-weight:bold;height:10; float:left; background-color:#8ed4ff" align="left" class="ss2">
            &nbsp实&nbsp;&nbsp;&nbsp时&nbsp;&nbsp;&nbsp曲&nbsp;&nbsp;&nbsp线
            <span id="ssqxTitle"></span>
            </div>	
            <div id="ssqx4" style="width:1268px; height:80px; float:left">
                <div id="div1" style="width:100%;height:100%;">
                    <div id="container" style="min-width: 90%; height: 100%; margin: 0 auto"></div>
                </div>
                <div id="div2" style="width:100%;height:100%; display: none ">
                    <div id="container1" style="min-width: 90%; height: 100%; margin: 0 auto"></div>
                </div>
                <div id="div4" style="width:100%;height:100%; display: none ">
                    <div id="container1122" style="min-width: 90%; height: 100%; margin: 0 auto"></div>
                </div>
            </div>
             <!--功图对比-->
                            <div id="gtdb" style="width:1268px; height:80px; float:left; display:none;overflow: auto">
                           </div> 
                        </div>
                      </div>
                    <!--辅助信息-->
                    <div id="fz" style="width:1280px; height:530px;">
                        <div id="fzx1" style="width:1280px; height:5px; float:left; "></div>
                        <div id="fzx" style="width:5px; height:22px; float:left; "></div>
                        <!--基本信息-->
                        <div id="jbxx" style="width:630px;font-size:14px; height:20px; float:left; background-color:#d2e8ab;border:solid;font-weight:bold; border-width:1px; border-color:#d2e8ab">
                            &nbsp井&nbsp;&nbsp;&nbsp基&nbsp;&nbsp;&nbsp本&nbsp;&nbsp;&nbsp信&nbsp;&nbsp;&nbsp息
                        </div>
                        <div id="fzx2" style="width:5px; height:22px; float:left;"></div>
                        <!--控制参数-->
                        <div id="kzcs" style="width:627px;font-size:14px; height:20px; float:left; background-color:#fcc8a0;border:solid;font-weight:bold; border-width:1px; border-color:#fcc8a0">
                            &nbsp控&nbsp;&nbsp;&nbsp制&nbsp;&nbsp;&nbsp参&nbsp;&nbsp;&nbsp数
                        </div>
                        <div id="kzc" style="width:5px; height:22px;  float:left; "></div>
                        <div id="baa" style="width:5px; height:220px;  float:left;"></div>
                        <div id="jjb" style="width:630px; height:217px; float:left; background-color:#ffffff;border: 1px border #d2e8ab">
                        </div>
                        <div id="bia" style="width:5px; height:217px; float:left; "></div>
                        <!--电气参数数据-->
                        <div id="dqsj" style="width:627px; height:50px; background-color:#ffffff; float:left; font-size:14px;border-color:1px solid #FFE0BB " >
                            <table>
                                  <tr style="height:10px"></tr>
                                  <tr>
                                     <td  style="width:200px; font-size:14px;" align="center">上冲程时间(s)：<span id="shangChongChengTime_fu"></span></td>
                                     <td  style="width:250px; font-size:14px;" align="center">下冲程时间(s)：<span id="xiaChongChengTime_fu"></span></td>
                                     <td  style="width:150px; font-size:14px;" align="center">冲次(min<SUP>-1</SUP>)：<span id="chongCi_fu"></span></td>
                                  </tr>
                             </table>
                        </div>
                        <div id="sy" style="width:629px;height:6px; float:left; " align="left"></div>
                        <div id="cgqs" style="width:627px; font-size:14px;height:10; font-weight:bold;background-color:#e6d5ff; float:left; border:1px solid #e6d5ff;" >&nbsp;传&nbsp;&nbsp;&nbsp感&nbsp;&nbsp;&nbsp器&nbsp;&nbsp;&nbsp设&nbsp;&nbsp;&nbsp备
                        </div>
                        <div id="gr" style="width:627px; height:140px; border:1px solid #e6d5ff; background-color:#FFE0BB; float:left">
                        </div>
                        <div id="bia2" style="width:1279px;height:5px; ; float:left; "></div>
                        <div id="bia23" style="width:5px; height:20px; ; float:left; "></div>
                        <!--电气参数-->
                        <div id="dqcss" style="width:1265px;font-size:14px; height:20px; float:left; background-color:#fdb4fd;border:solid; font-weight:bold;border-width:1px; border-color:#fdb4fd">&nbsp电&nbsp;&nbsp;&nbsp气&nbsp;&nbsp;&nbsp参&nbsp;&nbsp;&nbsp数
                        </div> 
                        <div id="bia4" style="width:5px; height:22px;  float:left; "></div>
                        <div id="bias" style="width:5px; height:140px;  float:left; "></div>
                        <div id="cs" style="width:1265px; height:138px; border: 1px border #fdb4fd;  float:left">
                            <div id="ygdq1" style="width:420px; height:138px; border: 1px border #fdb4fd;  float:left">                            
                            </div>
                            <div id="ygdq2" style="width:420px; height:138px; border: 1px border #fdb4fd;  float:left">                            
                            </div>
                            <div id="ygdq3" style="width:418px; height:138px; border: 1px border #fdb4fd;  float:left">
                            </div>
                        </div>
                        <div id="bia13" style="width:1340px; height:5px;float:left; "></div>
                        <div id="bia2" style="width:5px; height:22px; float:left "></div>
                        <div id="dqcsqx" style=" width:1268px; height:20px; font-size:14px;border-width:1px; background-color:#9fdfae; font-weight:bold;float:left">
                            &nbsp;电&nbsp;&nbsp;&nbsp气&nbsp;&nbsp;&nbsp参&nbsp;&nbsp;&nbsp数&nbsp;&nbsp;&nbsp曲&nbsp;&nbsp;&nbsp线
                            <span id="dqqxTitle"></span>
                        </div>
                        <div id="bia2" style="width:5px; height:20px; float:left;" ></div>
                        <div id="dqcsqxt" style=" width:1266px; height:95px; border: 1px border #9fdfae;  float:left" >
                            <div id="div3" style="width:100%;height:100%;">
                                <div id="container2" style="min-width: 90%; height: 100%; margin: 0 auto"></div>
                            </div>
                        </div>
                    </div>        
                </div>
                <!--地图-->
                <div id="dt" style="width:1280px;height:716px; border: 1px border #000; float:left;" >
                    <div  style="width:100%;height:100%; position: relative;">
                        <div id="flashContent" style="width:100%;" ></div>                        
                    </div>
                </div>
                <!--视频-->
                <div id="sp" style="width:1280px;height:716px; border: 1px border #000; float:left;" >
                    <img src="${ctx}/static/img/sp.png"  style="width:1280px;height:716px;"/>
                </div>
            </div>
            <!--浮上-->
            <div id="apDiv1">
                <div id="ad" style="width:70px; height:10; float:left; font-size:14px; font-weight:bold; line-height:25px">
                    &nbsp;&nbsp;&nbsp;井标识
                </div>
                <div id="ad2" style="width:350px; height:10;float:left; font-size:14px;line-height:25px">
                    运行&nbsp;<img src="${ctx}/static/img/lse.png" />&nbsp;&nbsp;
                    故障停井&nbsp;<img src="${ctx}/static/img/hongse.png" />&nbsp;&nbsp;
                    非正常停井&nbsp;<img src="${ctx}/static/img/zise.png" />&nbsp;&nbsp;
                    计划停井&nbsp;<img src="${ctx}/static/img/juse.png" />
                </div>
                <div id="ads" style="width:80px; height:10; float:left; font-size:14px; font-weight:bold; line-height:25px">
                    &nbsp;&nbsp;&nbsp;RTU标识
                </div>
                <div id="adr" style="width:290px; height:10;float:left; font-size:14px;line-height:25px">
                    运行&nbsp;<img src="${ctx}/static/img/lse.png" />&nbsp;&nbsp;
                    故障&nbsp;<img src="${ctx}/static/img/hongse.png" />&nbsp;&nbsp;
                    校验&nbsp;<img src="${ctx}/static/img/lansee.png" />
                </div>
                <div id="adw" style="width:20px; height:20px; float:left; font-size:14px; font-weight:bold;padding-top:3px">
                    <img src="${ctx}/static/img/yck.png"/>
                </div>
                <div id="adq" style="width:80px; height:20px; float:left; font-size:14px; font-weight:bold; line-height:23px">
                    <a style="cursor:hand"onclick="yckz();">远程控制</a>
                </div>
                <div id="adt" style="width:20px; height:20px; float:left; font-size:14px; font-weight:bold;padding-top:3px">
                    <img src="${ctx}/static/img/yct.png"/>
                </div>
                <div id="ady" style="width:60px; height:20px; float:left; font-size:14px; font-weight:bold; line-height:23px">
                    <a style="cursor:hand"onclick="yctc();">远程调参</a>
                </div>   
            </div>
            <div id="sztitle"></div>
        <div id="szda" style="width:300px;"></div>
        <div id="szan" >
            <c:if test="${sysmgr == 1}">
                <a href="${ctx}/main/mgr"><img border="0" src="${ctx}/static/img/sz.png" /></a>
            </c:if>
        </div>
        <div id="tcan" >
            <a href="${ctx}/logout"><img border="0" src="${ctx}/static/img/tc.png" /></a>
        </div>
        <!-- 示功图 -->
        <div id="dt1" style="width:950px; height:450px; display:none">
            <div id="containerr_sgt" style="width:950px; height:450px; "></div>
        </div>
        <!-- 电流曲线 -->
        <div id="dt2" style="width:950px; height:450px; display:none">
            <div id="containerr_dl" style="width:950px; height:450px; "></div>
        </div>
        <!-- 功率曲线 -->
        <div id="dt3" style="width:950px; height:450px; display:none">
            <div id="containerr_gl" style="width:950px; height:450px; "></div>
        </div>
        <!-- 功率因数曲线 -->
        <div id="dt4" style="width:950px; height:450px; display:none">
            <div id="containerr_ys" style="width:950px; height:450px; "></div>
        </div>
    </body>
</html>
