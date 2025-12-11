From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 11 Dec 2025 15:42:34 +0000
References: <gerrit.1765467748000.I4f95edd7ce2098180aa620a231727217f333a12d@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <87a00f240bdaf1f724d95f891bebccb31a994dbe-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1GZ34wz+J/8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Change
 limits for array_mult_safe
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

--1GZ34wz+J/8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1436?usp=3Demail

to review the following change.


Change subject: buffer: Change limits for array_mult_safe
......................................................................

buffer: Change limits for array_mult_safe

- Lower the limit to 1GB on 32bit systems.
  The limit of 4GB-1 makes no sense on systems that usually
  don't allow a single process to allocate anything near to
  this limit.
- Increate the limit from 4GB-1 to 4GB on other systems. It
  makes no difference in protection but makes it much easier
  to use the limit in other contexts, e.g. if dividing it.

Change-Id: I4f95edd7ce2098180aa620a231727217f333a12d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/buffer.c
M src/openvpn/buffer.h
2 files changed, 13 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/1436/1

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 293622f..40baca6 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -39,7 +39,7 @@
 size_t
 array_mult_safe(const size_t m1, const size_t m2, const size_t extra)
 {
-    const size_t limit =3D 0xFFFFFFFF;
+    const size_t limit =3D ALLOC_SIZE_MAX;
     unsigned long long res =3D
         (unsigned long long)m1 * (unsigned long long)m2 + (unsigned long l=
ong)extra;
     if (unlikely(m1 > limit) || unlikely(m2 > limit) || unlikely(extra > l=
imit)
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index ab2a29d..1dbe0b2 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1044,6 +1044,18 @@
  * Allocate memory to hold a structure
  */

+/* When allocating arrays make sure we do not use a excessive amount
+ * of memory.
+ */
+#if UINTPTR_MAX <=3D UINT32_MAX
+/* 1 GB on 32bit systems, they usually can only allocate 2 GB for the
+ * whole process.
+ */
+#define ALLOC_SIZE_MAX (1u << 30)
+#else
+#define ALLOC_SIZE_MAX ((size_t)1 << 32) /* 4 GB */
+#endif
+
 #define ALLOC_OBJ(dptr, type)                                       \
     {                                                               \
         check_malloc_return((dptr) =3D (type *)malloc(sizeof(type))); \

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1436?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4f95edd7ce2098180aa620a231727217f333a12d
Gerrit-Change-Number: 1436
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--1GZ34wz+J/8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1436?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">buffer: Change limits for array_mult_safe<b=
r><br>- Lower the limit to 1GB on 32bit systems.<br>  The limit of 4GB-1 ma=
kes no sense on systems that usually<br>  don&#39;t allow a single process =
to allocate anything near to<br>  this limit.<br>- Increate the limit from =
4GB-1 to 4GB on other systems. It<br>  makes no difference in protection bu=
t makes it much easier<br>  to use the limit in other contexts, e.g. if div=
iding it.<br><br>Change-Id: I4f95edd7ce2098180aa620a231727217f333a12d<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/ope=
nvpn/buffer.c<br>M src/openvpn/buffer.h<br>2 files changed, 13 insertions(+=
), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/36/1436/1</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/bu=
ffer.c b/src/openvpn/buffer.c</span><br><span>index 293622f..40baca6 100644=
</span><br><span>--- a/src/openvpn/buffer.c</span><br><span>+++ b/src/openv=
pn/buffer.c</span><br><span>@@ -39,7 +39,7 @@</span><br><span> size_t</span=
><br><span> array_mult_safe(const size_t m1, const size_t m2, const size_t =
extra)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    const size_t limit =3D 0xFFFFFFFF;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const size_t limit =3D ALLOC_SIZE_MAX;</span><br=
><span>     unsigned long long res =3D</span><br><span>         (unsigned l=
ong long)m1 * (unsigned long long)m2 + (unsigned long long)extra;</span><br=
><span>     if (unlikely(m1 &gt; limit) || unlikely(m2 &gt; limit) || unlik=
ely(extra &gt; limit)</span><br><span>diff --git a/src/openvpn/buffer.h b/s=
rc/openvpn/buffer.h</span><br><span>index ab2a29d..1dbe0b2 100644</span><br=
><span>--- a/src/openvpn/buffer.h</span><br><span>+++ b/src/openvpn/buffer.=
h</span><br><span>@@ -1044,6 +1044,18 @@</span><br><span>  * Allocate memor=
y to hold a structure</span><br><span>  */</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* When allocating arrays make sur=
e we do not use a excessive amount</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * of memory.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if UIN=
TPTR_MAX &lt;=3D UINT32_MAX</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* 1 GB on 32bit systems, they usually can only allocate 2 GB for t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * whole process.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define ALLOC_SIZE_MAX (1u &lt;&lt;=
 30)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define ALLOC_SIZE_MAX ((size=
_t)1 &lt;&lt; 32) /* 4 GB */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> #define ALLOC_OBJ(dptr, type)                                =
       \</span><br><span>     {                                            =
                   \</span><br><span>         check_malloc_return((dptr) =
=3D (type *)malloc(sizeof(type))); \</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1436?usp=3Dem=
ail">change 1436</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1436?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4f95edd7ce2098180aa620a2317=
27217f333a12d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1436 </div>
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

--1GZ34wz+J/8=--

