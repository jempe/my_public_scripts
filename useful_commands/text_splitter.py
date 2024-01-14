#this utility is used to split a text file into chunks of 1000 words each, they should end in a sentence
#usage: python text_splitter.py <filename>

#from langchain.text_splitter import NLTKTextSplitter
from langchain.text_splitter import RecursiveCharacterTextSplitter
import sys
import tiktoken
import argparse

#arg chunk_size gets the number of tokens per chunk
#arg chunk_overlap gets the number of tokens to overlap between chunks
#arg total_tokens gets the total number of tokens to display

parser = argparse.ArgumentParser(description="Split the text in multiple chunks to use in chatGPT")

# Add command-line arguments
parser.add_argument('-total_tokens', type=int, help='Total number of tokens')
parser.add_argument('-filename', type=str, help='Filename to split')

# Parse the command-line arguments
args = parser.parse_args()


total_tokens = 2500

if args.total_tokens:
    total_tokens = args.total_tokens


chunk_size = total_tokens / 5
chunk_overlap = 0


def num_tokens_from_string(string: str, encoding_name: str) -> int:
    """Returns the number of tokens in a text string."""
    encoding = tiktoken.get_encoding(encoding_name)
    num_tokens = len(encoding.encode(string))
    return num_tokens


filename = args.filename

with open(filename, 'r') as f:
    filetext = f.read()

#splitter = NLTKTextSplitter(chunk_size=1000)

#docs = splitter.create_documents([filetext])

splitter = RecursiveCharacterTextSplitter.from_tiktoken_encoder(
    chunk_size=chunk_size, chunk_overlap=chunk_overlap, encoding_name="cl100k_base"
)

texts = splitter.split_text(filetext)

texts_data = []

tokens_count = 0

for i, text in enumerate(texts):
    tokens = num_tokens_from_string(text, "cl100k_base")

    tokens_count += tokens

    if tokens_count > total_tokens:
        texts_data[i - 1]["split"] = True
        tokens_count = tokens

    texts_data.append({"text": text, "tokens": tokens, "split": False})

tokens_count = 0

for i, text_data in enumerate(texts_data):

    tokens_count += text_data["tokens"]

    text = text_data["text"]

    print(text)

    if text_data["split"] or i == len(texts_data) - 1:
        print('\n[CL100KTOKENS:' + str(tokens_count) + ']\n\n')
        tokens_count = 0

