package com.robert.java.unioviscope.business.studentGroup.importer;

import com.robert.java.unioviscope.business.common.importer.Importer;
import com.robert.java.unioviscope.model.StudentGroup;

/**
 * Interfaz que extiende la interfaz Importer y define las operaciones de
 * importación específicas para la entidad "StudentGroup" (estudiante asignado a
 * grupo). También define la cabecera de los ficheros de importación.
 * 
 * @author Robert Ene
 * @see com.robert.java.unioviscope.business.common.importer.Importer
 */
public interface StudentGroupImporter extends Importer<StudentGroup> {

	static final String USERNAME = "user-name";
	static final String GROUP_ID = "group-id";

	static final String[] HEADERS = { USERNAME, GROUP_ID };
}
