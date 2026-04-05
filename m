From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 5 Apr 2026 10:28:08 +0000
In-Reply-To: <gerrit.1775328983000.I04a01cf536ee6d48d54ba623dda460c4a98859f9@...2715...>
References: <gerrit.1775328983000.I04a01cf536ee6d48d54ba623dda460c4a98859f9@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <154df37cad51505f114718171ba29ac3f934331c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="q8LqR006Yao="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: mtcp: Remove noop
 statement in multi_tcp_process_outgoing_link_ready
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--q8LqR006Yao=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
09?usp=3Demail )

Change subject: mtcp: Remove noop statement in multi_tcp_process_outgoing_l=
ink_ready
......................................................................

mtcp: Remove noop statement in multi_tcp_process_outgoing_link_ready

Assigning to a parameter here has no effect. I can see no
obvious alternative statement that might have been intended.

Found by cppcheck.

Change-Id: I04a01cf536ee6d48d54ba623dda460c4a98859f9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1609
Message-Id: <20260404203335.30650-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
478.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/mtcp.c
1 file changed, 0 insertions(+), 4 deletions(-)




diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 2eab7b7..7651b4d 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -155,10 +155,6 @@
         ASSERT(mi =3D=3D item.instance);
         mi->context.c2.to_link =3D item.buffer->buf;
         ret =3D multi_process_outgoing_link_dowork(m, mi, mpp_flags);
-        if (!ret)
-        {
-            mi =3D NULL;
-        }
         mbuf_free_buf(item.buffer);
     }
     return ret;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1609?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I04a01cf536ee6d48d54ba623dda460c4a98859f9
Gerrit-Change-Number: 1609
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--q8LqR006Yao=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1609?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">mtcp: Remove noop statement in multi_tcp_process=
_outgoing_link_ready<br><br>Assigning to a parameter here has no effect. I =
can see no<br>obvious alternative statement that might have been intended.<=
br><br>Found by cppcheck.<br><br>Change-Id: I04a01cf536ee6d48d54ba623dda460=
c4a98859f9<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>=
Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerri=
t.openvpn.net/c/openvpn/+/1609<br>Message-Id: &lt;20260404203335.30650-1-ge=
rt@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1199...=
sourceforge.net/msg36478.html<br>Signed-off-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>---<br>M src/openvpn/mtcp.c<br>1 file changed, 0 insertions(+)=
, 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>ind=
ex 2eab7b7..7651b4d 100644</span><br><span>--- a/src/openvpn/mtcp.c</span><=
br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -155,10 +155,6 @@</spa=
n><br><span>         ASSERT(mi =3D=3D item.instance);</span><br><span>     =
    mi-&gt;context.c2.to_link =3D item.buffer-&gt;buf;</span><br><span>    =
     ret =3D multi_process_outgoing_link_dowork(m, mi, mpp_flags);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (!ret)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            mi =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span>         mbuf_fre=
e_buf(item.buffer);</span><br><span>     }</span><br><span>     return ret;=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1609?usp=3Demail">change 1609</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:=
//schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1609?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I04a01cf536ee6d48d54ba623dda=
460c4a98859f9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1609 </div>
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

--q8LqR006Yao=--

