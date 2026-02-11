From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 11 Feb 2026 08:26:49 +0000
References: <gerrit.1770798406000.Ie5c9a88050de959cfb02e5f804323a8081ddb667@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <012cb1005dfefeceb4bbaa0ed7c53d82cafe1fcb-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2fmh1dhWdXQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: port-share: log
 incoming connections at verb 3 only
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

--2fmh1dhWdXQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1516?usp=3Demail

to review the following change.


Change subject: port-share: log incoming connections at verb 3 only
......................................................................

port-share: log incoming connections at verb 3 only

From "day 1" the message "Non-OpenVPN client protocol detected" was
logged at D_STREAM_ERRORS level (verb 1), while it is not anything
erroneous in this context (it's inside an "port share" only block).

Bump this to D_PS_PROXY (verb 3).

Github: closes OpenVPN/openvpn#976

Change-Id: Ie5c9a88050de959cfb02e5f804323a8081ddb667
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/1516/1

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 58ccda9..d97b770 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2149,7 +2149,7 @@
         {
             if (!is_openvpn_protocol(&sb->buf))
             {
-                msg(D_STREAM_ERRORS, "Non-OpenVPN client protocol detected=
");
+                msg(D_PS_PROXY, "Non-OpenVPN client protocol detected");
                 sb->port_share_state =3D PS_FOREIGN;
                 sb->error =3D true;
                 return false;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1516?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie5c9a88050de959cfb02e5f804323a8081ddb667
Gerrit-Change-Number: 1516
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--2fmh1dhWdXQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>cron2 would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1516?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">port-share: log incoming connections at ver=
b 3 only<br><br>From &quot;day 1&quot; the message &quot;Non-OpenVPN client=
 protocol detected&quot; was<br>logged at D_STREAM_ERRORS level (verb 1), w=
hile it is not anything<br>erroneous in this context (it&#39;s inside an &q=
uot;port share&quot; only block).<br><br>Bump this to D_PS_PROXY (verb 3).<=
br><br>Github: closes OpenVPN/openvpn#976<br><br>Change-Id: Ie5c9a88050de95=
9cfb02e5f804323a8081ddb667<br>Signed-off-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>---<br>M src/openvpn/socket.c<br>1 file changed, 1 insertion(+), =
1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/16/1516/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/socke=
t.c b/src/openvpn/socket.c</span><br><span>index 58ccda9..d97b770 100644</s=
pan><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/=
socket.c</span><br><span>@@ -2149,7 +2149,7 @@</span><br><span>         {</=
span><br><span>             if (!is_openvpn_protocol(&amp;sb-&gt;buf))</spa=
n><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                msg(D_STREAM_ERRORS, &quot;Non-OpenVPN client protocol=
 detected&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              msg(D_PS_PROXY, &quot;Non-OpenVPN client protocol detected&qu=
ot;);</span><br><span>                 sb-&gt;port_share_state =3D PS_FOREI=
GN;</span><br><span>                 sb-&gt;error =3D true;</span><br><span=
>                 return false;</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1516?usp=3Demail">=
change 1516</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1516?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie5c9a88050de959cfb02e5f8043=
23a8081ddb667 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1516 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--2fmh1dhWdXQ=--

