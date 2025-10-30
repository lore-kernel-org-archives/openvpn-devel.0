From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 16:43:31 +0000
In-Reply-To: <gerrit.1761703996000.Iacec5920cdc3e16aaf777f843ef1f4a00a6a9043@...2715...>
References: <gerrit.1761703996000.Iacec5920cdc3e16aaf777f843ef1f4a00a6a9043@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2470e1477c49c55bb780c138293bdfaab56d38a9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8uGjdof3B6o="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8uGjdof3B6o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1324?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: mudp/mtcp: Remove -Wconversion pragmas
......................................................................

mudp/mtcp: Remove -Wconversion pragmas

These were implictly fixed by the fixes to
the hash API in commit
a69aac41c4b2ccff1084736c158d7cf8474be533.
("list: Make types of hash elements consistent")

Change-Id: Iacec5920cdc3e16aaf777f843ef1f4a00a6a9043
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1324
Message-Id: <20251030145124.2607-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
035.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/mtcp.c
M src/openvpn/mudp.c
2 files changed, 0 insertions(+), 18 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/1324/3

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

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1324?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iacec5920cdc3e16aaf777f843ef1f4a00a6a9043
Gerrit-Change-Number: 1324
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8uGjdof3B6o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1324?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">mudp/mtcp: Remove -Wconversion prag=
mas<br><br>These were implictly fixed by the fixes to<br>the hash API in co=
mmit<br>a69aac41c4b2ccff1084736c158d7cf8474be533.<br>(&quot;list: Make type=
s of hash elements consistent&quot;)<br><br>Change-Id: Iacec5920cdc3e16aaf7=
77f843ef1f4a00a6a9043<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2746...=
...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: ht=
tps://gerrit.openvpn.net/c/openvpn/+/1324<br>Message-Id: &lt;20251030145124=
.2607-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg34035.html<br>Signed-off-by: Gert Doering &lt;=
gert@...1296...&gt;<br>---<br>M src/openvpn/mtcp.c<br>M src/openvpn/mudp.c<=
br>2 files changed, 0 insertions(+), 18 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/1324/3=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><sp=
an>index 83edec6..81310a2 100644</span><br><span>--- a/src/openvpn/mtcp.c</=
span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -45,11 +45,6 @@<=
/span><br><span>     unsigned int sock;</span><br><span> };</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> struct multi_instance *</span=
><br><span> multi_create_instance_tcp(struct multi_context *m, struct link_=
socket *sock)</span><br><span> {</span><br><span>@@ -125,10 +120,6 @@</span=
><br><span>     return true;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> v=
oid</span><br><span> multi_tcp_instance_specific_free(struct multi_instance=
 *mi)</span><br><span> {</span><br><span>diff --git a/src/openvpn/mudp.c b/=
src/openvpn/mudp.c</span><br><span>index a373a6a..31134be 100644</span><br>=
<span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</sp=
an><br><span>@@ -180,11 +180,6 @@</span><br><span>     return false;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
/*</span><br><span>  * Get a client instance based on real address.  If</sp=
an><br><span>  * the instance doesn&#39;t exist, create it while</span><br>=
<span>@@ -315,10 +310,6 @@</span><br><span>     return mi;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> /*</span><br><span>  * Send a packet to UDP so=
cket.</span><br><span>  */</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1324?usp=3Demail">chang=
e 1324</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1324?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iacec5920cdc3e16aaf777f843ef=
1f4a00a6a9043 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1324 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--8uGjdof3B6o=--

