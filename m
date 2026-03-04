From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 4 Mar 2026 16:48:20 +0000
In-Reply-To: <gerrit.1769512571000.Ida8e587a095bdfb821ee0a4783633f026d310476@...2715...>
References: <gerrit.1769512571000.Ida8e587a095bdfb821ee0a4783633f026d310476@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ca3ba14e609f6f90d1d1b174ecf72acd3c4d8cc4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RErmuY1KJmw="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RErmuY1KJmw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1494?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/1494/6

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ida8e587a095bdfb821ee0a4783633f026d310476
Gerrit-Change-Number: 1494
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RErmuY1KJmw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1494?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">argv: Fix one type to avoid sig=
n-compare warning<br><br>len is already int, no need to throw another<br>ty=
pe into the mix.<br><br>Change-Id: Ida8e587a095bdfb821ee0a4783633f026d31047=
6<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by:=
 Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit=
.openvpn.net/c/openvpn/+/1494<br>Message-Id: &lt;20260304144059.2518-1-gert=
@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1466...=
urceforge.net/msg35891.html<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>---<br>M src/openvpn/argv.c<br>1 file changed, 1 insertion(+), 1=
0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/94/1494/6</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/argv=
.c b/src/openvpn/argv.c</span><br><span>index b5d9603..6a5d92e 100644</span=
><br><span>--- a/src/openvpn/argv.c</span><br><span>+++ b/src/openvpn/argv.=
c</span><br><span>@@ -263,11 +263,6 @@</span><br><span>     gc_free(&amp;gc=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignore=
d &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> /**</span><br><span>  *  Prepares argv format string for further =
processing</span><br><span>  *</span><br><span>@@ -389,7 +384,7 @@</span><b=
r><span>      *  Do the actual vsnprintf() operation, which expands the for=
mat</span><br><span>      *  string with the provided arguments.</span><br>=
<span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    siz=
e_t size =3D len + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int size =3D len + 1;</span><br><span>     char *buf =3D gc_malloc(si=
ze, false, &amp;argres-&gt;gc);</span><br><span>     len =3D vsnprintf(buf,=
 size, f, arglist);</span><br><span>     if (len &lt; 0 || len &gt;=3D size=
)</span><br><span>@@ -423,10 +418,6 @@</span><br><span>     return res;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  *  printf()=
 variant which populates a struct argv.  It processes the</span><br><span> =
 *  format string with the provided arguments.  For each space separator fo=
und</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1494?usp=3Demail">change 1494</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1494?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--RErmuY1KJmw=--

