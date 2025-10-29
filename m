From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 29 Oct 2025 13:07:29 +0000
References: <gerrit.1761703996000.Iacec5920cdc3e16aaf777f843ef1f4a00a6a9043@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8b07e1b908c3ea6c6bed474a706828dd9a9af881-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lpH9ttQ+/YY="; charset=UTF-8
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

--lpH9ttQ+/YY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1324?usp=3Demail

to review the following change.


Change subject: mudp/mtcp: Remove -Wconversion pragmas
......................................................................

mudp/mtcp: Remove -Wconversion pragmas

Change-Id: Iacec5920cdc3e16aaf777f843ef1f4a00a6a9043
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/mtcp.c
M src/openvpn/mudp.c
2 files changed, 0 insertions(+), 18 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/1324/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iacec5920cdc3e16aaf777f843ef1f4a00a6a9043
Gerrit-Change-Number: 1324
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--lpH9ttQ+/YY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1324?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">mudp/mtcp: Remove -Wconversion pragmas<br><=
br>Change-Id: Iacec5920cdc3e16aaf777f843ef1f4a00a6a9043<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/mtcp.c<br=
>M src/openvpn/mudp.c<br>2 files changed, 0 insertions(+), 18 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/24/1324/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/mtcp.c b/src/openvp=
n/mtcp.c</span><br><span>index 83edec6..81310a2 100644</span><br><span>--- =
a/src/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><sp=
an>@@ -45,11 +45,6 @@</span><br><span>     unsigned int sock;</span><br><sp=
an> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconv=
ersion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struct=
 multi_instance *</span><br><span> multi_create_instance_tcp(struct multi_c=
ontext *m, struct link_socket *sock)</span><br><span> {</span><br><span>@@ =
-125,10 +120,6 @@</span><br><span>     return true;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> void</span><br><span> multi_tcp_instance_specific_fre=
e(struct multi_instance *mi)</span><br><span> {</span><br><span>diff --git =
a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index a373a6a..31=
134be 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b=
/src/openvpn/mudp.c</span><br><span>@@ -180,11 +180,6 @@</span><br><span>  =
   return false;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> /*</span><br><span>  * Get a client instance based on=
 real address.  If</span><br><span>  * the instance doesn&#39;t exist, crea=
te it while</span><br><span>@@ -315,10 +310,6 @@</span><br><span>     retur=
n mi;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * S=
end a packet to UDP socket.</span><br><span>  */</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
324?usp=3Demail">change 1324</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1324=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iacec5920cdc3e16aaf777f843ef=
1f4a00a6a9043 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1324 </div>
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

--lpH9ttQ+/YY=--

