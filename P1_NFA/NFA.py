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

		self.err_state = self.create_error_state()
		self.add_error_transitions


	def print_states(self):
		for s in self.states:
			print(s)
			#s.print_transitions()

	def add_state(self,id_state):
		s = State(id_state)
		self.states.add(s)

	def getState(self, id):
		for c in self.states:
			if(c.id_state == id):
				return c

	def create_error_state(self):
		self.add_state(-1)
		s = self.getState(-1)

		print('Estado de error creado')

		return s

	def add_error_transitions(self):
		for s in self.states:
			sym = self.alphabet - s.get_transition_symbols()
			print('symbols: {}'.format(sym))
			for c in sym:
				s.add_transition(self.err_state,c)


if __name__ == '__main__':
	
	q0 = State(0)
	q1 = State(1)
	q2 = State(2)
	q3 = State(3)
	q4 = State(4)

	q0.add_transition(q1,'+')
	q0.add_transition(q1,'-')
	q0.add_transition(q2,'.')
	q0.add_transition(q4,'a')
	q1.add_transition(q1,'a')
	q1.add_transition(q2,'.')
	q1.add_transition(q4,'a')
	q2.add_transition(q3,'a')
	q3.add_transition(q3,'a')
	q4.add_transition(q3,'.')

	alphabet = {'a','+','-','.'}
	fn_st = {q3}

	nfa = NFA({q0,q1,q2,q3,q4},alphabet,q0,fn_st)

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

	

	

