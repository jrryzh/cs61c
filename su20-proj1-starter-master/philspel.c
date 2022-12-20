//Author: Jrryzh

//Date: 2022-12-20

//Description: Got some code from https://github.com/lovelyfrog/cs61c-1/blob/master/proj1/philspel.c
// My c knowledge is really poor

/*
 * Include the provided hash table library.
 */
#include "hashtable.h"

/*
 * Include the header file.
 */
#include "philspel.h"

/*
 * Standard IO and file routines.
 */
#include <stdio.h>

/*
 * General utility routines (including malloc()).
 */
#include <stdlib.h>

/*
 * Character utility routines.
 */
#include <ctype.h>

/*
 * String utility routines.
 */
#include <string.h>

/*
 * This hash table stores the dictionary.
 */
HashTable *dictionary;

/*
 * The MAIN routine.  You can safely print debugging information
 * to standard error (stderr) as shown and it will be ignored in 
 * the grading process.
 */
int main(int argc, char **argv) {
  if (argc != 2) {
    fprintf(stderr, "Specify a dictionary\n");
    return 0;
  }
  /*
   * Allocate a hash table to store the dictionary.
   */
  fprintf(stderr, "Creating hashtable\n");
  dictionary = createHashTable(2255, &stringHash, &stringEquals);

  fprintf(stderr, "Loading dictionary %s\n", argv[1]);
  readDictionary(argv[1]);
  fprintf(stderr, "Dictionary loaded\n");

  fprintf(stderr, "Processing stdin\n");
  processInput();

  /*
   * The MAIN function in C should always return 0 as a way of telling
   * whatever program invoked this that everything went OK.
   */
  return 0;
}

/*
 * This should hash a string to a bucket index.  Void *s can be safely cast
 * to a char * (null terminated string) and is already done for you here 
 * for convenience.
 */
unsigned int stringHash(void *s) {
  char *string = (char *)s;
  // -- TODO --
  unsigned int hashcode = 0;
  while (*string) {
    hashcode += hashcode * 31 + *string;
    string++;
  }
  return hashcode;
}

/*
 * This should return a nonzero value if the two strings are identical 
 * (case sensitive comparison) and 0 otherwise.
 */
int stringEquals(void *s1, void *s2) {
  char *string1 = (char *)s1;
  char *string2 = (char *)s2;
  // -- TODO --
  if(strcmp(string1, string2) == 0) {
    return 1;
  } else {
    return 0;
  }
}

/*
 * This function should read in every word from the dictionary and
 * store it in the hash table.  You should first open the file specified,
 * then read the words one at a time and insert them into the dictionary.
 * Once the file is read in completely, return.  You will need to allocate
 * (using malloc()) space for each word.  As described in the spec, you
 * can initially assume that no word is longer than 60 characters.  However,
 * for the final 20% of your grade, you cannot assumed that words have a bounded
 * length.  You CANNOT assume that the specified file exists.  If the file does
 * NOT exist, you should print some message to standard error and call exit(1)
 * to cleanly exit the program.
 *
 * Since the format is one word at a time, with new lines in between,
 * you can safely use fscanf() to read in the strings until you want to handle
 * arbitrarily long dictionary chacaters.
 */
void readDictionary(char *dictName) {
  // -- TODO --
  FILE *fp;
  fp = fopen(dictName, "r");
  if (fp == NULL) {
    fprintf(stderr, "File not exisits.");
    exit(1);
  } 
  // 简单实现（没法完成长度大于60的word处理）
  // while (!feof(fp)) {
  //   char *word = (char *) malloc(sizeof(char) * 60);
  //   fscanf(fp, word);
  //   insertData(dictionary, word, word);
  // }
  // 完整实现
  char c;
  int i = 0;
  int total_size = 60;
  char *word = (char *) malloc(sizeof(char) * total_size);
  while ((c = fgetc(fp)) != EOF) {
    // 当前字符不是回车
    if (c != '\n') {
      word[i++] = c;
    } else {
      // 当前字符是回车
      word[i] = '\0';
      if(findData(dictionary, word) == NULL) {
        insertData(dictionary, word, word);
      }
      // 重新初始化参数
      i = 0;
      total_size = 60;
      word = (char *) malloc(sizeof(char) * total_size);
      // continue
      continue;
    }

    // 检查是否Overflow (bigger than current size)
    if (i == total_size) {
      // 将total_size变为当前两倍
      total_size *= 2;
      word = (char *) realloc(word, total_size);
    }

  }
  free(word);
  fclose(fp);
  return;
}

/*
 * This should process standard input (stdin) and copy it to standard
 * output (stdout) as specified in the spec (e.g., if a standard 
 * dictionary was used and the string "this is a taest of  this-proGram" 
 * was given to stdin, the output to stdout should be 
 * "this is a teast [sic] of  this-proGram").  All words should be checked
 * against the dictionary as they are input, then with all but the first
 * letter converted to lowercase, and finally with all letters converted
 * to lowercase.  Only if all 3 cases are not in the dictionary should it
 * be reported as not found by appending " [sic]" after the error.
 *
 * Since we care about preserving whitespace and pass through all non alphabet
 * characters untouched, scanf() is probably insufficent (since it only considers
 * whitespace as breaking strings), meaning you will probably have
 * to get characters from stdin one at a time.
 *
 * Do note that even under the initial assumption that no word is longer than 60
 * characters, you may still encounter strings of non-alphabetic characters (e.g.,
 * numbers and punctuation) which are longer than 60 characters. Again, for the 
 * final 20% of your grade, you cannot assume words have a bounded length.
 */
void processInput() {
  // -- TODO --
  // 逐个字符进行处理 
  char c;
  int i = 0;
  int total_size = 60;
  char * word = (char *) malloc(sizeof(char) * total_size);
  char * all_but_first_lowercase = (char *) malloc(sizeof(char) * total_size);
  char * all_lowercase = (char *) malloc(sizeof(char) * total_size);

  while ((c = fgetc(stdin)) != EOF)
  {
    // 1. 如果当前字符为char则等待后续char 直到再次读到空格或数字 进行查询
    if (isalpha(c)) {
      word[i++] = c;
      // 如果i == total_size则扩大内存
      if (i == total_size) {
        total_size *= 2;
        word = (char *) realloc(word, sizeof(char) * total_size);
        all_but_first_lowercase = (char *) realloc(all_but_first_lowercase, sizeof(char) * total_size);
        all_lowercase = (char *) realloc(all_lowercase, sizeof(char) * total_size);
      }
    } else {
      // 2. 如果当前字符为空格或数字则check 然后直接copy到stdout
      if (i == 0) {
        fprintf(stdout, "%c", c);
        continue;
      }
      // 准备三种word
      word[i] = '\0';
      for (int j = 0; j < strlen(word); j++) {
        if (j == 0) {
          all_but_first_lowercase[j] = word[j];
          all_lowercase[j] = tolower(word[j]);
        } else {
          all_but_first_lowercase[j] = tolower(word[j]);
          all_lowercase[j] = tolower(word[j]);
        }
      }
      // 分别检查
      if (findData(dictionary, word) || findData(dictionary, all_but_first_lowercase) || findData(dictionary, all_lowercase)) {
        fprintf(stdout, "%s", word);
      } else {
        fprintf(stdout, "%s [sic]", word);
      }
      fprintf(stdout, "%c", c);
      // 检查后reinitalize
      i = 0;
      total_size = 60;
      word = (char *) malloc(sizeof(char) * total_size);
      all_but_first_lowercase = (char *) malloc(sizeof(char) * total_size);
      all_lowercase = (char *) malloc(sizeof(char) * total_size);
    }
  }

  // 2. 如果当前字符为空格或数字则check 然后直接copy到stdout
  if (i == 0) {
    return;
  } else {
    // 准备三种word
    word[i] = '\0';
    for (int j = 0; j < strlen(word); j++) {
      if (j == 0) {
        all_but_first_lowercase[j] = word[j];
        all_lowercase[j] = tolower(word[j]);
      } else {
        all_but_first_lowercase[j] = tolower(word[j]);
        all_lowercase[j] = tolower(word[j]);
      }
    }
    // 分别检查
    if (findData(dictionary, word) || findData(dictionary, all_but_first_lowercase) || findData(dictionary, all_lowercase)) {
      fprintf(stdout, "%s", word);
    } else {
      fprintf(stdout, "%s [sic]", word);
    }
  }
  free(word);
  free(all_but_first_lowercase);
  free(all_lowercase);
      
  return;
  
}
