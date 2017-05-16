package packageTableManager;

public class UtilsFunction {
	public static String notNull(String v1, String v2){
		if (v1 == null || v1.isEmpty() ||  v1.trim().isEmpty()){
			v1 = v2;
		}
		return v1;
	}
	
	public static boolean isEmpty(String v) {
		if(v==null || v.isEmpty() || v.trim().isEmpty()){
			return true;
		}
		return false;
	}
	
	public static boolean isEmpty(String [] v) {
		if(v==null){
			return true;
		}
		return false;
	}
	
	public static void main(String[] args) {
		
		System.out.println(UtilsFunction.notNull(" ", "prima nulla o senza caratteri"));
		System.out.println(UtilsFunction.isEmpty(""));
	}
}
