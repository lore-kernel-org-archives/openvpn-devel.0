From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 13 Feb 2026 22:06:43 +0000
In-Reply-To: <gerrit.1770798406000.Ie5c9a88050de959cfb02e5f804323a8081ddb667@...2715...>
References: <gerrit.1770798406000.Ie5c9a88050de959cfb02e5f804323a8081ddb667@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7ea2a12aa162a0e3c3c8ebe4119f12ebfdf06d46-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ELfOH4U1ze0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ELfOH4U1ze0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1516?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld, Code-Review+2 by plaisthos


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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1516
Message-Id: <20260211113315.25776-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
589.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/1516/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie5c9a88050de959cfb02e5f804323a8081ddb667
Gerrit-Change-Number: 1516
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ELfOH4U1ze0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change.</p><p><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1516?usp=3Demail">View Change</a></p><p>The followi=
ng approvals got outdated and were removed:
Code-Review+2 by flichtenheld, Code-Review+2 by plaisthos</p><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
port-share: log incoming connections at verb 3 only<br><br>From &quot;day 1=
&quot; the message &quot;Non-OpenVPN client protocol detected&quot; was<br>=
logged at D_STREAM_ERRORS level (verb 1), while it is not anything<br>erron=
eous in this context (it&#39;s inside an &quot;port share&quot; only block)=
.<br><br>Bump this to D_PS_PROXY (verb 3).<br><br>Github: closes OpenVPN/op=
envpn#976<br><br>Change-Id: Ie5c9a88050de959cfb02e5f804323a8081ddb667<br>Si=
gned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-by: Arne Schwabe=
 &lt;arne-openvpn@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1516<br=
>Message-Id: &lt;20260211113315.25776-1-gert@...1296...&gt;<br>URL: https:/=
/www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35589.html<br>=
Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn=
/socket.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/=
1516/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</sp=
an><br><span>index 58ccda9..d97b770 100644</span><br><span>--- a/src/openvp=
n/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -2=
149,7 +2149,7 @@</span><br><span>         {</span><br><span>             if=
 (!is_openvpn_protocol(&amp;sb-&gt;buf))</span><br><span>             {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(D_STR=
EAM_ERRORS, &quot;Non-OpenVPN client protocol detected&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                msg(D_PS_PROXY, =
&quot;Non-OpenVPN client protocol detected&quot;);</span><br><span>        =
         sb-&gt;port_share_state =3D PS_FOREIGN;</span><br><span>          =
       sb-&gt;error =3D true;</span><br><span>                 return false=
;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1516?usp=3Demail">change 1516</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1516?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie5c9a88050de959cfb02e5f8043=
23a8081ddb667 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1516 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--ELfOH4U1ze0=--

