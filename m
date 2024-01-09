From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 9 Jan 2024 11:09:01 +0000
References: <gerrit.1704798536000.I8ef199463d46303129a3f563fd9eace780a58b8a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8094f36bd4c0f3bde973bb1b4c8d206604bac081-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SwqK8GKvcgo="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: phase2_tcp_server:
 fix Coverity issue "Dereference after null check"
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

--SwqK8GKvcgo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/490?usp=3Demail

to review the following change.


Change subject: phase2_tcp_server: fix Coverity issue "Dereference after nu=
ll check"
......................................................................

phase2_tcp_server: fix Coverity issue "Dereference after null check"

As Coverity says:
Either the check against null is unnecessary, or there may be a null
pointer dereference.
In phase2_tcp_server: Pointer is checked against null but then
dereferenced anyway

The check is probably not required since we have an ASSERT(sig_info)
in the caller. But I really didn't want to remove the check. So
make the code consistent instead.

Change-Id: I8ef199463d46303129a3f563fd9eace780a58b8a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/socket.c
1 file changed, 4 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/490/1

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 480f4e5..c158de1 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2031,7 +2031,10 @@
                                         false);
             if (!socket_defined(sock->sd))
             {
-                register_signal(sig_info, SIGTERM, "socket-undefiled");
+                if (signal_received)
+                {
+                    register_signal(sig_info, SIGTERM, "socket-undefined");
+                }
                 return;
             }
             tcp_connection_established(&sock->info.lsa->actual);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/490?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8ef199463d46303129a3f563fd9eace780a58b8a
Gerrit-Change-Number: 490
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--SwqK8GKvcgo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/490?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">phase2_tcp_server: fix Coverity issue &quot;Dereference after=
 null check&quot;<br><br>As Coverity says:<br>Either the check against null=
 is unnecessary, or there may be a null<br>pointer dereference.<br>In phase=
2_tcp_server: Pointer is checked against null but then<br>dereferenced anyw=
ay<br><br>The check is probably not required since we have an ASSERT(sig_in=
fo)<br>in the caller. But I really didn&#39;t want to remove the check. So<=
br>make the code consistent instead.<br><br>Change-Id: I8ef199463d46303129a=
3f563fd9eace780a58b8a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2746...=
...&gt;<br>---<br>M src/openvpn/socket.c<br>1 file changed, 4 insertions(+)=
, 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/90/490/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/socket.c b/src/openvp=
n/socket.c</span><br><span>index 480f4e5..c158de1 100644</span><br><span>--=
- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><=
br><span>@@ -2031,7 +2031,10 @@</span><br><span>                           =
              false);</span><br><span>             if (!socket_defined(sock=
-&gt;sd))</span><br><span>             {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                register_signal(sig_info, SIGTERM, &quot=
;socket-undefiled&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                if (signal_received)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    register_signal(sig_info, SIGTERM,=
 &quot;socket-undefined&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                }</span><br><span>                 return;</spa=
n><br><span>             }</span><br><span>             tcp_connection_esta=
blished(&amp;sock-&gt;info.lsa-&gt;actual);</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/490?us=
p=3Demail">change 490</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/490?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8ef199463d46303129a3f563fd9=
eace780a58b8a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 490 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--SwqK8GKvcgo=--

