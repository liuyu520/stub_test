/**
 * Created by 黄威 on 5/6/16.
 */
$(function () {
    $('.stubRange textarea').bind('keyup',function (e) {
        if (event.ctrlKey&&(event.keyCode == 91 ||event.keyCode == 93||event.keyCode == 224)) {
            var obj = event.srcElement ? event.srcElement : event.target;
            console.log('保存:'+$(obj).data('index'));
            e.returnValue=false;
            return false;
        }
    })


})