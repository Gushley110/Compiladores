from Transition import Transition

class State:
	"""
    State class of a Non-Deterministic Finite Automaton imported by NFA.py

    Methods:
		constructor(id_state): set name(id) of the state
		__repr__: String representation of State
       __eq__: Comparator for set
       __hash__: hash attributes to compare
		add_transition(state,sym): add a new transition to this state
		print_transtions(): print all transitions made by this state

    Data attributes:
       id_state: Integer, name or identifier of the state
       is_accept: Boolean, Is a final or accepted state?
       transitions: Set, set of transitions

    Usage:
	    See NFA.py
    
    """


	def __init__(self,id_state):
		self.id_state    = 'q' + str(id_state)
		self.is_accept   = False
		self.transitions = set()

	def __repr__(self):
		return '{}'.format(self.id_state)

	def __eq__(self,other):
		return self.id_state == other.id_state

	def __hash__(self):
		return hash(self.id_state)

	def getNextStates(self,sym):
		states = []
		for t in self.transitions:
			if sym == t.sym:
				states.append(t.state)
			
		return states

	def add_transition(self, state, sym):
		t = Transition(state,sym)
		self.transitions.add(t)

	def print_transitions_with(self,sym):
		for t in self.transitions:
			if sym == t.sym:
				print('{}{}'.format(self.id_state,t))

	def print_transitions(self):
		for t in self.transitions:
			print('{}{}'.format(self.id_state,t))

if __name__ == "__main__":
    s1 = State(0)
    s2 = State(1)
    s3 = State(2)

    print(s1.id_state,s2.id_state,s3.id_state)
