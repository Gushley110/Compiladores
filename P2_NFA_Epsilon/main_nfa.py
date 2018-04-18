from NFA import NFA
from State import State
from Transition import Transition
from Utils.FileManager import *

def fNFA(file_name):

	f = FileManager(file_name)
	
	lines = f.readLines()	
	n = len(lines)
	last_lines = n - 4		

	#read first line with States
	fstates = lines[0]				
	fstates = fstates.split(',')
	states = []
	for id_state in fstates:
		states.append(State(id_state))

	#read second line with the alphabet
	falphabet = lines[1]
	falphabet = falphabet.split(',')
	alphabet = set()
	alphabet.add('E')
	for c in falphabet:
		alphabet.add(c)


	#read third line with initial state
	initst = lines[2]
	if State(initst) in states:
		i = states.index(State(initst))
		initst = states[i]

	#read fourth line with accepted states
	facc_states = lines[3]
	facc_states = facc_states.split(',')
	acc_states = set()
	for id_state in facc_states:
		i = states.index(State(id_state))
		states[i].is_accept = True
		acc_states.add(states[i])

	#read transitions
	transition = []
	for i in range(last_lines):
		transition.append(lines[4+i].split(','))

	#add transitions to states
	for t in transition:
		i = states.index(State(t[0]))
		j = states.index(State(t[2]))
		if t[1] in alphabet:
			states[i].add_transition(states[j],t[1])
		else:
			print('Some symbol(s) does not belong to the alphabet')

	#creating the NFA
	nfa = NFA(set(states),alphabet,initst,acc_states)

	return nfa

def main():

	file_name = input('Nombre del archivo\n')
	string = input('Cadena a evaluar\n')

	nfa = fNFA(file_name)

	nfa.accepts(string)


if __name__ == "__main__":
    main()