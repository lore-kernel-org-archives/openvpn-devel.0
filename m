From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 12:18:17 +0000
In-Reply-To: <gerrit.1761601339000.Idbb7bf279eb467fc1d56ab75a50b5eb2c8d0a57e@...2715...>
References: <gerrit.1761601339000.Idbb7bf279eb467fc1d56ab75a50b5eb2c8d0a57e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ad1d92673480ba88ee8249e328c38e3557083283-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3jaWTN1O6Sk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Add ASSERT to
 afunix code that dev_node is always set up the way we e...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3jaWTN1O6Sk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1320?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Add ASSERT to afunix code that dev_node is always set up th=
e way we expect
......................................................................

Add ASSERT to afunix code that dev_node is always set up the way we expect

The calling code only calls tun_afunix_exec_child if is_tun_afunix is true,
which checks that the path is having unix: as prefix.

But since adding an ASSERT here to ensure that it is really the case
does not cost us anything, just add the ASSERT.

Reported-By: Joshua Rogers <contact@...2949...>
Found-By: Zeropath

Change-Id: Idbb7bf279eb467fc1d56ab75a50b5eb2c8d0a57e
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1320
Message-Id: <20251028115953.22487-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
934.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tun_afunix.c
1 file changed, 2 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/20/1320/3

diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index 124db6d..42bcd0d 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -53,6 +53,8 @@
     const char *msgprefix =3D "ERROR: failure executing process for tun:";
     struct argv argv =3D argv_new();

+    /* we should always called with a proper unix: dev node string */
+    ASSERT(dev_node && strncmp(dev_node, "unix:", strlen("unix:")) =3D=3D =
0);
     /* since we know that dev-node starts with unix: we can just skip that
      * to get the program name */
     const char *program =3D dev_node + strlen("unix:");

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1320?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idbb7bf279eb467fc1d56ab75a50b5eb2c8d0a57e
Gerrit-Change-Number: 1320
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3jaWTN1O6Sk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1320?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Add ASSERT to afunix code that dev_=
node is always set up the way we expect<br><br>The calling code only calls =
tun_afunix_exec_child if is_tun_afunix is true,<br>which checks that the pa=
th is having unix: as prefix.<br><br>But since adding an ASSERT here to ens=
ure that it is really the case<br>does not cost us anything, just add the A=
SSERT.<br><br>Reported-By: Joshua Rogers &lt;contact@...2949...&gt;<br>Foun=
d-By: Zeropath<br><br>Change-Id: Idbb7bf279eb467fc1d56ab75a50b5eb2c8d0a57e<=
br>Signed-off-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Acked-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn=
.net/c/openvpn/+/1320<br>Message-Id: &lt;20251028115953.22487-1-gert@...1826...=
6...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1768...=
ge.net/msg33934.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;=
<br>---<br>M src/openvpn/tun_afunix.c<br>1 file changed, 2 insertions(+), 0=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/20/1320/3</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/tun_a=
funix.c b/src/openvpn/tun_afunix.c</span><br><span>index 124db6d..42bcd0d 1=
00644</span><br><span>--- a/src/openvpn/tun_afunix.c</span><br><span>+++ b/=
src/openvpn/tun_afunix.c</span><br><span>@@ -53,6 +53,8 @@</span><br><span>=
     const char *msgprefix =3D &quot;ERROR: failure executing process for t=
un:&quot;;</span><br><span>     struct argv argv =3D argv_new();</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* we sh=
ould always called with a proper unix: dev node string */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(dev_node &amp;&amp; strncm=
p(dev_node, &quot;unix:&quot;, strlen(&quot;unix:&quot;)) =3D=3D 0);</span>=
<br><span>     /* since we know that dev-node starts with unix: we can just=
 skip that</span><br><span>      * to get the program name */</span><br><sp=
an>     const char *program =3D dev_node + strlen(&quot;unix:&quot;);</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1320?usp=3Demail">change 1320</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1320?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idbb7bf279eb467fc1d56ab75a50=
b5eb2c8d0a57e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1320 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--3jaWTN1O6Sk=--

