class Transition:
	"""
    Transition function class of a Non-Deterministic Finite Automaton imported by State.py

    Methods:
       constructor(state,sym): set transition to state with sym
       __repr__: String representation of Transition
       __eq__: Comparator for set
       __hash__: hash attributes to compare

    Data attributes:
       state: State, To which state will we go 
       sym: Char, What symbol triggers the transition

    Usage:
    	See NFA.py
    """

	def __init__(self,state,sym):
		self.state = state
		self.sym = sym

	def __repr__(self):
		return '({s.sym})->{s.state.id_state}'.format(s=self)

	def __eq__(self, other):
		return self.state == other.state and self.sym == other.sym

	def __hash__(self):
		return hash(self.sym + str(self.state.id_state))

	