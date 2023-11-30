From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 30 Nov 2023 16:24:39 +0000
References: <gerrit.1701361470000.Ib2aa85b9c34d0a0b8b1dfb9f477f56c9a6b705d0@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <11081e6afcc6aa32e3fdf35c8476e9a8f8116eb0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZO7JxvbU8Bo="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace
 character_class_debug with proper unit test
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZO7JxvbU8Bo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/464?usp=3Demail

to review the following change.


Change subject: Replace character_class_debug with proper unit test
......................................................................

Replace character_class_debug with proper unit test

Change-Id: Ib2aa85b9c34d0a0b8b1dfb9f477f56c9a6b705d0
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/buffer.c
M src/openvpn/buffer.h
M src/openvpn/init.c
M tests/unit_tests/openvpn/test_buffer.c
4 files changed, 25 insertions(+), 32 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/464/1

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 24f1ef2..0b94a52 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1150,26 +1150,6 @@
     }
 }

-#ifdef CHARACTER_CLASS_DEBUG
-
-#define CC_INCLUDE    (CC_PRINT)
-#define CC_EXCLUDE    (0)
-#define CC_REPLACE    ('.')
-
-void
-character_class_debug(void)
-{
-    char buf[256];
-
-    while (fgets(buf, sizeof(buf), stdin) !=3D NULL)
-    {
-        string_mod(buf, CC_INCLUDE, CC_EXCLUDE, CC_REPLACE);
-        printf("%s", buf);
-    }
-}
-
-#endif
-
 #ifdef VERIFY_ALIGNMENT
 void
 valign4(const struct buffer *buf, const char *file, const int line)
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 4cc7950..0456b27 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -896,8 +896,6 @@
  */
 const char *np(const char *str);

-/*#define CHARACTER_CLASS_DEBUG*/
-
 /* character classes */

 #define CC_ANY                (1<<0)
@@ -961,11 +959,6 @@
 }


-#ifdef CHARACTER_CLASS_DEBUG
-void character_class_debug(void);
-
-#endif
-
 /*
  * Verify that a pointer is correctly aligned
  */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fdab26b..9972ed7 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -875,11 +875,6 @@
     return false;
 #endif

-#ifdef CHARACTER_CLASS_DEBUG
-    character_class_debug();
-    return false;
-#endif
-
 #ifdef TIME_TEST
     time_test();
     return false;
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
index 8232f92..f994812 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -319,6 +319,30 @@
     gc_free(&gc);
 }

+static void
+test_character_class(void **state)
+{
+    char buf[256];
+    strcpy(buf, "There is \x01 a nice 1234 year old tr\x7f ee!");
+    string_mod(buf, CC_PRINT, 0, '@');
+    assert_string_equal(buf, "There is @ a nice 1234 year old tr@ ee!");
+
+    strcpy(buf, "There is \x01 a nice 1234 year old tr\x7f ee!");
+    string_mod(buf, CC_PRINT, CC_DIGIT, '@');
+    assert_string_equal(buf, "There is @ a nice @@@@ year old tr@ ee!");
+
+    strcpy(buf, "There is \x01 a nice 1234 year old tr\x7f ee!");
+    string_mod(buf, CC_ALPHA, CC_DIGIT, '.');
+    assert_string_equal(buf, "There.is...a.nice......year.old.tr..ee.");
+
+    strcpy(buf, "There is \x01 a 'nice' \"1234\"\n year old \ntr\x7f ee!");
+    string_mod(buf, CC_ALPHA|CC_DIGIT|CC_NEWLINE|CC_SINGLE_QUOTE, CC_DOUBL=
E_QUOTE|CC_BLANK, '.');
+    assert_string_equal(buf, "There.is...a.'nice'..1234.\n.year.old.\ntr..=
ee.");
+
+    strcpy(buf, "There is a \\'nice\\' \"1234\" [*] year old \ntree!");
+    string_mod(buf, CC_PRINT, CC_BACKSLASH|CC_ASTERISK, '.');
+    assert_string_equal(buf, "There is a .'nice.' \"1234\" [.] year old .t=
ree!");
+}

 int
 main(void)
@@ -351,6 +375,7 @@
         cmocka_unit_test(test_buffer_free_gc_one),
         cmocka_unit_test(test_buffer_free_gc_two),
         cmocka_unit_test(test_buffer_gc_realloc),
+        cmocka_unit_test(test_character_class),
     };

     return cmocka_run_group_tests_name("buffer", tests, NULL, NULL);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/464?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib2aa85b9c34d0a0b8b1dfb9f477f56c9a6b705d0
Gerrit-Change-Number: 464
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--ZO7JxvbU8Bo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/464?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Replace character_class_debug with proper unit test<br><br>Ch=
ange-Id: Ib2aa85b9c34d0a0b8b1dfb9f477f56c9a6b705d0<br>Signed-off-by: Arne S=
chwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/buffer.c<br>M src/op=
envpn/buffer.h<br>M src/openvpn/init.c<br>M tests/unit_tests/openvpn/test_b=
uffer.c<br>4 files changed, 25 insertions(+), 32 deletions(-)<br><br></pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/464/1</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span>in=
dex 24f1ef2..0b94a52 100644</span><br><span>--- a/src/openvpn/buffer.c</spa=
n><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -1150,26 +1150,6 =
@@</span><br><span>     }</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#ifdef CHARACTER_CLASS_DEBUG</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define CC_INCLUDE    (CC_PRINT)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define CC_EXCLUDE    (0)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define CC_REPLACE    (&#39;.&#39=
;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-character_class_debug(void)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    char buf[256];</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (fgets(buf=
, sizeof(buf), stdin) !=3D NULL)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   string_mod(buf, CC_INCLUDE, CC_EXCLUDE, CC_REPLACE);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        printf(&quot;%s&quot;, buf);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifde=
f VERIFY_ALIGNMENT</span><br><span> void</span><br><span> valign4(const str=
uct buffer *buf, const char *file, const int line)</span><br><span>diff --g=
it a/src/openvpn/buffer.h b/src/openvpn/buffer.h</span><br><span>index 4cc7=
950..0456b27 100644</span><br><span>--- a/src/openvpn/buffer.h</span><br><s=
pan>+++ b/src/openvpn/buffer.h</span><br><span>@@ -896,8 +896,6 @@</span><b=
r><span>  */</span><br><span> const char *np(const char *str);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*#define CHARAC=
TER_CLASS_DEBUG*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> /* character classes */</span><br><span> </span><br><span> #d=
efine CC_ANY                (1&lt;&lt;0)</span><br><span>@@ -961,11 +959,6 =
@@</span><br><span> }</span><br><span> </span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#ifdef CHARACTER_CLASS_DEBUG</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void character_class_debug(void)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Verify that a p=
ointer is correctly aligned</span><br><span>  */</span><br><span>diff --git=
 a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index fdab26b..9=
972ed7 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ =
b/src/openvpn/init.c</span><br><span>@@ -875,11 +875,6 @@</span><br><span> =
    return false;</span><br><span> #endif</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#ifdef CHARACTER_CLASS_DEBUG</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    character_class_debug();</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return false;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef TIME_TEST</span><=
br><span>     time_test();</span><br><span>     return false;</span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/o=
penvpn/test_buffer.c</span><br><span>index 8232f92..f994812 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_buffer.c</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_buffer.c</span><br><span>@@ -319,6 +319,30 @@=
</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+test_character_class(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    char buf[256];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(buf, &quot;There is=
 \x01 a nice 1234 year old tr\x7f ee!&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    string_mod(buf, CC_PRINT, 0, &#39;@&#39;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equa=
l(buf, &quot;There is @ a nice 1234 year old tr@ ee!&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    strcpy(buf, &quot;There is \x01 a nice 1234 year =
old tr\x7f ee!&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    string_mod(buf, CC_PRINT, CC_DIGIT, &#39;@&#39;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(buf, &quot;The=
re is @ a nice @@@@ year old tr@ ee!&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    strcpy(buf, &quot;There is \x01 a nice 1234 year old tr\x7f ee!&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    string_mo=
d(buf, CC_ALPHA, CC_DIGIT, &#39;.&#39;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(buf, &quot;There.is...a.nice..=
....year.old.tr..ee.&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strcpy=
(buf, &quot;There is \x01 a &#39;nice&#39; \&quot;1234\&quot;\n year old \n=
tr\x7f ee!&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   string_mod(buf, CC_ALPHA|CC_DIGIT|CC_NEWLINE|CC_SINGLE_QUOTE, CC_DOUBLE_=
QUOTE|CC_BLANK, &#39;.&#39;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_string_equal(buf, &quot;There.is...a.&#39;nice&#39;..1=
234.\n.year.old.\ntr..ee.&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
trcpy(buf, &quot;There is a \\&#39;nice\\&#39; \&quot;1234\&quot; [*] year =
old \ntree!&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    string_mod(buf, CC_PRINT, CC_BACKSLASH|CC_ASTERISK, &#39;.&#39;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(b=
uf, &quot;There is a .&#39;nice.&#39; \&quot;1234\&quot; [.] year old .tree=
!&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span> </span><br><span> int</span><br><span> main(void)</span><br><span>=
@@ -351,6 +375,7 @@</span><br><span>         cmocka_unit_test(test_buffer_f=
ree_gc_one),</span><br><span>         cmocka_unit_test(test_buffer_free_gc_=
two),</span><br><span>         cmocka_unit_test(test_buffer_gc_realloc),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_character_class),</span><br><span>     };</span><br><span> </span><=
br><span>     return cmocka_run_group_tests_name(&quot;buffer&quot;, tests,=
 NULL, NULL);</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/464?usp=3Demail">change 464</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/464?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib2aa85b9c34d0a0b8b1dfb9f477=
f56c9a6b705d0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 464 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--ZO7JxvbU8Bo=--

