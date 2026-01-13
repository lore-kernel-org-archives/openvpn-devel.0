From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 13 Jan 2026 12:44:01 +0000
References: <gerrit.1768308239000.Ic1c8f24de423541bdc85e70b5a688213800d86de@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8722f6924e25ede459fd51131eae6e3b46d39bea-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZbTRtgOZPHw="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZbTRtgOZPHw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1469?usp=3Demail

to review the following change.


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
---
M src/openvpn/socks.c
1 file changed, 6 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/1469/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic1c8f24de423541bdc85e70b5a688213800d86de
Gerrit-Change-Number: 1469
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--ZbTRtgOZPHw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1469?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">socks: In establish_socks_proxy_udpassoc ch=
eck result of recv_socks_reply<br><br>Not just check the return value but a=
lso that relay_addr<br>is valid. recv_socks_reply doesn&#39;t care whether =
the answer<br>is what we expected. This is probably a very unlikely edge<br=
>case but it doesn&#39;t hurt to check for it here.<br><br>Reported-By: Jos=
hua Rogers &lt;contact@...2949...&gt;<br>Found-By: ZeroPath (https://zeropa=
th.com)<br>Github: openvpn-private-issues#13<br>Change-Id: Ic1c8f24de423541=
bdc85e70b5a688213800d86de<br>Signed-off-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>---<br>M src/openvpn/socks.c<br>1 file changed, 6 insertions=
(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/69/1469/1</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
/socks.c b/src/openvpn/socks.c</span><br><span>index 078b4e1..5cb5912 10064=
4</span><br><span>--- a/src/openvpn/socks.c</span><br><span>+++ b/src/openv=
pn/socks.c</span><br><span>@@ -412,8 +412,7 @@</span><br><span>            =
 send(ctrl_sd, &quot;\x05\x03\x00\x01\x00\x00\x00\x00\x00\x00&quot;, 10, MS=
G_NOSIGNAL);</span><br><span>         if (size !=3D 10)</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ms=
g(D_LINK_ERRORS | M_ERRNO,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                &quot;establish_socks_proxy_passthru: TCP port write f=
ailed on send()&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            msg(D_LINK_ERRORS | M_ERRNO, &quot;%s: TCP port write faile=
d on send()&quot;, __func__);</span><br><span>             goto error;</spa=
n><br><span>         }</span><br><span>     }</span><br><span>@@ -424,6 +42=
3,11 @@</span><br><span>     {</span><br><span>         goto error;</span><=
br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!relay_addr-&gt;addr.in4.sin_addr.s_addr)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(D_LINK_ERRORS, &quot;%s: Socks proxy did not answer=
 with IPv4 address&quot;, __func__);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        goto error;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span> </span><br><span>     return;</span=
><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1469?usp=3Demail">change 1469</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemt=
ype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" i=
temtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1469?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic1c8f24de423541bdc85e70b5a6=
88213800d86de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1469 </div>
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

--ZbTRtgOZPHw=--

