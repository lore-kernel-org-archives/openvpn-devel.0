From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 12 Dec 2025 12:06:31 +0000
In-Reply-To: <gerrit.1765467748000.I4f95edd7ce2098180aa620a231727217f333a12d@...2715...>
References: <gerrit.1765467748000.I4f95edd7ce2098180aa620a231727217f333a12d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8ebe554906d200be81ffd7afbc4eba1fd8ab1fed-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Mt/C0OZaENg="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Mt/C0OZaENg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1436?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1436
Message-Id: <20251212100920.7671-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
044.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/buffer.c
M src/openvpn/buffer.h
2 files changed, 13 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/1436/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4f95edd7ce2098180aa620a231727217f333a12d
Gerrit-Change-Number: 1436
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Mt/C0OZaENg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1436?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">buffer: Change limits for array_mul=
t_safe<br><br>- Lower the limit to 1GB on 32bit systems.<br>  The limit of =
4GB-1 makes no sense on systems that usually<br>  don&#39;t allow a single =
process to allocate anything near to<br>  this limit.<br>- Increate the lim=
it from 4GB-1 to 4GB on other systems. It<br>  makes no difference in prote=
ction but makes it much easier<br>  to use the limit in other contexts, e.g=
. if dividing it.<br><br>Change-Id: I4f95edd7ce2098180aa620a231727217f333a1=
2d<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by=
: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvp=
n.net/c/openvpn/+/1436<br>Message-Id: &lt;20251212100920.7671-1-gert@...1826...=
6...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1768...=
ge.net/msg35044.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;=
<br>---<br>M src/openvpn/buffer.c<br>M src/openvpn/buffer.h<br>2 files chan=
ged, 13 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/36/1436/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span>index 293=
622f..40baca6 100644</span><br><span>--- a/src/openvpn/buffer.c</span><br><=
span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -39,7 +39,7 @@</span><br=
><span> size_t</span><br><span> array_mult_safe(const size_t m1, const size=
_t m2, const size_t extra)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    const size_t limit =3D 0xFFFFFFFF;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const size_t limit =3D ALLOC=
_SIZE_MAX;</span><br><span>     unsigned long long res =3D</span><br><span>=
         (unsigned long long)m1 * (unsigned long long)m2 + (unsigned long l=
ong)extra;</span><br><span>     if (unlikely(m1 &gt; limit) || unlikely(m2 =
&gt; limit) || unlikely(extra &gt; limit)</span><br><span>diff --git a/src/=
openvpn/buffer.h b/src/openvpn/buffer.h</span><br><span>index ab2a29d..1dbe=
0b2 100644</span><br><span>--- a/src/openvpn/buffer.h</span><br><span>+++ b=
/src/openvpn/buffer.h</span><br><span>@@ -1044,6 +1044,18 @@</span><br><spa=
n>  * Allocate memory to hold a structure</span><br><span>  */</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* When alloca=
ting arrays make sure we do not use a excessive amount</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * of memory.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if UINTPTR_MAX &lt;=3D UINT32_MAX</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* 1 GB on 32bit systems, they usually can only=
 allocate 2 GB for the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * whole process.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ALLOC_S=
IZE_MAX (1u &lt;&lt; 30)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define A=
LLOC_SIZE_MAX ((size_t)1 &lt;&lt; 32) /* 4 GB */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> #define ALLOC_OBJ(dptr, type)            =
                           \</span><br><span>     {                        =
                                       \</span><br><span>         check_mal=
loc_return((dptr) =3D (type *)malloc(sizeof(type))); \</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1436?usp=3Demail">change 1436</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dem=
ail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1436?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4f95edd7ce2098180aa620a2317=
27217f333a12d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1436 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Mt/C0OZaENg=--

