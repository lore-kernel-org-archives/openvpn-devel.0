From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 23 Oct 2024 12:03:18 +0000
In-Reply-To: <gerrit.1729681493000.I8526aadb5151ddc997c836d5a691bcdfee700938@...2715...>
References: <gerrit.1729681493000.I8526aadb5151ddc997c836d5a691bcdfee700938@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <2e998e6fc7911dc25d043348d0dfb348544365bd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c02PvPh3YOk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix for
 msbuild/mingw GHA failures
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--c02PvPh3YOk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/78=
5?usp=3Demail )

Change subject: Fix for msbuild/mingw GHA failures
......................................................................

Fix for msbuild/mingw GHA failures

Commit cd8e25a6e9 removed a variable because it looked as if
used only once anyway (1 assignment, 1 usage) - overlooking that
on _WIN32 it's changed to NULL, which wasn't adjusted...

This fix restores the wiped out "unsigned int *persistent" in
multi_tcp_wait(), undoing this particular change of the previous
commit.

Change-Id: I8526aadb5151ddc997c836d5a691bcdfee700938
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241023113923.7420-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
612.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/mtcp.c
1 file changed, 2 insertions(+), 1 deletion(-)




diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 67e3e8e..6faf45a 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -254,6 +254,7 @@
                struct multi_tcp *mtcp)
 {
     int status;
+    unsigned int *persistent =3D &mtcp->tun_rwflags;
     socket_set_listen_persistent(c->c2.link_socket, mtcp->es,
                                  &c->c2.link_socket->ev_arg);

@@ -271,7 +272,7 @@
         persistent =3D NULL;
     }
 #endif
-    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, &mtcp->tun_rwfla=
gs);
+    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, persistent);
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     dco_event_set(&c->c1.tuntap->dco, mtcp->es, MTCP_DCO);
 #endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/785?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8526aadb5151ddc997c836d5a691bcdfee700938
Gerrit-Change-Number: 785
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--c02PvPh3YOk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/785?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Fix for msbuild/mingw GHA failures<br><br>Comm=
it cd8e25a6e9 removed a variable because it looked as if<br>used only once =
anyway (1 assignment, 1 usage) - overlooking that<br>on _WIN32 it&#39;s cha=
nged to NULL, which wasn&#39;t adjusted...<br><br>This fix restores the wip=
ed out &quot;unsigned int *persistent&quot; in<br>multi_tcp_wait(), undoing=
 this particular change of the previous<br>commit.<br><br>Change-Id: I8526a=
adb5151ddc997c836d5a691bcdfee700938<br>Signed-off-by: Gianmarco De Gregori =
&lt;gianmarco@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&=
gt;<br>Message-Id: &lt;20241023113923.7420-1-gert@...1296...&gt;<br>URL: ht=
tps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29612.htm=
l<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/op=
envpn/mtcp.c<br>1 file changed, 2 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>ind=
ex 67e3e8e..6faf45a 100644</span><br><span>--- a/src/openvpn/mtcp.c</span><=
br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -254,6 +254,7 @@</span=
><br><span>                struct multi_tcp *mtcp)</span><br><span> {</span=
><br><span>     int status;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    unsigned int *persistent =3D &amp;mtcp-&gt;tun_rwflags;</span><=
br><span>     socket_set_listen_persistent(c-&gt;c2.link_socket, mtcp-&gt;e=
s,</span><br><span>                                  &amp;c-&gt;c2.link_soc=
ket-&gt;ev_arg);</span><br><span> </span><br><span>@@ -271,7 +272,7 @@</spa=
n><br><span>         persistent =3D NULL;</span><br><span>     }</span><br>=
<span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tun_=
set(c-&gt;c1.tuntap, mtcp-&gt;es, EVENT_READ, MTCP_TUN, &amp;mtcp-&gt;tun_r=
wflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tun_set=
(c-&gt;c1.tuntap, mtcp-&gt;es, EVENT_READ, MTCP_TUN, persistent);</span><br=
><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><spa=
n>     dco_event_set(&amp;c-&gt;c1.tuntap-&gt;dco, mtcp-&gt;es, MTCP_DCO);<=
/span><br><span> #endif</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/785?usp=3Demail">change 78=
5</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/785?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8526aadb5151ddc997c836d5a69=
1bcdfee700938 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 785 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--c02PvPh3YOk=--

