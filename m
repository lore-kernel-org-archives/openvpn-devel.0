From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 4 Mar 2026 16:48:22 +0000
In-Reply-To: <gerrit.1769512571000.Ida8e587a095bdfb821ee0a4783633f026d310476@...2715...>
References: <gerrit.1769512571000.Ida8e587a095bdfb821ee0a4783633f026d310476@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ca3ba14e609f6f90d1d1b174ecf72acd3c4d8cc4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YMEHkD3I+H4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: argv: Fix one type
 to avoid sign-compare warning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YMEHkD3I+H4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
94?usp=3Demail )

Change subject: argv: Fix one type to avoid sign-compare warning
......................................................................

argv: Fix one type to avoid sign-compare warning

len is already int, no need to throw another
type into the mix.

Change-Id: Ida8e587a095bdfb821ee0a4783633f026d310476
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1494
Message-Id: <20260304144059.2518-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
891.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/argv.c
1 file changed, 1 insertion(+), 10 deletions(-)




diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index b5d9603..6a5d92e 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -263,11 +263,6 @@
     gc_free(&gc);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /**
  *  Prepares argv format string for further processing
  *
@@ -389,7 +384,7 @@
      *  Do the actual vsnprintf() operation, which expands the format
      *  string with the provided arguments.
      */
-    size_t size =3D len + 1;
+    int size =3D len + 1;
     char *buf =3D gc_malloc(size, false, &argres->gc);
     len =3D vsnprintf(buf, size, f, arglist);
     if (len < 0 || len >=3D size)
@@ -423,10 +418,6 @@
     return res;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  *  printf() variant which populates a struct argv.  It processes the
  *  format string with the provided arguments.  For each space separator f=
ound

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1494?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ida8e587a095bdfb821ee0a4783633f026d310476
Gerrit-Change-Number: 1494
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YMEHkD3I+H4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1494?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">argv: Fix one type to avoid sign-compare warning=
<br><br>len is already int, no need to throw another<br>type into the mix.<=
br><br>Change-Id: Ida8e587a095bdfb821ee0a4783633f026d310476<br>Signed-off-b=
y: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt=
;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/op=
envpn/+/1494<br>Message-Id: &lt;20260304144059.2518-1-gert@...1296...&gt;<b=
r>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg=
35891.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br=
>M src/openvpn/argv.c<br>1 file changed, 1 insertion(+), 10 deletions(-)<br=
><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c</span><br><span>ind=
ex b5d9603..6a5d92e 100644</span><br><span>--- a/src/openvpn/argv.c</span><=
br><span>+++ b/src/openvpn/argv.c</span><br><span>@@ -263,11 +263,6 @@</spa=
n><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  *  Prepares=
 argv format string for further processing</span><br><span>  *</span><br><s=
pan>@@ -389,7 +384,7 @@</span><br><span>      *  Do the actual vsnprintf() =
operation, which expands the format</span><br><span>      *  string with th=
e provided arguments.</span><br><span>      */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    size_t size =3D len + 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int size =3D len + 1;</span><br><span=
>     char *buf =3D gc_malloc(size, false, &amp;argres-&gt;gc);</span><br><=
span>     len =3D vsnprintf(buf, size, f, arglist);</span><br><span>     if=
 (len &lt; 0 || len &gt;=3D size)</span><br><span>@@ -423,10 +418,6 @@</spa=
n><br><span>     return res;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /=
**</span><br><span>  *  printf() variant which populates a struct argv.  It=
 processes the</span><br><span>  *  format string with the provided argumen=
ts.  For each space separator found</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1494?usp=3Dema=
il">change 1494</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1494?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ida8e587a095bdfb821ee0a47836=
33f026d310476 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1494 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--YMEHkD3I+H4=--

