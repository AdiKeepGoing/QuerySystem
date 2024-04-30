package com.example.echartsdemo;

public class Policy {
    private String name;
    private String organ;
    private String pubdata;
    private String type;
    private String id;
    private String document;
    private String text;

    public Policy() {
    }

    public Policy(String name, String organ, String pubdata, String type) {
        this.name = name;
        this.organ = organ;
        this.pubdata = pubdata;
        this.type = type;
    }

    public Policy(String name, String organ, String pubdata, String type, String document, String text) {
        this.name = name;
        this.organ = organ;
        this.pubdata = pubdata;
        this.type = type;
        this.document = document;
        this.text = text;
    }



    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOrgan() {
        return organ;
    }

    public void setOrgan(String organ) {
        this.organ = organ;
    }

    public String getPubdata() {
        return pubdata;
    }

    public void setPubdata(String pubdata) {
        this.pubdata = pubdata;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDocument() {
        return document;
    }

    public void setDocument(String document) {
        this.document = document;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
