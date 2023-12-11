From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 11 Dec 2023 18:02:14 +0100
Message-Id: <20231211170214.85417-1-frank@...2641...>
In-Reply-To: <gerrit.1702052980000.I911fb5c5fa4b41f1fc1a30c6bf8b314245f64a6e@...2715...>
References: <gerrit.1702052980000.I911fb5c5fa4b41f1fc1a30c6bf8b314245f64a6e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] buffer: add documentation for string_mod
 and extend related UT
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Arne Schwabe <arne-openvpn@...1227...>

Since I was confused what exactly string_mod does, I
added documentation and additional UTs to make it
clearer.

Change-Id: I911fb5c5fa4b41f1fc1a30c6bf8b314245f64a6e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master and release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/472
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 0456b27..61fc3a5 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -898,51 +898,78 @@
 
 /* character classes */
 
-#define CC_ANY                (1<<0)
-#define CC_NULL               (1<<1)
+#define CC_ANY                (1<<0) /**< any character */
+#define CC_NULL               (1<<1) /**< null character \0 */
 
-#define CC_ALNUM              (1<<2)
-#define CC_ALPHA              (1<<3)
-#define CC_ASCII              (1<<4)
-#define CC_CNTRL              (1<<5)
-#define CC_DIGIT              (1<<6)
-#define CC_PRINT              (1<<7)
-#define CC_PUNCT              (1<<8)
-#define CC_SPACE              (1<<9)
-#define CC_XDIGIT             (1<<10)
+#define CC_ALNUM              (1<<2) /**< alphanumeric isalnum() */
+#define CC_ALPHA              (1<<3) /**< alphabetic isalpha() */
+#define CC_ASCII              (1<<4) /**< ASCII character */
+#define CC_CNTRL              (1<<5) /**< control character iscntrl() */
+#define CC_DIGIT              (1<<6) /**< digit isdigit() */
+#define CC_PRINT              (1<<7) /**< printable (>= 32, != 127) */
+#define CC_PUNCT              (1<<8) /**< punctuation ispunct() */
+#define CC_SPACE              (1<<9) /**< whitespace isspace() */
+#define CC_XDIGIT             (1<<10) /**< hex digit isxdigit() */
 
-#define CC_BLANK              (1<<11)
-#define CC_NEWLINE            (1<<12)
-#define CC_CR                 (1<<13)
+#define CC_BLANK              (1<<11) /**< space or tab */
+#define CC_NEWLINE            (1<<12) /**< newline */
+#define CC_CR                 (1<<13) /**< carriage return */
 
-#define CC_BACKSLASH          (1<<14)
-#define CC_UNDERBAR           (1<<15)
-#define CC_DASH               (1<<16)
-#define CC_DOT                (1<<17)
-#define CC_COMMA              (1<<18)
-#define CC_COLON              (1<<19)
-#define CC_SLASH              (1<<20)
-#define CC_SINGLE_QUOTE       (1<<21)
-#define CC_DOUBLE_QUOTE       (1<<22)
-#define CC_REVERSE_QUOTE      (1<<23)
-#define CC_AT                 (1<<24)
-#define CC_EQUAL              (1<<25)
-#define CC_LESS_THAN          (1<<26)
-#define CC_GREATER_THAN       (1<<27)
-#define CC_PIPE               (1<<28)
-#define CC_QUESTION_MARK      (1<<29)
-#define CC_ASTERISK           (1<<30)
+#define CC_BACKSLASH          (1<<14) /**< backslash */
+#define CC_UNDERBAR           (1<<15) /**< underscore */
+#define CC_DASH               (1<<16) /**< dash */
+#define CC_DOT                (1<<17) /**< dot */
+#define CC_COMMA              (1<<18) /**< comma */
+#define CC_COLON              (1<<19) /**< colon */
+#define CC_SLASH              (1<<20) /**< slash */
+#define CC_SINGLE_QUOTE       (1<<21) /**< single quote */
+#define CC_DOUBLE_QUOTE       (1<<22) /**< double quote */
+#define CC_REVERSE_QUOTE      (1<<23) /**< reverse quote */
+#define CC_AT                 (1<<24) /**< at sign */
+#define CC_EQUAL              (1<<25) /**< equal sign */
+#define CC_LESS_THAN          (1<<26) /**< less than sign */
+#define CC_GREATER_THAN       (1<<27) /**< greater than sign */
+#define CC_PIPE               (1<<28) /**< pipe */
+#define CC_QUESTION_MARK      (1<<29) /**< question mark */
+#define CC_ASTERISK           (1<<30) /**< asterisk */
 
 /* macro classes */
-#define CC_NAME               (CC_ALNUM|CC_UNDERBAR)
-#define CC_CRLF               (CC_CR|CC_NEWLINE)
+#define CC_NAME               (CC_ALNUM|CC_UNDERBAR) /**< alphanumeric plus underscore */
+#define CC_CRLF               (CC_CR|CC_NEWLINE) /**< carriage return or newline */
 
 bool char_class(const unsigned char c, const unsigned int flags);
 
 bool string_class(const char *str, const unsigned int inclusive, const unsigned int exclusive);
 
+/**
+ * Modifies a string in place by replacing certain classes of characters of it with a specified
+ * character.
+ *
+ * Guaranteed to not increase the length of the string.
+ * If replace is 0, characters are skipped instead of replaced.
+ *
+ * @param str The string to be modified.
+ * @param inclusive The character classes not to be replaced.
+ * @param exclusive Character classes to be replaced even if they are also in inclusive.
+ * @param replace The character to replace the specified character classes with.
+ * @return True if the string was not modified, false otherwise.
+ */
 bool string_mod(char *str, const unsigned int inclusive, const unsigned int exclusive, const char replace);
 
+/**
+ * Returns a copy of a string with certain classes of characters of it replaced with a specified
+ * character.
+ *
+ * If replace is 0, characters are skipped instead of replaced.
+ *
+ * @param str       The input string to be modified.
+ * @param inclusive Character classes not to be replaced.
+ * @param exclusive Character classes to be replaced even if they are also in inclusive.
+ * @param replace   The character to replace the specified character classes with.
+ * @param gc        The garbage collector arena to allocate memory from.
+ *
+ * @return The modified string with characters replaced within the specified range.
+ */
 const char *string_mod_const(const char *str,
                              const unsigned int inclusive,
                              const unsigned int exclusive,
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index f994812..ee84c1f 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -324,23 +324,32 @@
 {
     char buf[256];
     strcpy(buf, "There is \x01 a nice 1234 year old tr\x7f ee!");
-    string_mod(buf, CC_PRINT, 0, '@');
+    assert_false(string_mod(buf, CC_PRINT, 0, '@'));
     assert_string_equal(buf, "There is @ a nice 1234 year old tr@ ee!");
 
     strcpy(buf, "There is \x01 a nice 1234 year old tr\x7f ee!");
-    string_mod(buf, CC_PRINT, CC_DIGIT, '@');
+    assert_true(string_mod(buf, CC_ANY, 0, '@'));
+    assert_string_equal(buf, "There is \x01 a nice 1234 year old tr\x7f ee!");
+
+    /* 0 as replace removes characters */
+    strcpy(buf, "There is \x01 a nice 1234 year old tr\x7f ee!");
+    assert_false(string_mod(buf, CC_PRINT, 0, '\0'));
+    assert_string_equal(buf, "There is  a nice 1234 year old tr ee!");
+
+    strcpy(buf, "There is \x01 a nice 1234 year old tr\x7f ee!");
+    assert_false(string_mod(buf, CC_PRINT, CC_DIGIT, '@'));
     assert_string_equal(buf, "There is @ a nice @@@@ year old tr@ ee!");
 
     strcpy(buf, "There is \x01 a nice 1234 year old tr\x7f ee!");
-    string_mod(buf, CC_ALPHA, CC_DIGIT, '.');
+    assert_false(string_mod(buf, CC_ALPHA, CC_DIGIT, '.'));
     assert_string_equal(buf, "There.is...a.nice......year.old.tr..ee.");
 
     strcpy(buf, "There is \x01 a 'nice' \"1234\"\n year old \ntr\x7f ee!");
-    string_mod(buf, CC_ALPHA|CC_DIGIT|CC_NEWLINE|CC_SINGLE_QUOTE, CC_DOUBLE_QUOTE|CC_BLANK, '.');
+    assert_false(string_mod(buf, CC_ALPHA|CC_DIGIT|CC_NEWLINE|CC_SINGLE_QUOTE, CC_DOUBLE_QUOTE|CC_BLANK, '.'));
     assert_string_equal(buf, "There.is...a.'nice'..1234.\n.year.old.\ntr..ee.");
 
     strcpy(buf, "There is a \\'nice\\' \"1234\" [*] year old \ntree!");
-    string_mod(buf, CC_PRINT, CC_BACKSLASH|CC_ASTERISK, '.');
+    assert_false(string_mod(buf, CC_PRINT, CC_BACKSLASH|CC_ASTERISK, '.'));
     assert_string_equal(buf, "There is a .'nice.' \"1234\" [.] year old .tree!");
 }
 

