package packageTableManager;

public class UtilsFunction {
	public static String notNull(String v1, String v2){
		if (v1 == null || v1.isEmpty() ||  v1.trim().isEmpty()){
			v1 = v2;
		}
		return v1;
	}
	
	public static void main(String[] args) {
		/*test function notNull*/
		System.out.println(UtilsFunction.notNull(" ", "prima nulla o senza caratteri"));
		
	}
	
	public static boolean isEmpty(String v) {
		return v==null || "".equals(v);
	}
}
