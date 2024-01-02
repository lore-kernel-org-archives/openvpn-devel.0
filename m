From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 2 Jan 2024 13:46:39 +0000
References: <gerrit.1704203193000.I6899c1af65fbd670d434cdb17f81c82b900bfbd4@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <238dcd1f13f134079d8b0bc6c5c4dc1cc696818b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7OOPwMarMZM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Allow having an
 extra function that is called when an env is freed
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

--7OOPwMarMZM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/486?usp=3Demail

to review the following change.


Change subject: Allow having an extra function that is called when an env i=
s freed
......................................................................

Allow having an extra function that is called when an env is freed

Change-Id: I6899c1af65fbd670d434cdb17f81c82b900bfbd4
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M CMakeLists.txt
M src/openvpn/env_set.c
M src/openvpn/env_set.h
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/test_buffer.c
5 files changed, 106 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/486/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 96328a1..04e9e34 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -685,6 +685,7 @@

     target_sources(test_buffer PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
+        src/openvpn/env_set.c
         )

     target_sources(test_crypto PRIVATE
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index 97b011f..fb7cd98 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -112,6 +112,10 @@
             }
             if (do_free)
             {
+                if (current->free_function)
+                {
+                    current->free_function(current);
+                }
                 secure_memzero(current->string, strlen(current->string));
                 free(current->string);
                 free(current);
@@ -124,15 +128,37 @@
 }

 static void
-add_env_item(char *str, const bool do_alloc, struct env_item **list, struc=
t gc_arena *gc)
+env_gc_freefunction_wrapper(void *arg)
+{
+    struct env_item *ei =3D arg;
+    ei->free_function(ei);
+    free(ei->string);
+    free(ei);
+}
+
+static void
+add_env_item(char *str, void (*free_function)(struct env_item *),
+             struct env_item **list, struct gc_arena *gc)
 {
     struct env_item *item;

     ASSERT(str);
     ASSERT(list);

-    ALLOC_OBJ_GC(item, struct env_item, gc);
-    item->string =3D do_alloc ? string_alloc(str, gc) : str;
+    if (gc && free_function)
+    {
+        /* alloc items manually without gc to allow the gc_wrap_free
+         * function to free them all in the right order */
+        ALLOC_OBJ(item, struct env_item);
+        item->string =3D string_alloc(str, NULL);
+        gc_addspecial(item, env_gc_freefunction_wrapper, gc);
+    }
+    else
+    {
+        ALLOC_OBJ_GC(item, struct env_item, gc);
+        item->string =3D string_alloc(str, gc);
+    }
+    item->free_function =3D free_function;
     item->next =3D *list;
     *list =3D item;
 }
@@ -146,10 +172,11 @@
 }

 static void
-env_set_add_nolock(struct env_set *es, const char *str)
+env_set_add_nolock(struct env_set *es, const char *str,
+                   void (*free_function)(struct env_item *))
 {
     remove_env_item(str, es->gc =3D=3D NULL, &es->list);
-    add_env_item((char *)str, true, &es->list, es->gc);
+    add_env_item((char *)str, free_function, &es->list, es->gc);
 }

 struct env_set *
@@ -171,6 +198,10 @@
         while (e)
         {
             struct env_item *next =3D e->next;
+            if (e->free_function)
+            {
+                e->free_function(e);
+            }
             free(e->string);
             free(e);
             e =3D next;
@@ -194,7 +225,16 @@
 {
     ASSERT(es);
     ASSERT(str);
-    env_set_add_nolock(es, str);
+    env_set_add_nolock(es, str, NULL);
+}
+
+void
+env_set_add_specialfree(struct env_set *es, const char *str,
+                        void (*free_function)(struct env_item *))
+{
+    ASSERT(es);
+    ASSERT(str);
+    env_set_add_nolock(es, str, free_function);
 }

 const char *
@@ -246,7 +286,7 @@
         e =3D src->list;
         while (e)
         {
-            env_set_add_nolock(es, e->string);
+            env_set_add_nolock(es, e->string, e->free_function);
             e =3D e->next;
         }
     }
diff --git a/src/openvpn/env_set.h b/src/openvpn/env_set.h
index 4599977..27bc4dd 100644
--- a/src/openvpn/env_set.h
+++ b/src/openvpn/env_set.h
@@ -36,6 +36,7 @@

 struct env_item {
     char *string;
+    void (*free_function)(struct env_item *);
     struct env_item *next;
 };

@@ -87,6 +88,11 @@

 void env_set_add(struct env_set *es, const char *str);

+void
+env_set_add_specialfree(struct env_set *es, const char *str,
+                        void (*free_function)(struct env_item *));
+
+
 const char *env_set_get(const struct env_set *es, const char *name);

 void env_set_print(int msglevel, const struct env_set *es);
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 6667626..c5098a9 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -52,6 +52,7 @@
 buffer_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -=
Wl,--wrap=3Dparse_line
 buffer_testdriver_SOURCES =3D test_buffer.c mock_msg.c mock_msg.h \
 	mock_get_random.c \
+	$(top_srcdir)/src/openvpn/env_set.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/platform.c

diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
index ee84c1f..e355a43 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -26,13 +26,22 @@
 #endif

 #include "syshead.h"
+#include <stdbool.h>

 #include <setjmp.h>
 #include <cmocka.h>

 #include "buffer.h"
+#include "env_set.h"
 #include "buffer.c"

+/* mock this function as it is required by env.c */
+int
+script_security(void)
+{
+    return 0;
+}
+
 static void
 test_buffer_strprefix(void **state)
 {
@@ -353,6 +362,47 @@
     assert_string_equal(buf, "There is a .'nice.' \"1234\" [.] year old .t=
ree!");
 }

+static bool unit_test_free_called =3D false;
+
+static void
+unit_test_special_free(struct env_item *ei)
+{
+    assert_string_equal(ei->string, "unit=3Dtest");
+    unit_test_free_called =3D true;
+}
+
+static void
+test_env_special_free(void **state)
+{
+    /* Test called via env_set_destroy */
+    struct env_set *es =3D env_set_create(NULL);
+    env_set_add_specialfree(es, "unit=3Dtest", &unit_test_special_free);
+    env_set_destroy(es);
+    assert_true(unit_test_free_called);
+    unit_test_free_called =3D false;
+
+    /* Test called via env_remove */
+    es =3D env_set_create(NULL);
+    env_set_add_specialfree(es, "unit=3Dtest", &unit_test_special_free);
+    env_set_del(es, "unit");
+    assert_true(unit_test_free_called);
+    unit_test_free_called =3D false;
+    env_set_destroy(es);
+
+    /* Test for env with GC */
+    struct gc_arena gc =3D gc_new();
+    es =3D env_set_create(&gc);
+    env_set_add_specialfree(es, "unit=3Dtest", &unit_test_special_free);
+    env_set_destroy(es);
+
+    /* The free should be done as part of gc free and not as part of
+     * the env set destroy */
+    assert_false(unit_test_free_called);
+
+    gc_free(&gc);
+    assert_true(unit_test_free_called);
+}
+
 int
 main(void)
 {
@@ -385,6 +435,7 @@
         cmocka_unit_test(test_buffer_free_gc_two),
         cmocka_unit_test(test_buffer_gc_realloc),
         cmocka_unit_test(test_character_class),
+        cmocka_unit_test(test_env_special_free)
     };

     return cmocka_run_group_tests_name("buffer", tests, NULL, NULL);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/486?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6899c1af65fbd670d434cdb17f81c82b900bfbd4
Gerrit-Change-Number: 486
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--7OOPwMarMZM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/486?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Allow having an extra function that is called when an env is =
freed<br><br>Change-Id: I6899c1af65fbd670d434cdb17f81c82b900bfbd4<br>Signed=
-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M CMakeLists.txt<br=
>M src/openvpn/env_set.c<br>M src/openvpn/env_set.h<br>M tests/unit_tests/o=
penvpn/Makefile.am<br>M tests/unit_tests/openvpn/test_buffer.c<br>5 files c=
hanged, 106 insertions(+), 7 deletions(-)<br><br></pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/86/486/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLi=
sts.txt b/CMakeLists.txt</span><br><span>index 96328a1..04e9e34 100644</spa=
n><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span=
><br><span>@@ -685,6 +685,7 @@</span><br><span> </span><br><span>     targe=
t_sources(test_buffer PRIVATE</span><br><span>         tests/unit_tests/ope=
nvpn/mock_get_random.c</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        src/openvpn/env_set.c</span><br><span>         )</span><br><span=
> </span><br><span>     target_sources(test_crypto PRIVATE</span><br><span>=
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c</span><br><span>=
index 97b011f..fb7cd98 100644</span><br><span>--- a/src/openvpn/env_set.c</=
span><br><span>+++ b/src/openvpn/env_set.c</span><br><span>@@ -112,6 +112,1=
0 @@</span><br><span>             }</span><br><span>             if (do_fre=
e)</span><br><span>             {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                if (current-&gt;free_function)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    current-&gt;free=
_function(current);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                }</span><br><span>                 secure_memzero(current-&=
gt;string, strlen(current-&gt;string));</span><br><span>                 fr=
ee(current-&gt;string);</span><br><span>                 free(current);</sp=
an><br><span>@@ -124,15 +128,37 @@</span><br><span> }</span><br><span> </sp=
an><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-add_env_item(char *str, const bool do_alloc, struct env_item **list, st=
ruct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+e=
nv_gc_freefunction_wrapper(void *arg)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct env_item *ei =3D arg;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ei-&gt;free_function(ei);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    free(ei-&gt;string);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    free(ei);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+add_env_item(char *str,=
 void (*free_function)(struct env_item *),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+             struct env_item **list, struct gc_arena=
 *gc)</span><br><span> {</span><br><span>     struct env_item *item;</span>=
<br><span> </span><br><span>     ASSERT(str);</span><br><span>     ASSERT(l=
ist);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    ALLOC_OBJ_GC(item, struct env_item, gc);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    item-&gt;string =3D do_alloc ? string_alloc(st=
r, gc) : str;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (gc &amp;&amp; free_function)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* alloc items manually without gc to allow the gc_wrap_free</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * function to free t=
hem all in the right order */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        ALLOC_OBJ(item, struct env_item);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        item-&gt;string =3D string_alloc(=
str, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
gc_addspecial(item, env_gc_freefunction_wrapper, gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   ALLOC_OBJ_GC(item, struct env_item, gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        item-&gt;string =3D string_alloc(str, gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    item-&gt;free_function =3D fre=
e_function;</span><br><span>     item-&gt;next =3D *list;</span><br><span> =
    *list =3D item;</span><br><span> }</span><br><span>@@ -146,10 +172,11 @=
@</span><br><span> }</span><br><span> </span><br><span> static void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-env_set_add_nolock(struct env=
_set *es, const char *str)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+env_set_add_nolock(struct env_set *es, const char *str,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                   void (*free_f=
unction)(struct env_item *))</span><br><span> {</span><br><span>     remove=
_env_item(str, es-&gt;gc =3D=3D NULL, &amp;es-&gt;list);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    add_env_item((char *)str, true, &amp=
;es-&gt;list, es-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    add_env_item((char *)str, free_function, &amp;es-&gt;list, es-&gt=
;gc);</span><br><span> }</span><br><span> </span><br><span> struct env_set =
*</span><br><span>@@ -171,6 +198,10 @@</span><br><span>         while (e)</=
span><br><span>         {</span><br><span>             struct env_item *nex=
t =3D e-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (e-&gt;free_function)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                e-&gt;free_function(e);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            }</span><br><span>             fre=
e(e-&gt;string);</span><br><span>             free(e);</span><br><span>    =
         e =3D next;</span><br><span>@@ -194,7 +225,16 @@</span><br><span> =
{</span><br><span>     ASSERT(es);</span><br><span>     ASSERT(str);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    env_set_add_nolock(es, s=
tr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    env_set_add=
_nolock(es, str, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+env_set_add_specialfree(struct env_set *es, cons=
t char *str,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                 void (*free_function)(struct env_item *))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ASSERT(es);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ASSERT(str);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    env_set_add_nolock(es, str, free_function);</span><br><sp=
an> }</span><br><span> </span><br><span> const char *</span><br><span>@@ -2=
46,7 +286,7 @@</span><br><span>         e =3D src-&gt;list;</span><br><span=
>         while (e)</span><br><span>         {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            env_set_add_nolock(es, e-&gt;string);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            env_set_=
add_nolock(es, e-&gt;string, e-&gt;free_function);</span><br><span>        =
     e =3D e-&gt;next;</span><br><span>         }</span><br><span>     }</s=
pan><br><span>diff --git a/src/openvpn/env_set.h b/src/openvpn/env_set.h</s=
pan><br><span>index 4599977..27bc4dd 100644</span><br><span>--- a/src/openv=
pn/env_set.h</span><br><span>+++ b/src/openvpn/env_set.h</span><br><span>@@=
 -36,6 +36,7 @@</span><br><span> </span><br><span> struct env_item {</span>=
<br><span>     char *string;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    void (*free_function)(struct env_item *);</span><br><span>    =
 struct env_item *next;</span><br><span> };</span><br><span> </span><br><sp=
an>@@ -87,6 +88,11 @@</span><br><span> </span><br><span> void env_set_add(s=
truct env_set *es, const char *str);</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+env_set_add_specialfree(struct env_set *es, const char =
*str,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          void (*free_function)(struct env_item *));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> const char *env_set_get(const struct env_s=
et *es, const char *name);</span><br><span> </span><br><span> void env_set_=
print(int msglevel, const struct env_set *es);</span><br><span>diff --git a=
/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.a=
m</span><br><span>index 6667626..c5098a9 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/Makefile.am</span><br><span>+++ b/tests/unit_tests/open=
vpn/Makefile.am</span><br><span>@@ -52,6 +52,7 @@</span><br><span> buffer_t=
estdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=
=3Dparse_line</span><br><span> buffer_testdriver_SOURCES =3D test_buffer.c =
mock_msg.c mock_msg.h \</span><br><span> 	mock_get_random.c \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/env_se=
t.c \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util.c \</span><br>=
<span> 	$(top_srcdir)/src/openvpn/platform.c</span><br><span> </span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/=
openvpn/test_buffer.c</span><br><span>index ee84c1f..e355a43 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/test_buffer.c</span><br><span>+++ b=
/tests/unit_tests/openvpn/test_buffer.c</span><br><span>@@ -26,13 +26,22 @@=
</span><br><span> #endif</span><br><span> </span><br><span> #include &quot;=
syshead.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &lt;stdbool.h&gt;</span><br><span> </span><br><span> #include &lt;setj=
mp.h&gt;</span><br><span> #include &lt;cmocka.h&gt;</span><br><span> </span=
><br><span> #include &quot;buffer.h&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;env_set.h&quot;</span><br><span> #incl=
ude &quot;buffer.c&quot;</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* mock this function as it is required by env.c */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+script_security(void)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> static void</span><br><span> test_buffer_strprefix(void **=
state)</span><br><span> {</span><br><span>@@ -353,6 +362,47 @@</span><br><s=
pan>     assert_string_equal(buf, &quot;There is a .&#39;nice.&#39; \&quot;=
1234\&quot; [.] year old .tree!&quot;);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool unit_t=
est_free_called =3D false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+unit_test_special_fr=
ee(struct env_item *ei)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_str=
ing_equal(ei-&gt;string, &quot;unit=3Dtest&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    unit_test_free_called =3D true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_env_special_free(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* Test called via env_set_destroy */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct env_set *es =3D env_set_create(NULL);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    env_set_add_specialf=
ree(es, &quot;unit=3Dtest&quot;, &amp;unit_test_special_free);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    env_set_destroy(es);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(unit_test_f=
ree_called);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uni=
t_test_free_called =3D false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Te=
st called via env_remove */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    es =3D env_set_create(NULL);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    env_set_add_specialfree(es, &quot;unit=3Dtest&quot=
;, &amp;unit_test_special_free);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    env_set_del(es, &quot;unit&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(unit_test_free_called);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unit_test_free_ca=
lled =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
env_set_destroy(es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Test for en=
v with GC */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    es =3D env_set_create(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    env_set_add_specialfree(es, &quot;unit=3Dtest=
&quot;, &amp;unit_test_special_free);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    env_set_destroy(es);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* The free should be done as part of gc free and not as part of</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the env set des=
troy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_f=
alse(unit_test_free_called);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(unit_test_free_called);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> int</span><br><span> main(void)</span><br><span> {</span><br><s=
pan>@@ -385,6 +435,7 @@</span><br><span>         cmocka_unit_test(test_buff=
er_free_gc_two),</span><br><span>         cmocka_unit_test(test_buffer_gc_r=
ealloc),</span><br><span>         cmocka_unit_test(test_character_class),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_t=
est(test_env_special_free)</span><br><span>     };</span><br><span> </span>=
<br><span>     return cmocka_run_group_tests_name(&quot;buffer&quot;, tests=
, NULL, NULL);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/486?usp=3Demail">change 486</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/486?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6899c1af65fbd670d434cdb17f8=
1c82b900bfbd4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 486 </div>
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


--7OOPwMarMZM=--

