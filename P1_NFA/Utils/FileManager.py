class FileManager:

	def __init__(self,srcname = None,trgtname = None):
		self.srcname  = srcname
		self.trgtname = trgtname

	def getText(self): #Returns the text of the file as a string encoded in utf-8
		with open(self.srcname, encoding='utf-8') as file:
			text = file.read()
		return text

	def getTextB(self): #Returns the text of the file as binary
		with open(self.srcname, 'rb') as file:
			text = file.read()
		return text

	def readLines(self):
		with open(self.srcname) as file:
			lines = file.readlines()
		return [line.rstrip('\n') for line in lines]

	def copyText(self,n = 1):
		text = self.getText()

		with open(self.trgtname, mode='w', encoding='utf-8') as new_file:
				new_file.write(n * ("%s\n" % (text)))

	def createFile(self,text): #Creates or modifies a file in string encoded in utf-8
		with open(self.trgtname, mode='w', encoding='utf-8') as new_file:
				new_file.write("%s" % (text))

	def createFileB(self,text): #Creates or modifies a file in binary
		with open(self.trgtname, mode='wb') as new_file:
				new_file.write(text)

	


