package com.qf.mall.common;

public class DataResult {
    private Integer code;
    private String msg;
    private Object data;
    private long count;

    public DataResult(Integer code, Object data) {
        this.code = code;
        this.data = data;
    }

    public DataResult(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public DataResult(Integer code, String msg,long count,Object data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
        this.count = count;
    }

    public DataResult(int code, String msg, Object data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public static DataResult ok(String msg){
        return new DataResult(200,msg);
    }
    public static DataResult err(String msg){
        return new DataResult(600,msg);
    }
    public static DataResult ok(Object data){
        return new DataResult(200,data);
    }
    public static DataResult ok(String msg,Object data){
        return new DataResult(200,msg,data);
    }
    public static DataResult returnPageLimit(long count,Object data){
        return new DataResult(0,"",count,data);
    }
    public static DataResult returnData(Integer code,Object data){
        return new DataResult(code,data);
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public long getCount() {
        return count;
    }

    public void setCount(long count) {
        this.count = count;
    }

    @Override
    public String toString() {
        return "DataResult{" +
                "code=" + code +
                ", msg='" + msg + '\'' +
                ", data=" + data +
                ", count=" + count +
                '}';
    }
}
