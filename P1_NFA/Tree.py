class Node:

	def __init__(self, data):
		self.child = []
		self.data = data

	def addChild(self,element):
		self.child.append(element)
