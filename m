From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 29 Oct 2025 13:13:15 +0000
In-Reply-To: <gerrit.1761703996000.Iacec5920cdc3e16aaf777f843ef1f4a00a6a9043@...2715...>
References: <gerrit.1761703996000.Iacec5920cdc3e16aaf777f843ef1f4a00a6a9043@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8778796a176cefa640c9abb0ea227f0e01f00345-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oYiGqamqyZI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mudp/mtcp: Remove
 -Wconversion pragmas
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

--oYiGqamqyZI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1324?usp=3Demail

to look at the new patch set (#2).


Change subject: mudp/mtcp: Remove -Wconversion pragmas
......................................................................

mudp/mtcp: Remove -Wconversion pragmas

These were implictly fixed by the fixes to
the hash API in commit
a69aac41c4b2ccff1084736c158d7cf8474be533.
("list: Make types of hash elements consistent")

Change-Id: Iacec5920cdc3e16aaf777f843ef1f4a00a6a9043
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/mtcp.c
M src/openvpn/mudp.c
2 files changed, 0 insertions(+), 18 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/1324/2

diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 83edec6..81310a2 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -45,11 +45,6 @@
     unsigned int sock;
 };

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 struct multi_instance *
 multi_create_instance_tcp(struct multi_context *m, struct link_socket *soc=
k)
 {
@@ -125,10 +120,6 @@
     return true;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 multi_tcp_instance_specific_free(struct multi_instance *mi)
 {
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index a373a6a..31134be 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -180,11 +180,6 @@
     return false;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * Get a client instance based on real address.  If
  * the instance doesn't exist, create it while
@@ -315,10 +310,6 @@
     return mi;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Send a packet to UDP socket.
  */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1324?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iacec5920cdc3e16aaf777f843ef1f4a00a6a9043
Gerrit-Change-Number: 1324
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--oYiGqamqyZI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1324?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">mudp/mtcp: Remove -Wconversion pragmas<br><br>Th=
ese were implictly fixed by the fixes to<br>the hash API in commit<br>a69aa=
c41c4b2ccff1084736c158d7cf8474be533.<br>(&quot;list: Make types of hash ele=
ments consistent&quot;)<br><br>Change-Id: Iacec5920cdc3e16aaf777f843ef1f4a0=
0a6a9043<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>--=
-<br>M src/openvpn/mtcp.c<br>M src/openvpn/mudp.c<br>2 files changed, 0 ins=
ertions(+), 18 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/24/1324/2</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>index 83edec6..81310a2=
 100644</span><br><span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src/=
openvpn/mtcp.c</span><br><span>@@ -45,11 +45,6 @@</span><br><span>     unsi=
gned int sock;</span><br><span> };</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> struct multi_instance *</span><br><span> multi_create=
_instance_tcp(struct multi_context *m, struct link_socket *sock)</span><br>=
<span> {</span><br><span>@@ -125,10 +120,6 @@</span><br><span>     return t=
rue;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> mul=
ti_tcp_instance_specific_free(struct multi_instance *mi)</span><br><span> {=
</span><br><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span=
><br><span>index a373a6a..31134be 100644</span><br><span>--- a/src/openvpn/=
mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -180,11 =
+180,6 @@</span><br><span>     return false;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__G=
NUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Ge=
t a client instance based on real address.  If</span><br><span>  * the inst=
ance doesn&#39;t exist, create it while</span><br><span>@@ -315,10 +310,6 @=
@</span><br><span>     return mi;</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pra=
gma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an> /*</span><br><span>  * Send a packet to UDP socket.</span><br><span>  *=
/</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1324?usp=3Demail">change 1324</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1324?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iacec5920cdc3e16aaf777f843ef=
1f4a00a6a9043 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1324 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--oYiGqamqyZI=--

