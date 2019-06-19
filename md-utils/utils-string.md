
# string

## url字符串的处理

``` js
var encodeReserveRE = /[!'()*]/g;
var encodeReserveReplacer = function (c) {
    return '%' + c.charCodeAt(0).toString(16);
};
var commaRE = /%2C/g;

// fixed encodeURIComponent which is more conformant to RFC3986:
// - escapes [!'()*]
// - preserve commas
var encode = function (str) {
    return encodeURIComponent(str)
        .replace(encodeReserveRE, encodeReserveReplacer)
        .replace(commaRE, ',');
};

let decode = decodeURIComponent;


// search字符串转对象
function parseQuery(query) {

    var res = {};

    query = query.trim().replace(/^(\?|#|&)/, '');

    if (!query) {
        return res
    }

    query.split('&').forEach(function (param) {
        var parts = param.replace(/\+/g, ' ').split('=');
        var key = decode(parts.shift());
        var val = parts.length > 0 ?
            decode(parts.join('=')) :
            null;

        if (res[key] === undefined) {
            res[key] = val;
        } else if (Array.isArray(res[key])) {
            res[key].push(val);
        } else {
            res[key] = [res[key], val];
        }
    });

    return res
}

// 对象转 search字符串
function stringifyQuery(obj) {
    let decode = decodeURIComponent;
    var res = obj ? Object.keys(obj).map(function (key) {
        var val = obj[key];

        if (val === undefined) {
            return ''
        }

        if (val === null) {
            return encode(key)
        }

        if (Array.isArray(val)) {
            var result = [];
            val.forEach(function (val2) {
                if (val2 === undefined) {
                    return
                }
                if (val2 === null) {
                    result.push(encode(key));
                } else {
                    result.push(encode(key) + '=' + encode(val2));
                }
            });
            return result.join('&')
        }

        return encode(key) + '=' + encode(val)
    }).filter(function (x) {
        return x.length > 0;
    }).join('&') : null;
    return res ? ("?" + res) : ''
}


function query(string){
    let object = parseQuery(string);

    return function(key){
        return object[key]
    }
}

```

## 生成随机的uuid字符串

```js
function guid() {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
                var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
                return v.toString(16);
        });
}

```