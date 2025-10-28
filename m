From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 11:46:18 +0000
In-Reply-To: <gerrit.1761034162000.I92b5f3996f2a2180fa5e94719603078c1fc2f7f6@...2715...>
References: <gerrit.1761034162000.I92b5f3996f2a2180fa5e94719603078c1fc2f7f6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <9a7cfa2a8dd4e4d9d9329d6c2116eb646fb5c0b0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RC1a2L2Vl9U="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco-freebsd: fix
 peer stats storage on client instances
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, mrbff <marco@...2726...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RC1a2L2Vl9U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 ralf_lici. ( http://gerrit.openvpn.net/c/openvpn/+/1290?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+1 by mrbff, Code-Review+2 by cron2


Change subject: dco-freebsd: fix peer stats storage on client instances
......................................................................

dco-freebsd: fix peer stats storage on client instances

Commit bf01a96 introduced a bug in the dco-freebsd path by attempting to
store peer statistics in a structure that only exists on server
instances. This leads to a SIGSEGV on non-server instances due to a NULL
multi_context pointer.

Resolve this by checking what mode the current instance is running in
and storing peer stats accordingly.

Fixes: https://github.com/OpenVPN/openvpn/issues/875
Change-Id: I92b5f3996f2a2180fa5e94719603078c1fc2f7f6
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1290
Message-Id: <20251028113310.19921-1-gert@...1296...>
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.c
1 file changed, 11 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/1290/2

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index e51f8dd..3521fca 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -634,7 +634,17 @@

             if (nvlist_exists_nvlist(nvl, "bytes"))
             {
-                dco_update_peer_stat(dco->c->multi, dco->dco_message_peer_=
id, nvlist_get_nvlist(nvl, "bytes"));
+                const nvlist_t *bytes =3D nvlist_get_nvlist(nvl, "bytes");
+
+                if (dco->c->mode =3D=3D CM_TOP)
+                {
+                    dco_update_peer_stat(dco->c->multi, dco->dco_message_p=
eer_id, bytes);
+                }
+                else
+                {
+                    dco->c->c2.dco_read_bytes =3D nvlist_get_number(bytes,=
 "in");
+                    dco->c->c2.dco_write_bytes =3D nvlist_get_number(bytes=
, "out");
+                }
             }

             dco->dco_message_type =3D OVPN_CMD_DEL_PEER;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1290?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I92b5f3996f2a2180fa5e94719603078c1fc2f7f6
Gerrit-Change-Number: 1290
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: mrbff <marco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RC1a2L2Vl9U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by ralf_lici.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1290?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+1 by mrbff, Code-Review+2 by cron2</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">dco-freebsd=
: fix peer stats storage on client instances<br><br>Commit bf01a96 introduc=
ed a bug in the dco-freebsd path by attempting to<br>store peer statistics =
in a structure that only exists on server<br>instances. This leads to a SIG=
SEGV on non-server instances due to a NULL<br>multi_context pointer.<br><br=
>Resolve this by checking what mode the current instance is running in<br>a=
nd storing peer stats accordingly.<br><br>Fixes: https://github.com/OpenVPN=
/openvpn/issues/875<br>Change-Id: I92b5f3996f2a2180fa5e94719603078c1fc2f7f6=
<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>Acked-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/ope=
nvpn/+/1290<br>Message-Id: &lt;20251028113310.19921-1-gert@...1296...&gt;<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openv=
pn/dco_freebsd.c<br>1 file changed, 11 insertions(+), 1 deletion(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/90/1290/2</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvp=
n/dco_freebsd.c</span><br><span>index e51f8dd..3521fca 100644</span><br><sp=
an>--- a/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_fr=
eebsd.c</span><br><span>@@ -634,7 +634,17 @@</span><br><span> </span><br><s=
pan>             if (nvlist_exists_nvlist(nvl, &quot;bytes&quot;))</span><b=
r><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                dco_update_peer_stat(dco-&gt;c-&gt;multi, dco-&gt;dco_mess=
age_peer_id, nvlist_get_nvlist(nvl, &quot;bytes&quot;));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                const nvlist_t *bytes =
=3D nvlist_get_nvlist(nvl, &quot;bytes&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                if (dco-&gt;c-&gt;mode =3D=3D CM_TOP)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    dco_update_peer=
_stat(dco-&gt;c-&gt;multi, dco-&gt;dco_message_peer_id, bytes);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    dco-&gt;c-&gt;=
c2.dco_read_bytes =3D nvlist_get_number(bytes, &quot;in&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    dco-&gt;c-&=
gt;c2.dco_write_bytes =3D nvlist_get_number(bytes, &quot;out&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><b=
r><span>             }</span><br><span> </span><br><span>             dco-&=
gt;dco_message_type =3D OVPN_CMD_DEL_PEER;</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1290?us=
p=3Demail">change 1290</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1290?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I92b5f3996f2a2180fa5e9471960=
3078c1fc2f7f6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1290 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: mrbff &lt;marco@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--RC1a2L2Vl9U=--

