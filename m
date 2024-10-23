From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 23 Oct 2024 11:05:12 +0000
References: <gerrit.1729681493000.I8526aadb5151ddc997c836d5a691bcdfee700938@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <63d4a5e2c940a336b4ad361084ae02a7c6b6552f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qtSChsl8y2o="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qtSChsl8y2o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/785?usp=3Demail

to review the following change.


Change subject: Fix for msbuild/mingw GHA failures
......................................................................

Fix for msbuild/mingw GHA failures

Commit ("event/multi: add event_arg object to make
event handling more generic") accidentally removed
a variable declaration and its usage because of a
rebase, this fix restore the wiped out
unsigned int *persistent in multi_tcp_wait().

Change-Id: I8526aadb5151ddc997c836d5a691bcdfee700938
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/mtcp.c
1 file changed, 2 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/785/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--qtSChsl8y2o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/785?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix for msbuild/mingw GHA failures<br><br>Commit (&quot;event=
/multi: add event_arg object to make<br>event handling more generic&quot;) =
accidentally removed<br>a variable declaration and its usage because of a<b=
r>rebase, this fix restore the wiped out<br>unsigned int *persistent in mul=
ti_tcp_wait().<br><br>Change-Id: I8526aadb5151ddc997c836d5a691bcdfee700938<=
br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>---<=
br>M src/openvpn/mtcp.c<br>1 file changed, 2 insertions(+), 1 deletion(-)<b=
r><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/78=
5/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br>=
<span>index 67e3e8e..6faf45a 100644</span><br><span>--- a/src/openvpn/mtcp.=
c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -254,6 +254,7=
 @@</span><br><span>                struct multi_tcp *mtcp)</span><br><span=
> {</span><br><span>     int status;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    unsigned int *persistent =3D &amp;mtcp-&gt;tun_rwflags=
;</span><br><span>     socket_set_listen_persistent(c-&gt;c2.link_socket, m=
tcp-&gt;es,</span><br><span>                                  &amp;c-&gt;c2=
.link_socket-&gt;ev_arg);</span><br><span> </span><br><span>@@ -271,7 +272,=
7 @@</span><br><span>         persistent =3D NULL;</span><br><span>     }</=
span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    tun_set(c-&gt;c1.tuntap, mtcp-&gt;es, EVENT_READ, MTCP_TUN, &amp;mtcp-=
&gt;tun_rwflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  tun_set(c-&gt;c1.tuntap, mtcp-&gt;es, EVENT_READ, MTCP_TUN, persistent);<=
/span><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span=
><br><span>     dco_event_set(&amp;c-&gt;c1.tuntap-&gt;dco, mtcp-&gt;es, MT=
CP_DCO);</span><br><span> #endif</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/785?usp=3Demail">=
change 785</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/785?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8526aadb5151ddc997c836d5a69=
1bcdfee700938 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 785 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--qtSChsl8y2o=--

