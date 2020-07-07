package com.dong.scan;

import java.io.Serializable;

public class ScanConfig implements Serializable {

    /*格式为#ARGB,默认为 '#4c000000'*/
    String maskColor;

    /*遮罩框相对比例.默认为宽度的0.68 */
    double maskRatio;

    /*返回按钮的样式,ReturnStyleExit(值为0) ReturnStyleCancle(值为1)*/
    int returnStyle;

    /*四个角的主色,默认为'#4bde2b'*/
    String titeColor;

    /*标题文字,默认为扫一扫*/
    String title;

    /*底部提示文字,默认为将二维码放入框内，即可自动扫描*/
    String hintString;

    public String getMaskColor() {
        return maskColor;
    }

    public void setMaskColor(String maskColor) {
        this.maskColor = maskColor;
    }

    public double getMaskRatio() {
        return maskRatio;
    }

    public void setMaskRatio(double maskRatio) {
        this.maskRatio = maskRatio;
    }

    public int getReturnStyle() {
        return returnStyle;
    }

    public void setReturnStyle(int returnStyle) {
        this.returnStyle = returnStyle;
    }

    public String getTiteColor() {
        return titeColor;
    }

    public void setTiteColor(String titeColor) {
        this.titeColor = titeColor;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getHintString() {
        return hintString;
    }

    public void setHintString(String hintString) {
        this.hintString = hintString;
    }
}
