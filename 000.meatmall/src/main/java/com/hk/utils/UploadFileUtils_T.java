package com.hk.utils;

//////////////////////////////////////대표이미지//////////////////////////
//폴더 생성과 파일 저장
//날짜(연/월/일)로 구성된 폴더를 생성하고, 같은 파일명이라도 중복되지 않도록 랜덤문자와 파일명을 조합한 뒤 생성된 폴더에 저장

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

public class UploadFileUtils_T {
 
 public static String fileUpload_T( String uploadPath
		 						  , String fileName
		 						  , byte[] fileData
		 						  , String ymdPath) throws Exception {
  UUID uid = UUID.randomUUID();
  
  String newFileName = uid + "_" + fileName;
  String imgPath = uploadPath + ymdPath;

  File target = new File(imgPath, newFileName);
  FileCopyUtils.copy(fileData, target);

  return newFileName;
 }

 public static String calcPath(String uploadPath) {
  Calendar cal = Calendar.getInstance();
  String yearPath = File.separator + cal.get(Calendar.YEAR);
  String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
  String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));

  makeDir(uploadPath, yearPath, monthPath, datePath);

  return datePath;
 }

 private static void makeDir(String uploadPath, String... paths) {

  if (new File(paths[paths.length - 1]).exists()) { return; }

  for (String path : paths) {
   File dirPath = new File(uploadPath + path);

   if (!dirPath.exists()) {
    dirPath.mkdir();
   }
  }
 }
}