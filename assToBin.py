instruction_mapping = {
    'ADD': '01',
    'MUL': '02',
    'SUB': '03',
    'COP': '05',
    'PUT': '06',
    'LOAD': '07',
    'STORE': '08',

    # Ajoutez d'autres instructions ici
}

def convert_instruction_to_binary(instruction):
    opcode = instruction[0]
    arguments = instruction[1:]
    binary_instruction = instruction_mapping.get(opcode, '')
    for argument in arguments:
        binary_instruction += argument.zfill(2)  # Ajoute les arguments formatés sur 2 caractères
    return binary_instruction

def process_assembly_file(input_file, output_file):
    with open(input_file, 'r') as file:
        lines = file.readlines()

    binary_instructions = []
    for line in lines:
        instruction = line.strip().split(' ')
        binary_instruction = convert_instruction_to_binary(instruction)
        binary_instructions.append(binary_instruction)

    binary_code = ''.join(binary_instructions)

    with open(output_file, 'w') as file:
        file.write(binary_code)

# Exemple d'utilisation
input_file = 'test.S'
output_file = 'outputbinary.txt'
process_assembly_file(input_file, output_file)
