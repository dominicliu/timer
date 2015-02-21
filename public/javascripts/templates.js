Ember.TEMPLATES["application"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Ember.Handlebars.helpers); data = data || {};
  var buffer = '', stack1;


  data.buffer.push("<div class=\"container\">\r\n	");
  stack1 = helpers._triageMustache.call(depth0, "outlet", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["ID"],data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\r\n</div>");
  return buffer;
  
});

Ember.TEMPLATES["index"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Ember.Handlebars.helpers); data = data || {};
  var buffer = '', stack1, helper, options, helperMissing=helpers.helperMissing, escapeExpression=this.escapeExpression;


  data.buffer.push("<div class=\"text-center\">\r\n<h1>timer</h1>\r\n<table>\r\n	<tr>\r\n		<td>");
  data.buffer.push(escapeExpression((helper = helpers.input || (depth0 && depth0.input),options={hash:{
    'type': ("text"),
    'value': ("hours"),
    'id': ("hours"),
    'disabled': ("running"),
    'insert-newline': ("start")
  },hashTypes:{'type': "STRING",'value': "ID",'id': "STRING",'disabled': "ID",'insert-newline': "STRING"},hashContexts:{'type': depth0,'value': depth0,'id': depth0,'disabled': depth0,'insert-newline': depth0},contexts:[],types:[],data:data},helper ? helper.call(depth0, options) : helperMissing.call(depth0, "input", options))));
  data.buffer.push("</td>\r\n		<td class=\"colon\">:</td>\r\n		<td>");
  data.buffer.push(escapeExpression((helper = helpers['focus-input'] || (depth0 && depth0['focus-input']),options={hash:{
    'type': ("text"),
    'value': ("minutes"),
    'id': ("minutes"),
    'disabled': ("running"),
    'insert-newline': ("start")
  },hashTypes:{'type': "STRING",'value': "ID",'id': "STRING",'disabled': "ID",'insert-newline': "STRING"},hashContexts:{'type': depth0,'value': depth0,'id': depth0,'disabled': depth0,'insert-newline': depth0},contexts:[],types:[],data:data},helper ? helper.call(depth0, options) : helperMissing.call(depth0, "focus-input", options))));
  data.buffer.push("</td>\r\n		<td class=\"colon\">:</td>\r\n		<td>");
  data.buffer.push(escapeExpression((helper = helpers.input || (depth0 && depth0.input),options={hash:{
    'type': ("text"),
    'value': ("seconds"),
    'id': ("seconds"),
    'disabled': ("running"),
    'insert-newline': ("start")
  },hashTypes:{'type': "STRING",'value': "ID",'id': "STRING",'disabled': "ID",'insert-newline': "STRING"},hashContexts:{'type': depth0,'value': depth0,'id': depth0,'disabled': depth0,'insert-newline': depth0},contexts:[],types:[],data:data},helper ? helper.call(depth0, options) : helperMissing.call(depth0, "input", options))));
  data.buffer.push("</td>\r\n	</tr>\r\n	<tr>\r\n		<td class=\"caption\">hours</td>\r\n		<td></td>\r\n		<td class=\"caption\">minutes</td>\r\n		<td></td>\r\n		<td class=\"caption\">seconds</td>\r\n	</tr>\r\n</table>\r\n<p>\r\n	<button ");
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "start", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["STRING"],data:data})));
  data.buffer.push(" ");
  data.buffer.push(escapeExpression(helpers['bind-attr'].call(depth0, {hash:{
    'disabled': ("running")
  },hashTypes:{'disabled': "ID"},hashContexts:{'disabled': depth0},contexts:[],types:[],data:data})));
  data.buffer.push("><img class=\"icon\" src=\"images/start.jpg\">start</button>\r\n	<button ");
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "pause", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["STRING"],data:data})));
  data.buffer.push(" ");
  data.buffer.push(escapeExpression(helpers['bind-attr'].call(depth0, {hash:{
    'disabled': ("notRunning")
  },hashTypes:{'disabled': "ID"},hashContexts:{'disabled': depth0},contexts:[],types:[],data:data})));
  data.buffer.push("><img class=\"icon\" src=\"images/pause.jpg\">pause</button>\r\n	<button ");
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "stop", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["STRING"],data:data})));
  data.buffer.push(" ");
  data.buffer.push(escapeExpression(helpers['bind-attr'].call(depth0, {hash:{
    'disabled': ("notRunningOrPaused")
  },hashTypes:{'disabled': "ID"},hashContexts:{'disabled': depth0},contexts:[],types:[],data:data})));
  data.buffer.push("><img class=\"icon\" src=\"images/stop.jpg\">stop</button>\r\n	<button ");
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "restart", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["STRING"],data:data})));
  data.buffer.push(" ");
  data.buffer.push(escapeExpression(helpers['bind-attr'].call(depth0, {hash:{
    'disabled': ("notRunningOrPaused")
  },hashTypes:{'disabled': "ID"},hashContexts:{'disabled': depth0},contexts:[],types:[],data:data})));
  data.buffer.push("><img class=\"icon\" src=\"images/restart.jpg\">restart</button>\r\n	<button ");
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "snooze", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["STRING"],data:data})));
  data.buffer.push("><img class=\"icon\" src=\"images/snooze.jpg\">snooze</button>\r\n</p>\r\n<p>\r\n	");
  data.buffer.push(escapeExpression((helper = helpers.input || (depth0 && depth0.input),options={hash:{
    'type': ("checkbox"),
    'checked': ("notification"),
    'id': ("notification"),
    'disabled': ("notificationDenied")
  },hashTypes:{'type': "STRING",'checked': "ID",'id': "STRING",'disabled': "ID"},hashContexts:{'type': depth0,'checked': depth0,'id': depth0,'disabled': depth0},contexts:[],types:[],data:data},helper ? helper.call(depth0, options) : helperMissing.call(depth0, "input", options))));
  data.buffer.push("\r\n	<label for=\"notification\">notification</label>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;\r\n	");
  data.buffer.push(escapeExpression((helper = helpers.input || (depth0 && depth0.input),options={hash:{
    'type': ("checkbox"),
    'checked': ("sound"),
    'id': ("sound")
  },hashTypes:{'type': "STRING",'checked': "ID",'id': "STRING"},hashContexts:{'type': depth0,'checked': depth0,'id': depth0},contexts:[],types:[],data:data},helper ? helper.call(depth0, options) : helperMissing.call(depth0, "input", options))));
  data.buffer.push("\r\n	<label for=\"sound\">sound</label>\r\n</p>\r\n<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\r\n	<button type=\"button\" ");
  data.buffer.push(escapeExpression(helpers['bind-attr'].call(depth0, {hash:{
    'class': (":btn isStudying:btn-primary:btn-default")
  },hashTypes:{'class': "STRING"},hashContexts:{'class': depth0},contexts:[],types:[],data:data})));
  data.buffer.push(" ");
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "setMode", "study", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0,depth0],types:["STRING","STRING"],data:data})));
  data.buffer.push(">study</button>\r\n	<button type=\"button\" ");
  data.buffer.push(escapeExpression(helpers['bind-attr'].call(depth0, {hash:{
    'class': (":btn isWorking:btn-primary:btn-default")
  },hashTypes:{'class': "STRING"},hashContexts:{'class': depth0},contexts:[],types:[],data:data})));
  data.buffer.push(" ");
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "setMode", "work", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0,depth0],types:["STRING","STRING"],data:data})));
  data.buffer.push(">work</button>\r\n	<button type=\"button\" ");
  data.buffer.push(escapeExpression(helpers['bind-attr'].call(depth0, {hash:{
    'class': (":btn isPlaying:btn-primary:btn-default")
  },hashTypes:{'class': "STRING"},hashContexts:{'class': depth0},contexts:[],types:[],data:data})));
  data.buffer.push(" ");
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "setMode", "play", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0,depth0],types:["STRING","STRING"],data:data})));
  data.buffer.push(">play</button>\r\n</div>\r\n<div class=\"space\"></div>\r\n<div class=\"space\"></div>\r\n<div class=\"space\"></div>\r\n<p>\r\n	study: ");
  stack1 = helpers._triageMustache.call(depth0, "studyTimeFormatted", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["ID"],data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push(" &nbsp;&nbsp; work: ");
  stack1 = helpers._triageMustache.call(depth0, "workTimeFormatted", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["ID"],data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push(" &nbsp;&nbsp; play: ");
  stack1 = helpers._triageMustache.call(depth0, "playTimeFormatted", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["ID"],data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\r\n</p>\r\n<p class=\"copyright\">© 2014-2015 Dominic Liu</p>");
  return buffer;
  
});