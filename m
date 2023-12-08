From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 8 Dec 2023 16:29:49 +0000
References: <gerrit.1702052980000.I911fb5c5fa4b41f1fc1a30c6bf8b314245f64a6e@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7153edcd45b85278164dbb86bf98b232c4090856-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+NCCO5RX6vY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: add
 documentation for string_mod and extend related UT
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+NCCO5RX6vY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/472?usp=3Demail

to review the following change.


Change subject: buffer: add documentation for string_mod and extend related=
 UT
......................................................................

buffer: add documentation for string_mod and extend related UT

Since I was confused what exactly string_mod does, I
added documentation and additional UTs to make it
clearer.

Change-Id: I911fb5c5fa4b41f1fc1a30c6bf8b314245f64a6e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/buffer.h
M tests/unit_tests/openvpn/test_buffer.c
2 files changed, 74 insertions(+), 38 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/472/1

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
+#define CC_PRINT              (1<<7) /**< printable (>=3D 32, !=3D 127) */
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
+#define CC_NAME               (CC_ALNUM|CC_UNDERBAR) /**< alphanumeric plu=
s underscore */
+#define CC_CRLF               (CC_CR|CC_NEWLINE) /**< carriage return or n=
ewline */

 bool char_class(const unsigned char c, const unsigned int flags);

 bool string_class(const char *str, const unsigned int inclusive, const uns=
igned int exclusive);

+/**
+ * Modifies a string in place by replacing certain classes of characters o=
f it with a specified
+ * character.
+ *
+ * Guaranteed to not increase the length of the string.
+ * If replace is 0, characters are skipped instead of replaced.
+ *
+ * @param str The string to be modified.
+ * @param inclusive The character classes not to be replaced.
+ * @param exclusive Character classes to be replaced even if they are also=
 in inclusive.
+ * @param replace The character to replace the specified character classes=
 with.
+ * @return True if the string was not modified, false otherwise.
+ */
 bool string_mod(char *str, const unsigned int inclusive, const unsigned in=
t exclusive, const char replace);

+/**
+ * Returns a copy of a string with certain classes of characters of it rep=
laced with a specified
+ * character.
+ *
+ * If replace is 0, characters are skipped instead of replaced.
+ *
+ * @param str       The input string to be modified.
+ * @param inclusive Character classes not to be replaced.
+ * @param exclusive Character classes to be replaced even if they are also=
 in inclusive.
+ * @param replace   The character to replace the specified character class=
es with.
+ * @param gc        The garbage collector arena to allocate memory from.
+ *
+ * @return The modified string with characters replaced within the specifi=
ed range.
+ */
 const char *string_mod_const(const char *str,
                              const unsigned int inclusive,
                              const unsigned int exclusive,
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
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
+    assert_string_equal(buf, "There is \x01 a nice 1234 year old tr\x7f ee=
!");
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
-    string_mod(buf, CC_ALPHA|CC_DIGIT|CC_NEWLINE|CC_SINGLE_QUOTE, CC_DOUBL=
E_QUOTE|CC_BLANK, '.');
+    assert_false(string_mod(buf, CC_ALPHA|CC_DIGIT|CC_NEWLINE|CC_SINGLE_QU=
OTE, CC_DOUBLE_QUOTE|CC_BLANK, '.'));
     assert_string_equal(buf, "There.is...a.'nice'..1234.\n.year.old.\ntr..=
ee.");

     strcpy(buf, "There is a \\'nice\\' \"1234\" [*] year old \ntree!");
-    string_mod(buf, CC_PRINT, CC_BACKSLASH|CC_ASTERISK, '.');
+    assert_false(string_mod(buf, CC_PRINT, CC_BACKSLASH|CC_ASTERISK, '.'));
     assert_string_equal(buf, "There is a .'nice.' \"1234\" [.] year old .t=
ree!");
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/472?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I911fb5c5fa4b41f1fc1a30c6bf8b314245f64a6e
Gerrit-Change-Number: 472
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--+NCCO5RX6vY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/472?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">buffer: add documentation for string_mod and extend related U=
T<br><br>Since I was confused what exactly string_mod does, I<br>added docu=
mentation and additional UTs to make it<br>clearer.<br><br>Change-Id: I911f=
b5c5fa4b41f1fc1a30c6bf8b314245f64a6e<br>Signed-off-by: Frank Lichtenheld &l=
t;frank@...2641...&gt;<br>---<br>M src/openvpn/buffer.h<br>M tests/unit_tes=
ts/openvpn/test_buffer.c<br>2 files changed, 74 insertions(+), 38 deletions=
(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
72/472/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h</=
span><br><span>index 0456b27..61fc3a5 100644</span><br><span>--- a/src/open=
vpn/buffer.h</span><br><span>+++ b/src/openvpn/buffer.h</span><br><span>@@ =
-898,51 +898,78 @@</span><br><span> </span><br><span> /* character classes =
*/</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define CC_ANY                (1&lt;&lt;0)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define CC_NULL               (1&lt;&lt;1)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define CC_ANY                (1=
&lt;&lt;0) /**&lt; any character */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define CC_NULL               (1&lt;&lt;1) /**&lt; null cha=
racter \0 */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define CC_ALNUM              (1&lt;&lt;2)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define CC_ALPHA              (1&lt;&lt;3)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_ASCII      =
        (1&lt;&lt;4)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define CC_CNTRL              (1&lt;&lt;5)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define CC_DIGIT              (1&lt;&lt;6)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define CC_PRINT              (1&l=
t;&lt;7)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_PU=
NCT              (1&lt;&lt;8)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define CC_SPACE              (1&lt;&lt;9)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define CC_XDIGIT             (1&lt;&lt;10)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_ALNUM      =
        (1&lt;&lt;2) /**&lt; alphanumeric isalnum() */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define CC_ALPHA              (1&lt;&lt;=
3) /**&lt; alphabetic isalpha() */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define CC_ASCII              (1&lt;&lt;4) /**&lt; ASCII cha=
racter */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC=
_CNTRL              (1&lt;&lt;5) /**&lt; control character iscntrl() */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_DIGIT       =
       (1&lt;&lt;6) /**&lt; digit isdigit() */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define CC_PRINT              (1&lt;&lt;7) /**&l=
t; printable (&gt;=3D 32, !=3D 127) */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define CC_PUNCT              (1&lt;&lt;8) /**&lt; punct=
uation ispunct() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define CC_SPACE              (1&lt;&lt;9) /**&lt; whitespace isspace() */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_XDIGIT   =
          (1&lt;&lt;10) /**&lt; hex digit isxdigit() */</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_BLANK       =
       (1&lt;&lt;11)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define CC_NEWLINE            (1&lt;&lt;12)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define CC_CR                 (1&lt;&lt;13)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define CC_BLANK              =
(1&lt;&lt;11) /**&lt; space or tab */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define CC_NEWLINE            (1&lt;&lt;12) /**&lt; newli=
ne */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_CR =
                (1&lt;&lt;13) /**&lt; carriage return */</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_BACKSLASH  =
        (1&lt;&lt;14)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define CC_UNDERBAR           (1&lt;&lt;15)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define CC_DASH               (1&lt;&lt;16)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_DOT                (=
1&lt;&lt;17)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define C=
C_COMMA              (1&lt;&lt;18)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define CC_COLON              (1&lt;&lt;19)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define CC_SLASH              (1&lt;&lt;=
20)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_SINGLE_=
QUOTE       (1&lt;&lt;21)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define CC_DOUBLE_QUOTE       (1&lt;&lt;22)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#define CC_REVERSE_QUOTE      (1&lt;&lt;23)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_AT              =
   (1&lt;&lt;24)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne CC_EQUAL              (1&lt;&lt;25)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define CC_LESS_THAN          (1&lt;&lt;26)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define CC_GREATER_THAN       (1&lt;=
&lt;27)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_PIP=
E               (1&lt;&lt;28)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define CC_QUESTION_MARK      (1&lt;&lt;29)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define CC_ASTERISK           (1&lt;&lt;30)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_BACKSLAS=
H          (1&lt;&lt;14) /**&lt; backslash */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define CC_UNDERBAR           (1&lt;&lt;15) /**&l=
t; underscore */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine CC_DASH               (1&lt;&lt;16) /**&lt; dash */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define CC_DOT                (1&lt;&l=
t;17) /**&lt; dot */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define CC_COMMA              (1&lt;&lt;18) /**&lt; comma */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define CC_COLON              (1&=
lt;&lt;19) /**&lt; colon */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define CC_SLASH              (1&lt;&lt;20) /**&lt; slash */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_SINGLE_QUOTE   =
    (1&lt;&lt;21) /**&lt; single quote */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define CC_DOUBLE_QUOTE       (1&lt;&lt;22) /**&lt; d=
ouble quote */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne CC_REVERSE_QUOTE      (1&lt;&lt;23) /**&lt; reverse quote */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define CC_AT                 (=
1&lt;&lt;24) /**&lt; at sign */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define CC_EQUAL              (1&lt;&lt;25) /**&lt; equal sign =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_LESS_T=
HAN          (1&lt;&lt;26) /**&lt; less than sign */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define CC_GREATER_THAN       (1&lt;&lt;2=
7) /**&lt; greater than sign */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define CC_PIPE               (1&lt;&lt;28) /**&lt; pipe */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_QUESTION_MAR=
K      (1&lt;&lt;29) /**&lt; question mark */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define CC_ASTERISK           (1&lt;&lt;30) /**&l=
t; asterisk */</span><br><span> </span><br><span> /* macro classes */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_NAME            =
   (CC_ALNUM|CC_UNDERBAR)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define CC_CRLF               (CC_CR|CC_NEWLINE)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define CC_NAME               (CC_ALNUM|C=
C_UNDERBAR) /**&lt; alphanumeric plus underscore */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define CC_CRLF               (CC_CR|CC_N=
EWLINE) /**&lt; carriage return or newline */</span><br><span> </span><br><=
span> bool char_class(const unsigned char c, const unsigned int flags);</sp=
an><br><span> </span><br><span> bool string_class(const char *str, const un=
signed int inclusive, const unsigned int exclusive);</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Modifies a string in place by replaci=
ng certain classes of characters of it with a specified</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * character.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Guaranteed to not increase the length of the string.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * If replace is 0, charac=
ters are skipped instead of replaced.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param str The string to be modified.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param inclusive The character classes not to be r=
eplaced.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param e=
xclusive Character classes to be replaced even if they are also in inclusiv=
e.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param replace=
 The character to replace the specified character classes with.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return True if the string w=
as not modified, false otherwise.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span> bool string_mod(char *str, const unsigne=
d int inclusive, const unsigned int exclusive, const char replace);</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Returns a copy of a st=
ring with certain classes of characters of it replaced with a specified</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * character.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * If replace is 0, characters are skipped ins=
tead of replaced.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param str      =
 The input string to be modified.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param inclusive Character classes not to be replaced.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param exclusive Cha=
racter classes to be replaced even if they are also in inclusive.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param replace   The chara=
cter to replace the specified character classes with.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param gc        The garbage collector=
 arena to allocate memory from.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn The modified string with characters replaced within the specified ran=
ge.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan> const char *string_mod_const(const char *str,</span><br><span>        =
                      const unsigned int inclusive,</span><br><span>       =
                       const unsigned int exclusive,</span><br><span>diff -=
-git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/te=
st_buffer.c</span><br><span>index f994812..ee84c1f 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/test_buffer.c</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_buffer.c</span><br><span>@@ -324,23 +324,32 @@</span><=
br><span> {</span><br><span>     char buf[256];</span><br><span>     strcpy=
(buf, &quot;There is \x01 a nice 1234 year old tr\x7f ee!&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    string_mod(buf, CC_PRINT, 0=
, &#39;@&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_false(string_mod(buf, CC_PRINT, 0, &#39;@&#39;));</span><br><span>  =
   assert_string_equal(buf, &quot;There is @ a nice 1234 year old tr@ ee!&q=
uot;);</span><br><span> </span><br><span>     strcpy(buf, &quot;There is \x=
01 a nice 1234 year old tr\x7f ee!&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    string_mod(buf, CC_PRINT, CC_DIGIT, &#39;@&#39;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(stri=
ng_mod(buf, CC_ANY, 0, &#39;@&#39;));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_string_equal(buf, &quot;There is \x01 a nice 1=
234 year old tr\x7f ee!&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
0 as replace removes characters */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    strcpy(buf, &quot;There is \x01 a nice 1234 year old tr\=
x7f ee!&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_false(string_mod(buf, CC_PRINT, 0, &#39;\0&#39;));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(buf, &quot;Th=
ere is  a nice 1234 year old tr ee!&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    strcpy(buf, &quot;There is \x01 a nice 1234 year old tr\x7f ee!&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fal=
se(string_mod(buf, CC_PRINT, CC_DIGIT, &#39;@&#39;));</span><br><span>     =
assert_string_equal(buf, &quot;There is @ a nice @@@@ year old tr@ ee!&quot=
;);</span><br><span> </span><br><span>     strcpy(buf, &quot;There is \x01 =
a nice 1234 year old tr\x7f ee!&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    string_mod(buf, CC_ALPHA, CC_DIGIT, &#39;.&#39;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(string=
_mod(buf, CC_ALPHA, CC_DIGIT, &#39;.&#39;));</span><br><span>     assert_st=
ring_equal(buf, &quot;There.is...a.nice......year.old.tr..ee.&quot;);</span=
><br><span> </span><br><span>     strcpy(buf, &quot;There is \x01 a &#39;ni=
ce&#39; \&quot;1234\&quot;\n year old \ntr\x7f ee!&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    string_mod(buf, CC_ALPHA|CC_DIGIT|=
CC_NEWLINE|CC_SINGLE_QUOTE, CC_DOUBLE_QUOTE|CC_BLANK, &#39;.&#39;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(string_mod=
(buf, CC_ALPHA|CC_DIGIT|CC_NEWLINE|CC_SINGLE_QUOTE, CC_DOUBLE_QUOTE|CC_BLAN=
K, &#39;.&#39;));</span><br><span>     assert_string_equal(buf, &quot;There=
.is...a.&#39;nice&#39;..1234.\n.year.old.\ntr..ee.&quot;);</span><br><span>=
 </span><br><span>     strcpy(buf, &quot;There is a \\&#39;nice\\&#39; \&qu=
ot;1234\&quot; [*] year old \ntree!&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    string_mod(buf, CC_PRINT, CC_BACKSLASH|CC_ASTERIS=
K, &#39;.&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_false(string_mod(buf, CC_PRINT, CC_BACKSLASH|CC_ASTERISK, &#39;.&#3=
9;));</span><br><span>     assert_string_equal(buf, &quot;There is a .&#39;=
nice.&#39; \&quot;1234\&quot; [.] year old .tree!&quot;);</span><br><span> =
}</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/472?usp=3Demail">change 472</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/472?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I911fb5c5fa4b41f1fc1a30c6bf8=
b314245f64a6e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 472 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--+NCCO5RX6vY=--

