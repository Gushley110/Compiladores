from State import State
from Transition import Transition

class NFA:
	"""
    NFA Class

    Methods:
		constructor(states,alphabet,init_st,acc_states): 
		print_states(): prints all transitions from all states
		add_state(): adds a state to states set

    Data attributes:
       init_st: State, initial state
       alphabet: Set, 
       states: Set, 
	   acc_states: Set, accepted states		

    Usage:
    >>> q0 = State(0)
	>>> q1 = State(1)
	>>> q2 = State(2)

	>>> q0.add_transition(q0,'a')
	>>> q0.add_transition(q0,'a')
	>>> q0.add_transition(q1,'a')
	>>> q0.add_transition(q1,'b')
	>>> q1.add_transition(q2,'b')

	>>> alphabet = {'a','b'}
	>>> fn_st = {q0,q2}

	>>> nfa = NFA({q0,q1,q2},alphabet,q0,fn_st)

	>>> nfa.print_states()
    
    """

	def __init__(self,states = set(),alphabet = set(),init_st = None, acc_states = set()):
		self.init_st    = init_st
		self.alphabet   = alphabet
		self.states     = states
		self.acc_states = acc_states

		for acs in self.acc_states:
			if acs in self.states:
				acs.is_accept = True


	def print_states(self):
		for s in self.states:
			s.print_transitions()

	def add_state(id_state):
		s = state(id_state)
		self.states.add(s)

	def getState(self, id):
		for c in self.states:
			if(c.id_state == id):
				return c

if __name__ == '__main__':
	
	q0 = State(0)
	q1 = State(1)
	q2 = State(2)

	q0.add_transition(q0,'a')
	q0.add_transition(q1,'a')
	q0.add_transition(q0,'b')
	q1.add_transition(q2,'b')

	alphabet = {'a','b'}
	fn_st = {q0,q2}

	nfa = NFA({q0,q1,q2},alphabet,q0,fn_st)

	nfa.print_states()
	print('----')
	nextStates = q0.getNextStates('a')
	
	#print(nextStates)
	for s in nextStates:
		print('{} -> {}'.format(s,s.getNextStates('a')))

	#codigo para guardar los recorridos aceptados
	test = "aabab"
	fisrt=[Transition(q0,'')]
	activos=[]
	activos.append(fisrt)
	for c in test:
		nextS=[]
		for path in activos:
			t=path[-1]
			for s in t.state.getNextStates(c):
				newP=list(path)
				newP.append(Transition(s,c))
				nextS.append(newP)
		activos=nextS

	for path in activos:
		if path[-1].state.is_accept:
			print(path)

	

	

