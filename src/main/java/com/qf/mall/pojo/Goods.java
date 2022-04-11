package com.qf.mall.pojo;


public class Goods {
    /** 商品ID;唯一标识 */
    private Integer goodsId ;
    /** 商品名称 */
    private String goodsName ;
    /** 商品进货价格 */
    private Double buyPrice ;
    /** 商品出售价格 */
    private Double sellPrice ;
    /** 商品VIP出售价格 */
    private Double vipSellPrice ;
    /** 商品照片 */
    private String head ;
    /** 商品描述 */
    private String goodsInstruction ;
    /** 商品种类 */
    private Integer goodsTypeId ;
    /** 商品库存 */
    private Integer inventory ;

    /** 商品ID;唯一标识 */
    public Integer getGoodsId(){
        return this.goodsId;
    }
    /** 商品ID;唯一标识 */
    public void setGoodsId(Integer goodsId){
        this.goodsId = goodsId;
    }
    /** 商品名称 */
    public String getGoodsName(){
        return this.goodsName;
    }
    /** 商品名称 */
    public void setGoodsName(String goodsName){
        this.goodsName = goodsName;
    }
    /** 商品进货价格 */
    public Double getBuyPrice(){
        return this.buyPrice;
    }
    /** 商品进货价格 */
    public void setBuyPrice(Double buyPrice){
        this.buyPrice = buyPrice;
    }
    /** 商品出售价格 */
    public Double getSellPrice(){
        return this.sellPrice;
    }
    /** 商品出售价格 */
    public void setSellPrice(Double sellPrice){
        this.sellPrice = sellPrice;
    }
    /** 商品VIP出售价格 */
    public Double getVipSellPrice(){
        return this.vipSellPrice;
    }
    /** 商品VIP出售价格 */
    public void setVipSellPrice(Double vipSellPrice){
        this.vipSellPrice = vipSellPrice;
    }

    public String getHead() {
        return head;
    }

    public void setHead(String head) {
        this.head = head;
    }


    public String getGoodsInstruction() {
        return goodsInstruction;
    }

    public void setGoodsInstruction(String goodsInstruction) {
        this.goodsInstruction = goodsInstruction;
    }

    /** 商品种类 */
    public Integer getGoodsTypeId(){
        return this.goodsTypeId;
    }
    /** 商品种类 */
    public void setGoodsTypeId(Integer goodsTypeId){
        this.goodsTypeId = goodsTypeId;
    }
    /** 商品库存 */
    public Integer getInventory(){
        return this.inventory;
    }
    /** 商品库存 */
    public void setInventory(Integer inventory){
        this.inventory = inventory;
    }

    @Override
    public String toString() {
        return "Goods{" +
                "goodsId=" + goodsId +
                ", goodsName='" + goodsName + '\'' +
                ", buyPrice=" + buyPrice +
                ", sellPrice=" + sellPrice +
                ", vipSellPrice=" + vipSellPrice +
                ", head='" + head + '\'' +
                ", instruction='" + goodsInstruction + '\'' +
                ", goodsTypeId=" + goodsTypeId +
                ", inventory=" + inventory +
                '}';
    }
}