From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 12 Sep 2025 17:00:35 +0000
In-Reply-To: <gerrit.1753488078000.I1ad5df0f6785ffe9becd9f83329a9335d1a36f24@...2715...>
References: <gerrit.1753488078000.I1ad5df0f6785ffe9becd9f83329a9335d1a36f24@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <694533f0583c4c25c009dafd89d4f231fa3a222f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1MvoM4YTBW8="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco: add standard
 mi prefix handling to multi_process_incoming_dco()
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

--1MvoM4YTBW8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 ordex. ( http://gerrit.openvpn.net/c/openvpn/+/1116?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: dco: add standard mi prefix handling to multi_process_incom=
ing_dco()
......................................................................

dco: add standard mi prefix handling to multi_process_incoming_dco()

Our code generally expects functions that deal with a multi instance
to set up a log prefix at the beginning with set_prefix(mi) and clear
it at the end with clear_prefix().

Add the calls to multi_process_incoming_dco() in a similar way to
what is done for multi_process_incoming_link() - handling "link
events" and "dco events" the same, with correct prefix in the
function and no leftover prefix afterwards.

Github: closes OpenVPN/openvpn#799
Change-Id: I1ad5df0f6785ffe9becd9f83329a9335d1a36f24
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250911201222.25382-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
859.html
URL: https://gerrit.openvpn.net/c/openvpn/+/1116
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
1 file changed, 2 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/1116/4

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 7db4eda..6e4cc42 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3294,6 +3294,7 @@
     if ((peer_id < m->max_clients) && (m->instances[peer_id]))
     {
         mi =3D m->instances[peer_id];
+        set_prefix(mi);
         if (dco->dco_message_type =3D=3D OVPN_CMD_DEL_PEER)
         {
             process_incoming_del_peer(m, mi, dco);
@@ -3311,6 +3312,7 @@
         {
             tls_session_soft_reset(mi->context.c2.tls_multi);
         }
+        clear_prefix();
     }
     else
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1116?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1ad5df0f6785ffe9becd9f83329a9335d1a36f24
Gerrit-Change-Number: 1116
Gerrit-PatchSet: 4
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--1MvoM4YTBW8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by ordex.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1116=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco: add standard mi prefix handling to multi_proces=
s_incoming_dco()<br><br>Our code generally expects functions that deal with=
 a multi instance<br>to set up a log prefix at the beginning with set_prefi=
x(mi) and clear<br>it at the end with clear_prefix().<br><br>Add the calls =
to multi_process_incoming_dco() in a similar way to<br>what is done for mul=
ti_process_incoming_link() - handling &quot;link<br>events&quot; and &quot;=
dco events&quot; the same, with correct prefix in the<br>function and no le=
ftover prefix afterwards.<br><br>Github: closes OpenVPN/openvpn#799<br>Chan=
ge-Id: I1ad5df0f6785ffe9becd9f83329a9335d1a36f24<br>Signed-off-by: Antonio =
Quartulli &lt;antonio@...2726...&gt;<br>Signed-off-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Messa=
ge-Id: &lt;20250911201222.25382-1-gert@...1296...&gt;<br>URL: https://www.m=
ail-archive.com/openvpn-devel@lists.sourceforge.net/msg32859.html<br>URL: h=
ttps://gerrit.openvpn.net/c/openvpn/+/1116<br>Signed-off-by: Gert Doering &=
lt;gert@...1296...&gt;<br>---<br>M src/openvpn/multi.c<br>1 file changed, 2=
 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/16/1116/4</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=
.c b/src/openvpn/multi.c</span><br><span>index 7db4eda..6e4cc42 100644</spa=
n><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/mul=
ti.c</span><br><span>@@ -3294,6 +3294,7 @@</span><br><span>     if ((peer_i=
d &lt; m-&gt;max_clients) &amp;&amp; (m-&gt;instances[peer_id]))</span><br>=
<span>     {</span><br><span>         mi =3D m-&gt;instances[peer_id];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        set_prefix(mi);<=
/span><br><span>         if (dco-&gt;dco_message_type =3D=3D OVPN_CMD_DEL_P=
EER)</span><br><span>         {</span><br><span>             process_incomi=
ng_del_peer(m, mi, dco);</span><br><span>@@ -3311,6 +3312,7 @@</span><br><s=
pan>         {</span><br><span>             tls_session_soft_reset(mi-&gt;c=
ontext.c2.tls_multi);</span><br><span>         }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        clear_prefix();</span><br><span>     }=
</span><br><span>     else</span><br><span>     {</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1116?usp=3Demail">change 1116</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1116?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1ad5df0f6785ffe9becd9f83329=
a9335d1a36f24 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1116 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--1MvoM4YTBW8=--

