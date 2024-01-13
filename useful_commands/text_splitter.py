#this utility is used to split a text file into chunks of 1000 words each, they should end in a sentence
#usage: python text_splitter.py <filename>

#from langchain.text_splitter import NLTKTextSplitter
from langchain.text_splitter import RecursiveCharacterTextSplitter
import sys
import tiktoken

def num_tokens_from_string(string: str, encoding_name: str) -> int:
    """Returns the number of tokens in a text string."""
    encoding = tiktoken.get_encoding(encoding_name)
    num_tokens = len(encoding.encode(string))
    return num_tokens


if len(sys.argv) < 2:
    print("Usage: python text_splitter.py <filename>")
    sys.exit(1)

filename = sys.argv[1]

with open(filename, 'r') as f:
    filetext = f.read()

#splitter = NLTKTextSplitter(chunk_size=1000)

#docs = splitter.create_documents([filetext])

splitter = RecursiveCharacterTextSplitter.from_tiktoken_encoder(
    chunk_size=3000, chunk_overlap=50, encoding_name="cl100k_base"
)

texts = splitter.split_text(filetext)

for text in texts:
    tokens = num_tokens_from_string(text, "cl100k_base")

    text = text.replace('\n', ' ') + '\n[CL100KTOKENS:' + str(tokens) + ']\n\n'
    print(text)

