(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-2d3fe79e"],{"09b9":function(t,e,a){"use strict";t.exports=Object.is||function(t,e){return t===e?0!==t||1/t===1/e:t!==t&&e!==e}},"29ca":function(t,e,a){"use strict";var n=a("2b5f"),s=a("45b1"),i=a("064d"),r=a("6337"),l=a("3a4d"),o=a("09b9"),c=a("199e"),d=a("f55d"),u=a("85ec");s("search",(function(t,e,a){return[function(e){var a=l(this),s=r(e)?void 0:d(e,t);return s?n(s,e,a):new RegExp(e)[t](c(a))},function(t){var n=i(this),s=c(t),r=a(e,n,s);if(r.done)return r.value;var l=n.lastIndex;o(l,0)||(n.lastIndex=0);var d=u(n,s);return o(n.lastIndex,l)||(n.lastIndex=l),null===d?-1:d.index}]}))},"2ebf":function(t,e,a){"use strict";a("4d84")},"4d84":function(t,e,a){},"571f":function(t,e,a){"use strict";a.d(e,"c",(function(){return s})),a.d(e,"b",(function(){return i})),a.d(e,"f",(function(){return r})),a.d(e,"a",(function(){return l})),a.d(e,"g",(function(){return o})),a.d(e,"d",(function(){return c})),a.d(e,"e",(function(){return d}));var n=a("b775");function s(t){return Object(n["a"])({url:"/site/getList",method:"post",data:t})}function i(t){return Object(n["a"])({url:"/site/getInfo",method:"post",data:t})}function r(t){return Object(n["a"])({url:"/site/saveInfo",method:"post",data:t})}function l(t){return Object(n["a"])({url:"/site/del",method:"post",data:t})}function o(t){return Object(n["a"])({url:"/site/setStatus",method:"post",data:t})}function c(t){return Object(n["a"])({url:"/site/getLoginToken",method:"post",data:t})}function d(t){return Object(n["a"])({url:"/site/getSelectSiteList",method:"post",data:t})}},e382:function(t,e,a){"use strict";a.r(e);var n=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"app-container",staticStyle:{padding:"0"}},[a("div",{staticClass:"search"},[a("p",[a("span",{staticClass:"label"},[t._v(t._s(t._f("lang")("选择站点"))+"：")]),a("el-select",{attrs:{size:"small",clearable:"",placeholder:t._f("lang")("请选择站点")},model:{value:t.search.site_id,callback:function(e){t.$set(t.search,"site_id",e)},expression:"search.site_id"}},t._l(t.siteList,(function(t){return a("el-option",{key:t.id,attrs:{label:t.title,value:t.id}})})),1)],1),a("p",[a("span",{staticClass:"label"},[t._v(t._s(t._f("lang")("注册时间"))+"：")]),a("el-date-picker",{staticStyle:{width:"340px"},attrs:{align:"right",type:"datetimerange",format:"yyyy-MM-dd HH:mm:ss","default-time":["00:00:00","23:59:59"],"range-separator":t._f("lang")("至"),"start-placeholder":t._f("lang")("时间开始"),"end-placeholder":t._f("lang")("时间结束"),size:"mini"},on:{change:t.dateChange},model:{value:t.search.date,callback:function(e){t.$set(t.search,"date",e)},expression:"search.date"}}),a("el-radio-group",{staticStyle:{"margin-left":"10px"},attrs:{size:"mini"},on:{change:t.dateTypeChange},model:{value:t.dateType,callback:function(e){t.dateType=e},expression:"dateType"}},[a("el-radio-button",{attrs:{label:"day0"}},[t._v(t._s(t._f("lang")("今天")))]),a("el-radio-button",{attrs:{label:"day1"}},[t._v(t._s(t._f("lang")("昨天")))]),a("el-radio-button",{attrs:{label:"day2"}},[t._v(t._s(t._f("lang")("前天")))])],1)],1),a("p",[a("span",{staticClass:"label"},[t._v(t._s(t._f("lang")("用户ID"))+"：")]),a("el-input",{staticStyle:{width:"120px"},attrs:{type:"text",size:"mini",clearable:"",placeholder:t._f("lang")("请输入用户id")},model:{value:t.search.user_id,callback:function(e){t.$set(t.search,"user_id",e)},expression:"search.user_id"}})],1),a("p",[a("span",{staticClass:"label"},[t._v(t._s(t._f("lang")("昵称"))+"：")]),a("el-input",{staticStyle:{width:"160px"},attrs:{type:"text",size:"mini",clearable:"",placeholder:t._f("lang")("请输入昵称")},model:{value:t.search.keyword,callback:function(e){t.$set(t.search,"keyword",e)},expression:"search.keyword"}})],1),a("p",{staticStyle:{"padding-top":"10px"}},[a("span",{staticClass:"label"}),a("el-button",{attrs:{type:"primary",icon:"el-icon-check",size:"mini"},on:{click:t.doSearch}},[t._v(t._s(t._f("lang")("筛选")))]),a("el-button",{staticStyle:{"margin-left":"10px"},attrs:{type:"default",plain:"",size:"mini"},on:{click:t.doInit}},[t._v(t._s(t._f("lang")("重置")))])],1)]),a("div",{staticClass:"box-panel",staticStyle:{"padding-bottom":"10px","margin-bottom":"0"}},[a("el-table",{attrs:{data:t.dataList,stripe:"",size:"medium","header-cell-class-name":"bg-gray"}},[a("el-table-column",{attrs:{prop:"id",label:t._f("lang")("用户ID"),width:"80"}}),a("el-table-column",{attrs:{prop:"create_time",label:t._f("lang")("注册时间"),width:"160"}}),a("el-table-column",{attrs:{prop:"avatar",label:t._f("lang")("头像昵称"),width:"240"},scopedSlots:t._u([{key:"default",fn:function(e){return[a("img",{staticStyle:{height:"36px"},attrs:{src:e.row.avatar}}),t._v(t._s(e.row.nickname)+" ")]}}])}),a("el-table-column",{attrs:{prop:"phone",label:t._f("lang")("手机号"),width:"160"}}),a("el-table-column",{attrs:{label:t._f("lang")("对话余额"),width:"120"},scopedSlots:t._u([{key:"default",fn:function(e){return[t._v(" "+t._s(e.row.balance)+" "+t._s(t._f("lang")("条"))+" ")]}}])}),a("el-table-column",{attrs:{label:t._f("lang")("GPT4余额"),width:"120"},scopedSlots:t._u([{key:"default",fn:function(e){return[t._v(" "+t._s(e.row.balance_gpt4)+" "+t._s(t._f("lang")("万字"))+" ")]}}])}),a("el-table-column",{attrs:{label:t._f("lang")("绘画余额"),width:"140"},scopedSlots:t._u([{key:"default",fn:function(e){return[t._v(" "+t._s(e.row.balance_draw)+" "+t._s(t._f("lang")("张"))+" ")]}}])}),a("el-table-column",{attrs:{label:t._f("lang")("会员"),width:"200"},scopedSlots:t._u([{key:"default",fn:function(e){return[t._v(" "+t._s(e.row.vip_expire_time)+" ")]}}])}),a("el-table-column",{attrs:{label:t._f("lang")("共消费"),width:"120"},scopedSlots:t._u([{key:"default",fn:function(e){return[t._v(" "+t._s(e.row.order_total)+" 元 ")]}}])}),a("el-table-column",{attrs:{label:t._f("lang")("共提问")},scopedSlots:t._u([{key:"default",fn:function(e){return[t._v(" "+t._s(e.row.msg_count)+" 条 ")]}}])})],1),a("div",{staticClass:"footer"},[a("div",{staticClass:"tongji"},[a("i",{staticClass:"el-icon-s-data text-green",staticStyle:{"font-size":"20px"}}),t._v(" "+t._s(t._f("lang")("共"))+" "),a("span",{staticClass:"text-green"},[t._v(" "+t._s(t.tongji.userCount)+" ")]),t._v(" "+t._s(t._f("lang")("用户"))+"，"+t._s(t._f("lang")("对话余额"))+" "),a("span",{staticClass:"text-danger"},[t._v(" "+t._s(t.tongji.userBalance)+" ")]),t._v(" "+t._s(t._f("lang")("条"))+" ")]),a("el-pagination",{attrs:{"current-page":t.page,"page-size":t.pagesize,layout:"total, prev, pager, next",total:t.dataTotal},on:{"current-change":t.pageChange}})],1)],1)])},s=[],i=(a("cac0"),a("29ca"),a("f7c6"),a("0f4e"),a("f4f1"),a("f208"),a("fb0e"),a("30f8"),a("c24f")),r=a("571f"),l={data:function(){return{dataList:[],dataTotal:0,page:1,pagesize:15,dateType:"",search:{date:[],site_id:"",user_id:"",keyword:""},tongji:{userCount:0,userBalance:0},siteList:[]}},created:function(){this.doInit()},methods:{doInit:function(){this.dateType="",this.search={date:[],site_id:"",user_id:"",keyword:""},this.doSearch(),this.getSiteList()},getList:function(){var t=this,e=Object.assign(this.search,{page:this.page,pagesize:this.pagesize});Object(i["e"])(e).then((function(e){t.dataList=e.data.list,t.dataTotal=e.data.count})),1===this.page&&Object(i["d"])(e).then((function(e){t.tongji=e.data}))},getSiteList:function(){var t=this;Object(r["e"])().then((function(e){t.siteList=e.data}))},tableIndex:function(t){return this.pagesize*(this.page-1)+t+1},pageChange:function(t){this.page=t,this.getList()},doSearch:function(){this.page=1,this.getList()},dateChange:function(){this.dateType=""},dateTypeChange:function(){var t="",e=this.dateFormat(new Date,"yyyy-MM-dd"),a=this.dateFormat(new Date((new Date).setDate((new Date).getDate()-1)),"yyyy-MM-dd"),n=this.dateFormat(new Date((new Date).setDate((new Date).getDate()-2)),"yyyy-MM-dd");"day0"===this.dateType?t=e:"day1"===this.dateType?t=a:"day2"===this.dateType&&(t=n),this.search.date=[t+" 00:00:00",t+" 23:59:59"]},dateFormat:function(t,e){var a={"M+":t.getMonth()+1,"d+":t.getDate(),"h+":t.getHours(),"m+":t.getMinutes(),"s+":t.getSeconds(),"q+":Math.floor((t.getMonth()+3)/3),S:t.getMilliseconds()};for(var n in/(y+)/.test(e)&&(e=e.replace(RegExp.$1,(t.getFullYear()+"").substr(4-RegExp.$1.length))),a)new RegExp("("+n+")").test(e)&&(e=e.replace(RegExp.$1,1===RegExp.$1.length?a[n]:("00"+a[n]).substr((""+a[n]).length)));return e}}},o=l,c=(a("2ebf"),a("1805")),d=Object(c["a"])(o,n,s,!1,null,"2f15fdec",null);e["default"]=d.exports},f208:function(t,e,a){"use strict";var n=a("bbaf"),s=a("add4"),i=a("e0ec"),r=a("218c"),l=a("0257").get,o=RegExp.prototype,c=TypeError;n&&s&&r(o,"dotAll",{configurable:!0,get:function(){if(this!==o){if("RegExp"===i(this))return!!l(this).dotAll;throw new c("Incompatible receiver, RegExp required")}}})},f4f1:function(t,e,a){"use strict";var n=a("bbaf"),s=a("e817"),i=a("9372"),r=a("e253"),l=a("8a85"),o=a("e488"),c=a("1490").f,d=a("3a6e"),u=a("4b9a"),f=a("199e"),p=a("7454"),g=a("8421"),h=a("6abb"),_=a("696a"),b=a("6368"),y=a("c668"),v=a("0257").enforce,m=a("71ff"),w=a("ee0d"),x=a("add4"),S=a("fafb"),k=w("match"),C=s.RegExp,E=C.prototype,T=s.SyntaxError,I=i(E.exec),j=i("".charAt),D=i("".replace),R=i("".indexOf),M=i("".slice),z=/^\?<[^\s\d!#%&*+<=>@^][^\s!#%&*+<=>@^]*>/,O=/a/g,L=/a/g,$=new C(O)!==O,A=g.MISSED_STICKY,F=g.UNSUPPORTED_Y,Y=n&&(!$||A||x||S||b((function(){return L[k]=!1,C(O)!==O||C(L)===L||"/a/i"!==String(C(O,"i"))}))),q=function(t){for(var e,a=t.length,n=0,s="",i=!1;n<=a;n++)e=j(t,n),"\\"!==e?i||"."!==e?("["===e?i=!0:"]"===e&&(i=!1),s+=e):s+="[\\s\\S]":s+=e+j(t,++n);return s},H=function(t){for(var e,a=t.length,n=0,s="",i=[],r={},l=!1,o=!1,c=0,d="";n<=a;n++){if(e=j(t,n),"\\"===e)e+=j(t,++n);else if("]"===e)l=!1;else if(!l)switch(!0){case"["===e:l=!0;break;case"("===e:I(z,M(t,n+1))&&(n+=2,o=!0),s+=e,c++;continue;case">"===e&&o:if(""===d||y(r,d))throw new T("Invalid capture group name");r[d]=!0,i[i.length]=[d,c],o=!1,d="";continue}o?d+=e:s+=e}return[s,i]};if(r("RegExp",Y)){for(var P=function(t,e){var a,n,s,i,r,c,g=d(E,this),h=u(t),_=void 0===e,b=[],y=t;if(!g&&h&&_&&t.constructor===P)return t;if((h||d(E,t))&&(t=t.source,_&&(e=p(y))),t=void 0===t?"":f(t),e=void 0===e?"":f(e),y=t,x&&"dotAll"in O&&(n=!!e&&R(e,"s")>-1,n&&(e=D(e,/s/g,""))),a=e,A&&"sticky"in O&&(s=!!e&&R(e,"y")>-1,s&&F&&(e=D(e,/y/g,""))),S&&(i=H(t),t=i[0],b=i[1]),r=l(C(t,e),g?this:E,P),(n||s||b.length)&&(c=v(r),n&&(c.dotAll=!0,c.raw=P(q(t),a)),s&&(c.sticky=!0),b.length&&(c.groups=b)),t!==y)try{o(r,"source",""===y?"(?:)":y)}catch(m){}return r},B=c(C),J=0;B.length>J;)h(P,C,B[J++]);E.constructor=P,P.prototype=E,_(s,"RegExp",P,{constructor:!0})}m("RegExp")},fb0e:function(t,e,a){"use strict";var n=a("bbaf"),s=a("8421").MISSED_STICKY,i=a("e0ec"),r=a("218c"),l=a("0257").get,o=RegExp.prototype,c=TypeError;n&&s&&r(o,"sticky",{configurable:!0,get:function(){if(this!==o){if("RegExp"===i(this))return!!l(this).sticky;throw new c("Incompatible receiver, RegExp required")}}})}}]);