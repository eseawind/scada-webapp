var optionsQx = {
    chart: {
        renderTo: 'container',
        defaultSeriesType: 'spline',
        marginRight: 20,
        marginBottom: 25,
        backgroundColor:null
    },
    credits:false,
    title: {
        text: ''
    },
    xAxis: {
        categories: []
    },
    yAxis: {
        title: '',
        plotLines: [{
            value: 0,
            width: 1,
            color: '#808080'
        }],
        minPadding:0.5,
		min:0,
		startOnTick:true			
    },
    tooltip: {
			formatter: function() {
				if(this.series.name.indexOf("日")==0){
					var index=$.inArray(this.point,this.series.data) ;
					return '<b>'+ this.series.name +'</b><br/>'+
					this.x +': '+ this.y +this.series.options.unit+"<br/>"
					+'<b>去年同期 </b><br/>'+this.series.options.data1[index]
					+this.series.options.unit;
					
				}else{
					return '<b>'+ this.series.name +'</b><br/>'+
					this.x +': '+ this.y +this.series.options.unit;
					
				}
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

var optionsZz = {
    chart: {
                renderTo: 'container4',
                type: 'column'
            },
           title:null,
            xAxis: {
                categories: []
            },
            yAxis: {
                title: {
                    text: 'Total percent market share'
                }
            },
			legend: {
				enabled: false
		     },
            plotOptions: {
                column: {
                    //cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        color: null,
                        style: {
                            fontWeight: 'bold'
                        },
                        formatter: function() {
                            return this.y;
                        }
                    }
                }
            },
            series: []
}
var qxCharts_foot;
var qxCharts_foot_1;
function te(a,b,c,d,e,f){
    
    var series = { 
        data: []            
    };  
    
    series.data = a;
    series.name = b;
    series.unit = c;
    series.color = d;
    
    optionsQx.series = [];
    optionsQx.chart.renderTo=f;
    optionsQx.xAxis.categories=e;
    optionsQx.series.push(series);
    
    if(qxCharts_foot != null){
        qxCharts_foot.destroy(); 
        qxCharts_foot = null;
    }    
    qxCharts_foot = new Highcharts.Chart(optionsQx);
}	

function te1(a,b,c,d,e,f){
    
    var series = new Object();
    series.data = [];

//    alert(e);
    series.data = e;
    series.name = b;
    series.unit = c;
    series.color = d;
//    alert(series);
    optionsZz.series = [];
    optionsZz.chart.renderTo = f;
    optionsZz.xAxis.categories = a;
    optionsZz.yAxis.title.text = '';
    optionsZz.series.push(series);
    
    if(qxCharts_foot_1 != null){
        qxCharts_foot_1.destroy(); 
        qxCharts_foot_1 = null;
    }    
    qxCharts_foot_1 = new Highcharts.Chart(optionsZz);
}	