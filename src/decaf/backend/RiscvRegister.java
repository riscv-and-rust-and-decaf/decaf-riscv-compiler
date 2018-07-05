package decaf.backend;

import decaf.machdesc.Register;

public class RiscvRegister extends Register {

	public enum RegId {
		ZERO, RA, SP, GP, TP, T0, T1, T2, FP, S1,
		A0, A1,	A2, A3, A4, A5, A6, A7, 
		S2, S3, S4, S5, S6, S7, S8, S9, S10, S11,
		T3, T4, T5, T6
	}

	public final RegId id;

	public final String name;

	public RiscvRegister(RegId id, String name) {
		this.id = id;
		this.name = name;
	}

	@Override
	public String toString() {
		return name;
	}

}
