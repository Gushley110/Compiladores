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
		

	def add_state(state):
		self.states.add(s)

	def accepts(self,test):
		first = [Transition(self.init_st,'')]
		activos = []
		activos.append(first)
		for c in test:
			nextS = []
			for path in activos:
				t = path[-1]
				for s in t.state.getNextStates('E'):
					newP = list(path)
					newP.append(Transition(s,'E'))
					activos.append(newP)
				for s in t.state.getNextStates(c):
					newP = list(path)
					newP.append(Transition(s,c))
					nextS.append(newP)
			activos = nextS

		for path in activos:
			t = path[-1]
			for s in t.state.getNextStates('E'):
				newP = list(path)
				newP.append(Transition(s,'E'))
				activos.append(newP)
			if path[-1].state.is_accept:
				print(path)

	def epsilon_closure(self,state):

		epsilon = set([state])
		stack = [state]

		while stack:
			s = stack.pop()
			for st in s.getNextStates('E'):
				epsilon.add(st)
				stack.append(st)

		return epsilon

	def epsilon_closure_set(self,states):

		epsilon = set()

		for s in states:
			epsilon = epsilon.union(self.epsilon_closure(s))

		return epsilon

	def powerset(self):

		v_names = [chr(65 + i) for i in range(0,26)]
		first_v = v_names.pop()

		alphabet = set(self.alphabet)
		alphabet.remove('E')

		stack = [first_v]
		init_st = State(first_v)
		states = set()
		acc_st = set()

		states.add(init_st)
		
		powersets = {str(first_v) : self.epsilon_closure(self.init_st)}

		while stack:
			key = stack.pop()
			s = State(key)
			for c in alphabet:
				z = self.go_to(powersets[key],c)

				if z not in powersets.values():
					new_s_name = v_names.pop()
					new_st = State(new_s_name)
					powersets[new_s_name] = z

					s.add_transition(new_st, c)
					#s.print_transitions()

					states.remove(s)
					states.add(s)
					states.add(new_st)
					stack.append(new_s_name)

				elif z in powersets.values() and z != set():
					sets = list(powersets.values())
					keys = list(powersets.keys())
					i = sets.index(z)
					s.add_transition(State(keys[i]), c)
					states.remove(s)
					states.add(s)
					print('--')

		sets = list(powersets.values())
		keys = list(powersets.values())

		for ac_st in self.acc_states:
			for key,value in powersets.items():
				if ac_st in value:
					acc_st.add(State(key))


		for s in states:
			s.print_transitions()

		for s in acc_st:
			print(s)

		newnfa = self.__init__(states,alphabet,init_st,acc_st)
		

		return newnfa

	def move_to(self,states,sym):
		
		moves = set()

		for s in states:
			moves = moves.union(s.getNextStates(sym))

		return moves

	def go_to(self,state,sym):

		goes = set()

		goes = goes.union(self.epsilon_closure_set(self.move_to(state,sym)))

		return goes

	def getState(self, id):
		for c in self.states:
			if c.id_state == 'q' + str(id):
				return c


	def print_states(self):
		for s in self.states:
			s.print_transitions()

	def print_transition_table(self):

		line_size = len('\t\t  '.expandtabs())

		print("\t\u03B4\t |",end = '')

		for sym in self.alphabet:
			print('\t{}\t|'.format(sym),end = '')
			line_size += len('\t{}\t|'.expandtabs())
		print()

		print('-' * line_size)

		for s in self.states:
			if s == self.init_st:
				print('\t->{}\t |'.format(s),end = '') 
			elif s in self.acc_states:
				print('\t* {}\t |'.format(s),end = '')
			else:
				print('\t  {}\t |'.format(s),end = '')
			for c in self.alphabet:					
				if len(s.getNextStates(c)) == 2:
					print('   {}   |'.format(s.getNextStates(c)),end = '')
				elif len(s.getNextStates(c)) == 3:
					print(' {}  |'.format(s.getNextStates(c)),end = '')
				else:
					print('\t{}\t|'.format(s.getNextStates(c)),end = '')
			print()

if __name__ == '__main__':
	
	q0 = State(0)
	q1 = State(1)
	q2 = State(2)

	q0.add_transition(q0,'a')
	q0.add_transition(q1,'E')
	q0.add_transition(q2,'b')
	q2.add_transition(q2,'b')
	q2.add_transition(q1,'b')

	alphabet = {'a','b'}
	fn_st = {q1}

	nfa = NFA({q0,q1,q2},alphabet,q0,fn_st)

	nfa.print_states()
	print('----')
	nfa.print_transition_table()
	
	#print(nextStates)
	#for s in nextStates:
	#	print('{} -> {}'.format(s,s.getNextStates('a')))

	#codigo para guardar los recorridos aceptados
	#test = "aaaaa"
	#nfa.accepts(test)