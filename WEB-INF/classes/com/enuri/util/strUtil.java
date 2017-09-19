package com.enuri.util;

public class strUtil {
	
	public strUtil(){
	}

	// 문자열의 널 체크
	public static String NullChk(String sourceStr, String defaultStr) {
		String rtnValue = sourceStr;

		if(sourceStr==null) {
			rtnValue = defaultStr;
		}

		return rtnValue;
	}

	// 문자열의 널 체크 후 숫자로 변환해서 반환
	// 만약 원문자열이 null이면 디폴트로 다시 시도한 값이 들어감
	// 둘다 실패했을때는 -1을 리턴
	public static int NullChkToInt(String sourceStr, String defaultStr) {
		int rtnValue = -1;
		String tempValue = sourceStr;

		if(sourceStr==null) {
			tempValue = defaultStr;
		}
		
		rtnValue = StrToInt(tempValue);

		return rtnValue;
	}

	// 문자열을 정수로 변환, 실패 시 -1반환
	public static int StrToInt(String sourceStr) {
		int rtnValue = -1;

		try {
			rtnValue = Integer.parseInt(sourceStr);
		} catch(Exception e) {
		}

		return rtnValue;
	}

	// 엔터나 특수 문자를 Json과 Html에 맞게 변환해 줌
	public static String StrToJson(String sourceStr) {
		String rtnValue = sourceStr;

		rtnValue = rtnValue.replaceAll("\r\n", "<br>");
		rtnValue = rtnValue.replaceAll("\n", "<br>");
		rtnValue = rtnValue.replaceAll("&", "&amp;");
		rtnValue = rtnValue.replaceAll("\"", "&quot;");
		//rtnValue = rtnValue.replaceAll("<", "&lt;");
		//rtnValue = rtnValue.replaceAll(">", "&gt;");

		return rtnValue;
	}

}
