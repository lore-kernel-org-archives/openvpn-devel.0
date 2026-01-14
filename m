From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 14 Jan 2026 18:40:44 +0000
In-Reply-To: <gerrit.1768308239000.Ic1c8f24de423541bdc85e70b5a688213800d86de@...2715...>
References: <gerrit.1768308239000.Ic1c8f24de423541bdc85e70b5a688213800d86de@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d41aaceacaa9545a43c7b03539cd47f3c9dff2ad-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X3miuP4DjPI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socks: In
 establish_socks_proxy_udpassoc check result of recv_socks_r...
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

--X3miuP4DjPI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1469?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: socks: In establish_socks_proxy_udpassoc check result of re=
cv_socks_reply
......................................................................

socks: In establish_socks_proxy_udpassoc check result of recv_socks_reply

Not just check the return value but also that relay_addr
is valid. recv_socks_reply doesn't care whether the answer
is what we expected. This is probably a very unlikely edge
case but it doesn't hurt to check for it here.

Reported-By: Joshua Rogers <contact@...2949...>
Found-By: ZeroPath (https://zeropath.com)
Github: openvpn-private-issues#13
Change-Id: Ic1c8f24de423541bdc85e70b5a688213800d86de
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1469
Message-Id: <20260114135807.20637-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
249.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socks.c
1 file changed, 6 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/1469/2

diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 078b4e1..5cb5912 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -412,8 +412,7 @@
             send(ctrl_sd, "\x05\x03\x00\x01\x00\x00\x00\x00\x00\x00", 10, =
MSG_NOSIGNAL);
         if (size !=3D 10)
         {
-            msg(D_LINK_ERRORS | M_ERRNO,
-                "establish_socks_proxy_passthru: TCP port write failed on =
send()");
+            msg(D_LINK_ERRORS | M_ERRNO, "%s: TCP port write failed on sen=
d()", __func__);
             goto error;
         }
     }
@@ -424,6 +423,11 @@
     {
         goto error;
     }
+    if (!relay_addr->addr.in4.sin_addr.s_addr)
+    {
+        msg(D_LINK_ERRORS, "%s: Socks proxy did not answer with IPv4 addre=
ss", __func__);
+        goto error;
+    }

     return;


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1469?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic1c8f24de423541bdc85e70b5a688213800d86de
Gerrit-Change-Number: 1469
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--X3miuP4DjPI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1469?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">socks: In establish_socks_proxy_udp=
assoc check result of recv_socks_reply<br><br>Not just check the return val=
ue but also that relay_addr<br>is valid. recv_socks_reply doesn&#39;t care =
whether the answer<br>is what we expected. This is probably a very unlikely=
 edge<br>case but it doesn&#39;t hurt to check for it here.<br><br>Reported=
-By: Joshua Rogers &lt;contact@...2949...&gt;<br>Found-By: ZeroPath (https:=
//zeropath.com)<br>Github: openvpn-private-issues#13<br>Change-Id: Ic1c8f24=
de423541bdc85e70b5a688213800d86de<br>Signed-off-by: Frank Lichtenheld &lt;f=
rank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Ge=
rrit URL: https://gerrit.openvpn.net/c/openvpn/+/1469<br>Message-Id: &lt;20=
260114135807.20637-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.c=
om/openvpn-devel@lists.sourceforge.net/msg35249.html<br>Signed-off-by: Gert=
 Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/socks.c<br>1 file =
changed, 6 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/1469/2</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/socks.c b/src/openvpn/socks.c</span><br><span>index 0=
78b4e1..5cb5912 100644</span><br><span>--- a/src/openvpn/socks.c</span><br>=
<span>+++ b/src/openvpn/socks.c</span><br><span>@@ -412,8 +412,7 @@</span><=
br><span>             send(ctrl_sd, &quot;\x05\x03\x00\x01\x00\x00\x00\x00\=
x00\x00&quot;, 10, MSG_NOSIGNAL);</span><br><span>         if (size !=3D 10=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg(D_LINK_ERRORS | M_ERRNO,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                &quot;establish_socks_proxy_passt=
hru: TCP port write failed on send()&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            msg(D_LINK_ERRORS | M_ERRNO, &quot;%s:=
 TCP port write failed on send()&quot;, __func__);</span><br><span>        =
     goto error;</span><br><span>         }</span><br><span>     }</span><b=
r><span>@@ -424,6 +423,11 @@</span><br><span>     {</span><br><span>       =
  goto error;</span><br><span>     }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!relay_addr-&gt;addr.in4.sin_addr.s_addr)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(D_LINK_ERRORS, &quot;%s: Sock=
s proxy did not answer with IPv4 address&quot;, __func__);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><s=
pan>     return;</span><br><span> </span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1469?usp=3Demai=
l">change 1469</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1469?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic1c8f24de423541bdc85e70b5a6=
88213800d86de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1469 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--X3miuP4DjPI=--

