From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 27 Jan 2026 11:16:20 +0000
References: <gerrit.1769512571000.Ida8e587a095bdfb821ee0a4783633f026d310476@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <bdd4764186c80c6764625ca9b66c94d8898a3702-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cFso5jvXvgM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cFso5jvXvgM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1494?usp=3Demail

to review the following change.


Change subject: argv: Fix one type to avoid sign-compare warning
......................................................................

argv: Fix one type to avoid sign-compare warning

len is already int, no need to throw another
type into the mix.

Change-Id: Ida8e587a095bdfb821ee0a4783633f026d310476
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/argv.c
1 file changed, 1 insertion(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/1494/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ida8e587a095bdfb821ee0a4783633f026d310476
Gerrit-Change-Number: 1494
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--cFso5jvXvgM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1494?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">argv: Fix one type to avoid sign-compare wa=
rning<br><br>len is already int, no need to throw another<br>type into the =
mix.<br><br>Change-Id: Ida8e587a095bdfb821ee0a4783633f026d310476<br>Signed-=
off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/=
argv.c<br>1 file changed, 1 insertion(+), 10 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/1=
494/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c</span><b=
r><span>index b5d9603..6a5d92e 100644</span><br><span>--- a/src/openvpn/arg=
v.c</span><br><span>+++ b/src/openvpn/argv.c</span><br><span>@@ -263,11 +26=
3,6 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__=
GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  =
*  Prepares argv format string for further processing</span><br><span>  *</=
span><br><span>@@ -389,7 +384,7 @@</span><br><span>      *  Do the actual v=
snprintf() operation, which expands the format</span><br><span>      *  str=
ing with the provided arguments.</span><br><span>      */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    size_t size =3D len + 1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int size =3D len + 1;</spa=
n><br><span>     char *buf =3D gc_malloc(size, false, &amp;argres-&gt;gc);<=
/span><br><span>     len =3D vsnprintf(buf, size, f, arglist);</span><br><s=
pan>     if (len &lt; 0 || len &gt;=3D size)</span><br><span>@@ -423,10 +41=
8,6 @@</span><br><span>     return res;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> /**</span><br><span>  *  printf() variant which populates a struc=
t argv.  It processes the</span><br><span>  *  format string with the provi=
ded arguments.  For each space separator found</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/149=
4?usp=3Demail">change 1494</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1494?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ida8e587a095bdfb821ee0a47836=
33f026d310476 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1494 </div>
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

--cFso5jvXvgM=--

