From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 12 Dec 2023 07:13:56 +0000
In-Reply-To: <gerrit.1702052980000.I911fb5c5fa4b41f1fc1a30c6bf8b314245f64a6e@...2715...>
References: <gerrit.1702052980000.I911fb5c5fa4b41f1fc1a30c6bf8b314245f64a6e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f7a95db468b8b1a0cb6bd7d1bbbaea5a02f7bbcd-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SWRkO+T9pr0="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SWRkO+T9pr0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/472?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: buffer: add documentation for string_mod and extend related=
 UT
......................................................................

buffer: add documentation for string_mod and extend related UT

Since I was confused what exactly string_mod does, I
added documentation and additional UTs to make it
clearer.

Change-Id: I911fb5c5fa4b41f1fc1a30c6bf8b314245f64a6e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20231211170214.85417-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
761.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/buffer.h
M tests/unit_tests/openvpn/test_buffer.c
2 files changed, 74 insertions(+), 38 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/472/2

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
=20
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--SWRkO+T9pr0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/472?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">buffer: add documentation for string_mod and ext=
end related UT<br><br>Since I was confused what exactly string_mod does, I<=
br>added documentation and additional UTs to make it<br>clearer.<br><br>Cha=
nge-Id: I911fb5c5fa4b41f1fc1a30c6bf8b314245f64a6e<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-open=
vpn@...1227...&gt;<br>Message-Id: &lt;20231211170214.85417-1-frank@...2724...=
..&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...282...=
.net/msg27761.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>---<br>M src/openvpn/buffer.h<br>M tests/unit_tests/openvpn/test_buffer.c=
<br>2 files changed, 74 insertions(+), 38 deletions(-)<br><br></pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit.openvpn.net:29418/openvpn refs/changes/72/472/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/buffer.h b/src/openvpn/buffer.h</span><br><span>index 045=
6b27..61fc3a5 100644</span><br><span>--- a/src/openvpn/buffer.h</span><br><=
span>+++ b/src/openvpn/buffer.h</span><br><span>@@ -898,51 +898,78 @@</span=
><br><span> </span><br><span> /* character classes */</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_ANY           =
     (1&lt;&lt;0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine CC_NULL               (1&lt;&lt;1)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define CC_ANY                (1&lt;&lt;0) /**&lt; any c=
haracter */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
CC_NULL               (1&lt;&lt;1) /**&lt; null character \0 */</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_ALNU=
M              (1&lt;&lt;2)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define CC_ALPHA              (1&lt;&lt;3)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define CC_ASCII              (1&lt;&lt;4)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_CNTRL           =
   (1&lt;&lt;5)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e CC_DIGIT              (1&lt;&lt;6)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define CC_PRINT              (1&lt;&lt;7)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define CC_PUNCT              (1&lt;&lt=
;8)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_SPACE  =
            (1&lt;&lt;9)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define CC_XDIGIT             (1&lt;&lt;10)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define CC_ALNUM              (1&lt;&lt;2) /**&l=
t; alphanumeric isalnum() */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define CC_ALPHA              (1&lt;&lt;3) /**&lt; alphabetic isal=
pha() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_=
ASCII              (1&lt;&lt;4) /**&lt; ASCII character */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define CC_CNTRL              (1&lt;=
&lt;5) /**&lt; control character iscntrl() */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define CC_DIGIT              (1&lt;&lt;6) /**&lt=
; digit isdigit() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define CC_PRINT              (1&lt;&lt;7) /**&lt; printable (&gt;=3D 32, =
!=3D 127) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 CC_PUNCT              (1&lt;&lt;8) /**&lt; punctuation ispunct() */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_SPACE          =
    (1&lt;&lt;9) /**&lt; whitespace isspace() */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define CC_XDIGIT             (1&lt;&lt;10) /*=
*&lt; hex digit isxdigit() */</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#define CC_BLANK              (1&lt;&lt;11)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_NEWLINE         =
   (1&lt;&lt;12)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne CC_CR                 (1&lt;&lt;13)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define CC_BLANK              (1&lt;&lt;11) /**&lt; spac=
e or tab */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
CC_NEWLINE            (1&lt;&lt;12) /**&lt; newline */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define CC_CR                 (1&lt;&lt;=
13) /**&lt; carriage return */</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define CC_BACKSLASH          (1&lt;&lt;14)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_UNDERBAR       =
    (1&lt;&lt;15)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine CC_DASH               (1&lt;&lt;16)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define CC_DOT                (1&lt;&lt;17)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define CC_COMMA              (1&lt=
;&lt;18)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_CO=
LON              (1&lt;&lt;19)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define CC_SLASH              (1&lt;&lt;20)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define CC_SINGLE_QUOTE       (1&lt;&lt;21)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_DOUBLE_QUO=
TE       (1&lt;&lt;22)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define CC_REVERSE_QUOTE      (1&lt;&lt;23)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define CC_AT                 (1&lt;&lt;24)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_EQUAL              =
(1&lt;&lt;25)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
CC_LESS_THAN          (1&lt;&lt;26)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define CC_GREATER_THAN       (1&lt;&lt;27)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define CC_PIPE               (1&lt;&lt=
;28)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_QUESTI=
ON_MARK      (1&lt;&lt;29)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define CC_ASTERISK           (1&lt;&lt;30)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define CC_BACKSLASH          (1&lt;&lt;14) /*=
*&lt; backslash */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define CC_UNDERBAR           (1&lt;&lt;15) /**&lt; underscore */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define CC_DASH               =
(1&lt;&lt;16) /**&lt; dash */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define CC_DOT                (1&lt;&lt;17) /**&lt; dot */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_COMMA          =
    (1&lt;&lt;18) /**&lt; comma */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define CC_COLON              (1&lt;&lt;19) /**&lt; colon */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_SLASH   =
           (1&lt;&lt;20) /**&lt; slash */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define CC_SINGLE_QUOTE       (1&lt;&lt;21) /**&lt; s=
ingle quote */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne CC_DOUBLE_QUOTE       (1&lt;&lt;22) /**&lt; double quote */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define CC_REVERSE_QUOTE      (1=
&lt;&lt;23) /**&lt; reverse quote */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define CC_AT                 (1&lt;&lt;24) /**&lt; at sig=
n */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_EQUA=
L              (1&lt;&lt;25) /**&lt; equal sign */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define CC_LESS_THAN          (1&lt;&lt;26) =
/**&lt; less than sign */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define CC_GREATER_THAN       (1&lt;&lt;27) /**&lt; greater than sign=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC_PIPE =
              (1&lt;&lt;28) /**&lt; pipe */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define CC_QUESTION_MARK      (1&lt;&lt;29) /**&lt;=
 question mark */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine CC_ASTERISK           (1&lt;&lt;30) /**&lt; asterisk */</span><br><sp=
an> </span><br><span> /* macro classes */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define CC_NAME               (CC_ALNUM|CC_UNDERBAR)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_CRLF         =
      (CC_CR|CC_NEWLINE)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define CC_NAME               (CC_ALNUM|CC_UNDERBAR) /**&lt; alphanume=
ric plus underscore */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define CC_CRLF               (CC_CR|CC_NEWLINE) /**&lt; carriage return=
 or newline */</span><br><span> </span><br><span> bool char_class(const uns=
igned char c, const unsigned int flags);</span><br><span> </span><br><span>=
 bool string_class(const char *str, const unsigned int inclusive, const uns=
igned int exclusive);</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Modifies a string in place by replacing certain classes of character=
s of it with a specified</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * character.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Guaranteed to n=
ot increase the length of the string.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * If replace is 0, characters are skipped instead of rep=
laced.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param str The string to be=
 modified.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 inclusive The character classes not to be replaced.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param exclusive Character classes to =
be replaced even if they are also in inclusive.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param replace The character to replace the =
specified character classes with.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @return True if the string was not modified, false otherwi=
se.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan> bool string_mod(char *str, const unsigned int inclusive, const unsigne=
d int exclusive, const char replace);</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Returns a copy of a string with certain classes of c=
haracters of it replaced with a specified</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * character.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* If replace is 0, characters are skipped instead of replaced.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param str       The input string to be modifi=
ed.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param inclus=
ive Character classes not to be replaced.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param exclusive Character classes to be replaced =
even if they are also in inclusive.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param replace   The character to replace the specified =
character classes with.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param gc        The garbage collector arena to allocate memory from=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @return The modified string with=
 characters replaced within the specified range.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span> const char *string_mod_co=
nst(const char *str,</span><br><span>                              const un=
signed int inclusive,</span><br><span>                              const u=
nsigned int exclusive,</span><br><span>diff --git a/tests/unit_tests/openvp=
n/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c</span><br><span>in=
dex f994812..ee84c1f 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_buffer.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer.c<=
/span><br><span>@@ -324,23 +324,32 @@</span><br><span> {</span><br><span>  =
   char buf[256];</span><br><span>     strcpy(buf, &quot;There is \x01 a ni=
ce 1234 year old tr\x7f ee!&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    string_mod(buf, CC_PRINT, 0, &#39;@&#39;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_false(string_mod(buf, C=
C_PRINT, 0, &#39;@&#39;));</span><br><span>     assert_string_equal(buf, &q=
uot;There is @ a nice 1234 year old tr@ ee!&quot;);</span><br><span> </span=
><br><span>     strcpy(buf, &quot;There is \x01 a nice 1234 year old tr\x7f=
 ee!&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strin=
g_mod(buf, CC_PRINT, CC_DIGIT, &#39;@&#39;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(string_mod(buf, CC_ANY, 0, &#39;@&=
#39;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_s=
tring_equal(buf, &quot;There is \x01 a nice 1234 year old tr\x7f ee!&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* 0 as replace removes character=
s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(buf,=
 &quot;There is \x01 a nice 1234 year old tr\x7f ee!&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_false(string_mod(buf, C=
C_PRINT, 0, &#39;\0&#39;));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_string_equal(buf, &quot;There is  a nice 1234 year old t=
r ee!&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(buf, &quot;The=
re is \x01 a nice 1234 year old tr\x7f ee!&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_false(string_mod(buf, CC_PRINT, C=
C_DIGIT, &#39;@&#39;));</span><br><span>     assert_string_equal(buf, &quot=
;There is @ a nice @@@@ year old tr@ ee!&quot;);</span><br><span> </span><b=
r><span>     strcpy(buf, &quot;There is \x01 a nice 1234 year old tr\x7f ee=
!&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    string_m=
od(buf, CC_ALPHA, CC_DIGIT, &#39;.&#39;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_false(string_mod(buf, CC_ALPHA, CC_DIGIT, =
&#39;.&#39;));</span><br><span>     assert_string_equal(buf, &quot;There.is=
...a.nice......year.old.tr..ee.&quot;);</span><br><span> </span><br><span> =
    strcpy(buf, &quot;There is \x01 a &#39;nice&#39; \&quot;1234\&quot;\n y=
ear old \ntr\x7f ee!&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    string_mod(buf, CC_ALPHA|CC_DIGIT|CC_NEWLINE|CC_SINGLE_QUOTE, CC=
_DOUBLE_QUOTE|CC_BLANK, &#39;.&#39;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_false(string_mod(buf, CC_ALPHA|CC_DIGIT|CC_NEW=
LINE|CC_SINGLE_QUOTE, CC_DOUBLE_QUOTE|CC_BLANK, &#39;.&#39;));</span><br><s=
pan>     assert_string_equal(buf, &quot;There.is...a.&#39;nice&#39;..1234.\=
n.year.old.\ntr..ee.&quot;);</span><br><span> </span><br><span>     strcpy(=
buf, &quot;There is a \\&#39;nice\\&#39; \&quot;1234\&quot; [*] year old \n=
tree!&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stri=
ng_mod(buf, CC_PRINT, CC_BACKSLASH|CC_ASTERISK, &#39;.&#39;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(string_mod(buf, =
CC_PRINT, CC_BACKSLASH|CC_ASTERISK, &#39;.&#39;));</span><br><span>     ass=
ert_string_equal(buf, &quot;There is a .&#39;nice.&#39; \&quot;1234\&quot; =
[.] year old .tree!&quot;);</span><br><span> }</span><br><span> </span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/472?usp=3Demail">change 472</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/47=
2?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I911fb5c5fa4b41f1fc1a30c6bf8=
b314245f64a6e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 472 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--SWRkO+T9pr0=--

