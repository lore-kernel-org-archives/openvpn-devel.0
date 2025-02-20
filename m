From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 20 Feb 2025 08:04:53 +0000
In-Reply-To: <gerrit.1740037224000.Ie57f7b11157ab5ca8ff01e1c4f03a308117ff937@...2715...>
References: <gerrit.1740037224000.Ie57f7b11157ab5ca8ff01e1c4f03a308117ff937@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <b132fa6bb4b5891df194c0fbdfdaaf86065bb6b9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aQJ4N6yerLM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco-win: simplify
 control packets prepend code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--aQJ4N6yerLM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/90=
0?usp=3Demail )

Change subject: dco-win: simplify control packets prepend code
......................................................................

dco-win: simplify control packets prepend code

Eliminate unneeded temporary struct sockaddr_in buffer.

Change-Id: Ie57f7b11157ab5ca8ff01e1c4f03a308117ff937
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250220074327.24922-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
942.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.h
1 file changed, 2 insertions(+), 6 deletions(-)




diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index c370f2c..2c33319 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1125,15 +1125,11 @@
     {
         if (to->dest.addr.sa.sa_family =3D=3D AF_INET)
         {
-            struct sockaddr_in sa;
-            memcpy(&sa, &to->dest.addr.in4, sizeof(sa));
-            buf_write_prepend(buf, &sa, sizeof(sa));
+            buf_write_prepend(buf, &to->dest.addr.in4, sizeof(struct socka=
ddr_in));
         }
         else
         {
-            struct sockaddr_in6 sa;
-            memcpy(&sa, &to->dest.addr.in6, sizeof(sa));
-            buf_write_prepend(buf, &sa, sizeof(sa));
+            buf_write_prepend(buf, &to->dest.addr.in6, sizeof(struct socka=
ddr_in6));
         }
     }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/900?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie57f7b11157ab5ca8ff01e1c4f03a308117ff937
Gerrit-Change-Number: 900
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--aQJ4N6yerLM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/900?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">dco-win: simplify control packets prepend code=
<br><br>Eliminate unneeded temporary struct sockaddr_in buffer.<br><br>Chan=
ge-Id: Ie57f7b11157ab5ca8ff01e1c4f03a308117ff937<br>Signed-off-by: Lev Stip=
akov &lt;lev@...515...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt=
;<br>Message-Id: &lt;20250220074327.24922-1-gert@...1296...&gt;<br>URL: htt=
ps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30942.html=
<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/ope=
nvpn/socket.h<br>1 file changed, 2 insertions(+), 6 deletions(-)<br><br></p=
re>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><br><span=
>index c370f2c..2c33319 100644</span><br><span>--- a/src/openvpn/socket.h</=
span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -1125,15 +1125=
,11 @@</span><br><span>     {</span><br><span>         if (to-&gt;dest.addr=
.sa.sa_family =3D=3D AF_INET)</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            struct sockaddr_in sa;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            memcpy(&amp;sa,=
 &amp;to-&gt;dest.addr.in4, sizeof(sa));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            buf_write_prepend(buf, &amp;sa, sizeof(sa));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_wri=
te_prepend(buf, &amp;to-&gt;dest.addr.in4, sizeof(struct sockaddr_in));</sp=
an><br><span>         }</span><br><span>         else</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            stru=
ct sockaddr_in6 sa;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          memcpy(&amp;sa, &amp;to-&gt;dest.addr.in6, sizeof(sa));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            buf_write_prepend(b=
uf, &amp;sa, sizeof(sa));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            buf_write_prepend(buf, &amp;to-&gt;dest.addr.in6, sizeof(=
struct sockaddr_in6));</span><br><span>         }</span><br><span>     }</s=
pan><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/900?usp=3Demail">change 900</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/900?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie57f7b11157ab5ca8ff01e1c4f0=
3a308117ff937 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 900 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--aQJ4N6yerLM=--

