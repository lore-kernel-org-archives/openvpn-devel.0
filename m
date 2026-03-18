From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 18 Mar 2026 13:54:02 +0000
References: <gerrit.1773842036000.I4920318ac537064508eee3ca449d48de76c2ea5d@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9b5e5f08f7194c9415fe70b1b5dc99d721dafcdc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1epBJp/6XOM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix compilation with
 --with-mem-check=dmalloc
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

--1epBJp/6XOM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1582?usp=3Demail

to review the following change.


Change subject: Fix compilation with --with-mem-check=3Ddmalloc
......................................................................

Fix compilation with --with-mem-check=3Ddmalloc

Only tested compilation and make check. Did not
actually verify dmalloc functionality.

Change-Id: I4920318ac537064508eee3ca449d48de76c2ea5d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/buffer.c
M src/openvpn/buffer.h
M src/openvpn/crypto_openssl.c
3 files changed, 21 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/1582/1

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 75110ed..e335eb0 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -440,7 +440,11 @@
 }

 void
+#ifdef DMALLOC
+gc_addspecial_debug(void *addr, void (*free_function)(void *), struct gc_a=
rena *a, const char *file, int line)
+#else
 gc_addspecial(void *addr, void (*free_function)(void *), struct gc_arena *=
a)
+#endif
 {
     ASSERT(a);
     struct gc_entry_special *e;
@@ -1157,7 +1161,7 @@
     if (buf && buf->len)
     {
         msglvl_t msglevel =3D D_ALIGN_DEBUG;
-        const unsigned int u =3D (unsigned int)BPTR(buf);
+        const uintptr_t u =3D (uintptr_t)BPTR(buf);

         if (u & (PAYLOAD_ALIGN - 1))
         {
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 87d7d80..fbabfb3 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -243,12 +243,13 @@

 #ifdef DMALLOC

-#define alloc_buf(size)               alloc_buf_debug(size, __FILE__, __LI=
NE__)
-#define alloc_buf_gc(size, gc)        alloc_buf_gc_debug(size, gc, __FILE_=
_, __LINE__);
-#define clone_buf(buf)                clone_buf_debug(buf, __FILE__, __LIN=
E__);
-#define gc_malloc(size, clear, arena) gc_malloc_debug(size, clear, arena, =
__FILE__, __LINE__)
-#define string_alloc(str, gc)         string_alloc_debug(str, gc, __FILE__=
, __LINE__)
-#define string_alloc_buf(str, gc)     string_alloc_buf_debug(str, gc, __FI=
LE__, __LINE__)
+#define alloc_buf(size)                  alloc_buf_debug(size, __FILE__, _=
_LINE__)
+#define alloc_buf_gc(size, gc)           alloc_buf_gc_debug(size, gc, __FI=
LE__, __LINE__);
+#define clone_buf(buf)                   clone_buf_debug(buf, __FILE__, __=
LINE__);
+#define gc_malloc(size, clear, arena)    gc_malloc_debug(size, clear, aren=
a, __FILE__, __LINE__)
+#define gc_addspecial(addr, func, arena) gc_addspecial_debug(addr, func, a=
rena, __FILE__, __LINE__)
+#define string_alloc(str, gc)            string_alloc_debug(str, gc, __FIL=
E__, __LINE__)
+#define string_alloc_buf(str, gc)        string_alloc_buf_debug(str, gc, _=
_FILE__, __LINE__)

 /** Debug variant of \c alloc_buf() that records the allocation site. */
 struct buffer alloc_buf_debug(size_t size, const char *file, int line);
@@ -262,6 +263,9 @@
 /** Debug variant of \c gc_malloc() that records the allocation site. */
 void *gc_malloc_debug(size_t size, bool clear, struct gc_arena *a, const c=
har *file, int line);

+/** Debug variant of \c gc_addspecial() that records the allocation site. =
*/
+void gc_addspecial_debug(void *addr, void (*free_function)(void *), struct=
 gc_arena *a, const char *file, int line);
+
 /** Debug variant of \c string_alloc() that records the allocation site. */
 char *string_alloc_debug(const char *str, struct gc_arena *gc, const char =
*file, int line);

@@ -351,8 +355,6 @@
  */
 struct buffer string_alloc_buf(const char *str, struct gc_arena *gc);

-#endif /* ifdef DMALLOC */
-
 /**
  * Register an address with a custom free function in a garbage collection
  * arena.
@@ -367,6 +369,8 @@
  */
 void gc_addspecial(void *addr, void (*free_function)(void *), struct gc_ar=
ena *a);

+#endif /* ifdef DMALLOC */
+
 /**
  * allows to realloc a pointer previously allocated by gc_malloc or gc_rea=
lloc
  *
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 19cb9a9..b526b0b 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -39,6 +39,7 @@
 #include "integer.h"
 #include "crypto.h"
 #include "crypto_backend.h"
+#include "memdbg.h"
 #include "openssl_compat.h"

 #include <openssl/conf.h>
@@ -295,15 +296,15 @@
 }

 static void
-crypto_free(void *ptr)
+crypto_free(void *ptr, const char *file, int line)
 {
-    dmalloc_free(__FILE__, __LINE__, ptr, DMALLOC_FUNC_FREE);
+    dmalloc_free(file, line, ptr, DMALLOC_FUNC_FREE);
 }

 void
 crypto_init_dmalloc(void)
 {
-    CRYPTO_set_mem_ex_functions(crypto_malloc, crypto_realloc, crypto_free=
);
+    CRYPTO_set_mem_functions(crypto_malloc, crypto_realloc, crypto_free);
 }
 #endif /* DMALLOC */


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1582?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4920318ac537064508eee3ca449d48de76c2ea5d
Gerrit-Change-Number: 1582
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--1epBJp/6XOM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1582?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Fix compilation with --with-mem-check=3Ddma=
lloc<br><br>Only tested compilation and make check. Did not<br>actually ver=
ify dmalloc functionality.<br><br>Change-Id: I4920318ac537064508eee3ca449d4=
8de76c2ea5d<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br=
>---<br>M src/openvpn/buffer.c<br>M src/openvpn/buffer.h<br>M src/openvpn/c=
rypto_openssl.c<br>3 files changed, 21 insertions(+), 12 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/82/1582/1</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer.c b/src/openvpn/b=
uffer.c</span><br><span>index 75110ed..e335eb0 100644</span><br><span>--- a=
/src/openvpn/buffer.c</span><br><span>+++ b/src/openvpn/buffer.c</span><br>=
<span>@@ -440,7 +440,11 @@</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef DM=
ALLOC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+gc_addspecial_=
debug(void *addr, void (*free_function)(void *), struct gc_arena *a, const =
char *file, int line)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#else</span><br><span> gc_addspecial(void *addr, void (*free_function)(vo=
id *), struct gc_arena *a)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span> {</span><br><span>     ASSERT(a);</span><br>=
<span>     struct gc_entry_special *e;</span><br><span>@@ -1157,7 +1161,7 @=
@</span><br><span>     if (buf &amp;&amp; buf-&gt;len)</span><br><span>    =
 {</span><br><span>         msglvl_t msglevel =3D D_ALIGN_DEBUG;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        const unsigned int u =3D=
 (unsigned int)BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        const uintptr_t u =3D (uintptr_t)BPTR(buf);</span><br><span> =
</span><br><span>         if (u &amp; (PAYLOAD_ALIGN - 1))</span><br><span>=
         {</span><br><span>diff --git a/src/openvpn/buffer.h b/src/openvpn/=
buffer.h</span><br><span>index 87d7d80..fbabfb3 100644</span><br><span>--- =
a/src/openvpn/buffer.h</span><br><span>+++ b/src/openvpn/buffer.h</span><br=
><span>@@ -243,12 +243,13 @@</span><br><span> </span><br><span> #ifdef DMAL=
LOC</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define alloc_buf(size)               alloc_buf_debug(size, __FILE__, __LIN=
E__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define alloc_buf=
_gc(size, gc)        alloc_buf_gc_debug(size, gc, __FILE__, __LINE__);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define clone_buf(buf)    =
            clone_buf_debug(buf, __FILE__, __LINE__);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define gc_malloc(size, clear, arena) gc_ma=
lloc_debug(size, clear, arena, __FILE__, __LINE__)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define string_alloc(str, gc)         string_a=
lloc_debug(str, gc, __FILE__, __LINE__)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define string_alloc_buf(str, gc)     string_alloc_buf_de=
bug(str, gc, __FILE__, __LINE__)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define alloc_buf(size)                  alloc_buf_debug(size,=
 __FILE__, __LINE__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define alloc_buf_gc(size, gc)           alloc_buf_gc_debug(size, gc, __FI=
LE__, __LINE__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine clone_buf(buf)                   clone_buf_debug(buf, __FILE__, __LINE=
__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define gc_mall=
oc(size, clear, arena)    gc_malloc_debug(size, clear, arena, __FILE__, __L=
INE__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define gc_ad=
dspecial(addr, func, arena) gc_addspecial_debug(addr, func, arena, __FILE__=
, __LINE__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
string_alloc(str, gc)            string_alloc_debug(str, gc, __FILE__, __LI=
NE__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define string=
_alloc_buf(str, gc)        string_alloc_buf_debug(str, gc, __FILE__, __LINE=
__)</span><br><span> </span><br><span> /** Debug variant of \c alloc_buf() =
that records the allocation site. */</span><br><span> struct buffer alloc_b=
uf_debug(size_t size, const char *file, int line);</span><br><span>@@ -262,=
6 +263,9 @@</span><br><span> /** Debug variant of \c gc_malloc() that recor=
ds the allocation site. */</span><br><span> void *gc_malloc_debug(size_t si=
ze, bool clear, struct gc_arena *a, const char *file, int line);</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Debug va=
riant of \c gc_addspecial() that records the allocation site. */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void gc_addspecial_debug(void =
*addr, void (*free_function)(void *), struct gc_arena *a, const char *file,=
 int line);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> /** Debug variant of \c string_alloc() that records the allocatio=
n site. */</span><br><span> char *string_alloc_debug(const char *str, struc=
t gc_arena *gc, const char *file, int line);</span><br><span> </span><br><s=
pan>@@ -351,8 +355,6 @@</span><br><span>  */</span><br><span> struct buffer=
 string_alloc_buf(const char *str, struct gc_arena *gc);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef DMALLO=
C */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 /**</span><br><span>  * Register an address with a custom free function in=
 a garbage collection</span><br><span>  * arena.</span><br><span>@@ -367,6 =
+369,8 @@</span><br><span>  */</span><br><span> void gc_addspecial(void *ad=
dr, void (*free_function)(void *), struct gc_arena *a);</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef DMALL=
OC */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> /**</span><br><span>  * allows to realloc a pointer previously allocate=
d by gc_malloc or gc_realloc</span><br><span>  *</span><br><span>diff --git=
 a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c</span><br><s=
pan>index 19cb9a9..b526b0b 100644</span><br><span>--- a/src/openvpn/crypto_=
openssl.c</span><br><span>+++ b/src/openvpn/crypto_openssl.c</span><br><spa=
n>@@ -39,6 +39,7 @@</span><br><span> #include &quot;integer.h&quot;</span><=
br><span> #include &quot;crypto.h&quot;</span><br><span> #include &quot;cry=
pto_backend.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;memdbg.h&quot;</span><br><span> #include &quot;openssl_compa=
t.h&quot;</span><br><span> </span><br><span> #include &lt;openssl/conf.h&gt=
;</span><br><span>@@ -295,15 +296,15 @@</span><br><span> }</span><br><span>=
 </span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-crypto_free(void *ptr)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+crypto_free(void *ptr, const char *file, int line)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmalloc_fre=
e(__FILE__, __LINE__, ptr, DMALLOC_FUNC_FREE);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    dmalloc_free(file, line, ptr, DMALLOC_FUNC_F=
REE);</span><br><span> }</span><br><span> </span><br><span> void</span><br>=
<span> crypto_init_dmalloc(void)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    CRYPTO_set_mem_ex_functions(crypto_mall=
oc, crypto_realloc, crypto_free);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    CRYPTO_set_mem_functions(crypto_malloc, crypto_realloc, c=
rypto_free);</span><br><span> }</span><br><span> #endif /* DMALLOC */</span=
><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1582?usp=3Demail">change 1582</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemt=
ype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" i=
temtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1582?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4920318ac537064508eee3ca449=
d48de76c2ea5d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1582 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--1epBJp/6XOM=--

