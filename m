From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 8 May 2026 11:27:26 +0000
References: <gerrit.1778239616000.I3d391016dcd3c66e58f3f05b356bcd419224acb1@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <038d705b9bebad71d215c4cec727d85f437a1e7f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XVyQNwuibR4="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: Use
 same variant of UuidToString and RpcStringFree
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

--XVyQNwuibR4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1671?usp=3Demail

to review the following change.


Change subject: openvpnserv: Use same variant of UuidToString and RpcString=
Free
......................................................................

openvpnserv: Use same variant of UuidToString and RpcStringFree

Probably not a real issue since it should always use the
W version in our case, but still unclean.

Fixes a cppcheck complaint.

Change-Id: I3d391016dcd3c66e58f3f05b356bcd419224acb1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpnserv/interactive.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/71/1671/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index e25c511..bd310e4 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -3484,7 +3484,7 @@
     swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
              L"\\\\.\\pipe\\" _L(PACKAGE) L"%ls\\service_%lu_%ls", service=
_instance,
              GetCurrentThreadId(), pipe_uuid_str);
-    RpcStringFree(&pipe_uuid_str);
+    RpcStringFreeW(&pipe_uuid_str);

     /* make a security descriptor for the named pipe with access
      * restricted to the user and SYSTEM

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1671?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3d391016dcd3c66e58f3f05b356bcd419224acb1
Gerrit-Change-Number: 1671
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--XVyQNwuibR4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1671?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">openvpnserv: Use same variant of UuidToStri=
ng and RpcStringFree<br><br>Probably not a real issue since it should alway=
s use the<br>W version in our case, but still unclean.<br><br>Fixes a cppch=
eck complaint.<br><br>Change-Id: I3d391016dcd3c66e58f3f05b356bcd419224acb1<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M sr=
c/openvpnserv/interactive.c<br>1 file changed, 1 insertion(+), 1 deletion(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/71/1671/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive.c=
 b/src/openvpnserv/interactive.c</span><br><span>index e25c511..bd310e4 100=
644</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><span>+++=
 b/src/openvpnserv/interactive.c</span><br><span>@@ -3484,7 +3484,7 @@</spa=
n><br><span>     swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),</span><=
br><span>              L&quot;\\\\.\\pipe\\&quot; _L(PACKAGE) L&quot;%ls\\s=
ervice_%lu_%ls&quot;, service_instance,</span><br><span>              GetCu=
rrentThreadId(), pipe_uuid_str);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    RpcStringFree(&amp;pipe_uuid_str);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    RpcStringFreeW(&amp;pipe_uuid_str);</span=
><br><span> </span><br><span>     /* make a security descriptor for the nam=
ed pipe with access</span><br><span>      * restricted to the user and SYST=
EM</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1671?usp=3Demail">change 1671</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1671?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3d391016dcd3c66e58f3f05b356=
bcd419224acb1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1671 </div>
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

--XVyQNwuibR4=--

