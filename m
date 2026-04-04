From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sat, 4 Apr 2026 18:56:25 +0000
References: <gerrit.1775328983000.I04a01cf536ee6d48d54ba623dda460c4a98859f9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <945803bb833575e79c75471c1708678a411f1da7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pJ0ba2jDujs="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pJ0ba2jDujs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1609?usp=3Demail

to review the following change.


Change subject: mtcp: Remove noop statement in multi_tcp_process_outgoing_l=
ink_ready
......................................................................

mtcp: Remove noop statement in multi_tcp_process_outgoing_link_ready

Assigning to a parameter here has no effect. I can see no
obvious alternative statement that might have been intended.

Found by cppcheck.

Change-Id: I04a01cf536ee6d48d54ba623dda460c4a98859f9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/mtcp.c
1 file changed, 0 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/1609/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I04a01cf536ee6d48d54ba623dda460c4a98859f9
Gerrit-Change-Number: 1609
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--pJ0ba2jDujs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1609?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">mtcp: Remove noop statement in multi_tcp_pr=
ocess_outgoing_link_ready<br><br>Assigning to a parameter here has no effec=
t. I can see no<br>obvious alternative statement that might have been inten=
ded.<br><br>Found by cppcheck.<br><br>Change-Id: I04a01cf536ee6d48d54ba623d=
da460c4a98859f9<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt=
;<br>---<br>M src/openvpn/mtcp.c<br>1 file changed, 0 insertions(+), 4 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/09/1609/1</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mtcp.c b/s=
rc/openvpn/mtcp.c</span><br><span>index 2eab7b7..7651b4d 100644</span><br><=
span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</spa=
n><br><span>@@ -155,10 +155,6 @@</span><br><span>         ASSERT(mi =3D=3D =
item.instance);</span><br><span>         mi-&gt;context.c2.to_link =3D item=
.buffer-&gt;buf;</span><br><span>         ret =3D multi_process_outgoing_li=
nk_dowork(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (!ret)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   mi =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span>         mbuf_free_buf(item.buffer);</span><br><span>  =
   }</span><br><span>     return ret;</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1609?usp=3De=
mail">change 1609</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1609?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I04a01cf536ee6d48d54ba623dda=
460c4a98859f9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1609 </div>
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

--pJ0ba2jDujs=--

