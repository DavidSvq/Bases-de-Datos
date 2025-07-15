CREATE DATABASE Hospital;
USE Hospital;

CREATE TABLE Paciente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR(15),
    direccion VARCHAR(255),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Medico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(50),
    telefono VARCHAR(15),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Cita (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    id_medico INT,
    fecha DATETIME,
    motivo VARCHAR(255),
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id),
    FOREIGN KEY (id_medico) REFERENCES Medico(id)
);

CREATE TABLE HistorialMedico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    diagnostico TEXT,
    tratamiento TEXT,
    fecha DATE,
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id)
);

CREATE TABLE Factura (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cita INT,
    monto DECIMAL(10,2),
    pagado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_cita) REFERENCES Cita(id)
);
USE Hospital;

-- Insertar pacientes
INSERT INTO Paciente (nombre, fecha_nacimiento, telefono, direccion, email) VALUES
('Juan Pérez', '1985-06-15', '654321987', 'Calle Mayor 123, Madrid', 'juan.perez@email.com'),
('María López', '2001-02-20', '678954321', 'Av. Andalucía 45, Sevilla', 'maria.lopez@email.com'),
('Carlos Fernández', '1950-10-10', '612345678', 'Plaza Cataluña 10, Barcelona', 'carlos.fernandez@email.com'),
('Ana Torres', '1993-07-07', '698745632', 'Calle Real 22, Valencia', 'ana.torres@email.com'),
('Luis García', '2015-05-30', '654123987', 'Calle Luna 88, Granada', 'luis.garcia@email.com'),
('Sofía Martínez', '1978-09-12', '687452369', 'Avenida Sol 99, Málaga', 'sofia.martinez@email.com'),
('Pedro Ramírez', '1960-11-25', '698741256', 'Calle del Río 14, Cádiz', 'pedro.ramirez@email.com'),
('Laura Sánchez', '2008-12-05', '699874521', 'Paseo Marítimo 66, Bilbao', 'laura.sanchez@email.com');

-- Insertar médicos
INSERT INTO Medico (nombre, especialidad, telefono, email) VALUES
('Dr. Antonio Ríos', 'Cardiología', '698745632', 'antonio.rios@hospital.com'),
('Dra. Elena Gómez', 'Pediatría', '687451236', 'elena.gomez@hospital.com'),
('Dr. Manuel Ruiz', 'Neurología', '654789123', 'manuel.ruiz@hospital.com'),
('Dra. Carmen Pérez', 'Ginecología', '689741235', 'carmen.perez@hospital.com'),
('Dr. Javier Ortega', 'Medicina General', '678954312', 'javier.ortega@hospital.com'),
('Dra. Patricia Martín', 'Dermatología', '698745632', 'patricia.martin@hospital.com');

-- Insertar citas médicas
INSERT INTO Cita (id_paciente, id_medico, fecha, motivo) VALUES
(1, 5, '2025-03-10 09:00:00', 'Chequeo general'),
(2, 2, '2025-03-11 10:30:00', 'Vacuna anual'),
(3, 1, '2025-03-12 11:45:00', 'Revisión cardiaca'),
(4, 4, '2025-03-13 15:00:00', 'Consulta ginecológica'),
(5, 2, '2025-03-14 08:30:00', 'Revisión pediátrica'),
(6, 6, '2025-03-15 14:15:00', 'Consulta dermatológica'),
(7, 3, '2025-03-16 12:00:00', 'Dolores de cabeza frecuentes'),
(8, 5, '2025-03-17 16:00:00', 'Fiebre persistente');

-- Insertar historial médico
INSERT INTO HistorialMedico (id_paciente, diagnostico, tratamiento, fecha) VALUES
(1, 'Hipertensión arterial', 'Dieta baja en sodio y ejercicio', '2024-12-01'),
(2, 'Vacuna aplicada correctamente', 'Ninguno', '2025-01-15'),
(3, 'Arritmia leve', 'Medicamentos betabloqueantes', '2025-02-10'),
(4, 'Quiste ovárico', 'Revisión cada 6 meses', '2025-02-28'),
(5, 'Alergia al polen', 'Antihistamínicos en primavera', '2025-03-05'),
(6, 'Psoriasis leve', 'Cremas hidratantes y evitar estrés', '2025-03-08'),
(7, 'Migrañas crónicas', 'Control del estrés y analgésicos', '2025-03-10'),
(8, 'Infección viral leve', 'Reposo y paracetamol', '2025-03-12');

-- Insertar facturas
INSERT INTO Factura (id_cita, monto, pagado) VALUES
(1, 120.50, TRUE),
(2, 45.00, TRUE),
(3, 250.00, FALSE),
(4, 180.00, FALSE),
(5, 60.00, TRUE),
(6, 90.00, FALSE),
(7, 200.00, TRUE),
(8, 75.50, FALSE);
