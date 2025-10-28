From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 11:46:22 +0000
In-Reply-To: <gerrit.1761034162000.I92b5f3996f2a2180fa5e94719603078c1fc2f7f6@...2715...>
References: <gerrit.1761034162000.I92b5f3996f2a2180fa5e94719603078c1fc2f7f6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <9a7cfa2a8dd4e4d9d9329d6c2116eb646fb5c0b0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Qh5eOiwJPp0="; charset=UTF-8
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
To: ralf_lici <ralf@...2726...>
Cc: mrbff <marco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Qh5eOiwJPp0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
90?usp=3Demail )

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

Gerrit-MessageType: merged
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

--Qh5eOiwJPp0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1290?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">dco-freebsd: fix peer stats storage on client in=
stances<br><br>Commit bf01a96 introduced a bug in the dco-freebsd path by a=
ttempting to<br>store peer statistics in a structure that only exists on se=
rver<br>instances. This leads to a SIGSEGV on non-server instances due to a=
 NULL<br>multi_context pointer.<br><br>Resolve this by checking what mode t=
he current instance is running in<br>and storing peer stats accordingly.<br=
><br>Fixes: https://github.com/OpenVPN/openvpn/issues/875<br>Change-Id: I92=
b5f3996f2a2180fa5e94719603078c1fc2f7f6<br>Signed-off-by: Ralf Lici &lt;ralf=
@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit=
 URL: https://gerrit.openvpn.net/c/openvpn/+/1290<br>Message-Id: &lt;202510=
28113310.19921-1-gert@...1296...&gt;<br>Signed-off-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>---<br>M src/openvpn/dco_freebsd.c<br>1 file changed, 1=
1 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span=
><br><span>index e51f8dd..3521fca 100644</span><br><span>--- a/src/openvpn/=
dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><sp=
an>@@ -634,7 +634,17 @@</span><br><span> </span><br><span>             if (=
nvlist_exists_nvlist(nvl, &quot;bytes&quot;))</span><br><span>             =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                dco_=
update_peer_stat(dco-&gt;c-&gt;multi, dco-&gt;dco_message_peer_id, nvlist_g=
et_nvlist(nvl, &quot;bytes&quot;));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                const nvlist_t *bytes =3D nvlist_get_nvlist=
(nvl, &quot;bytes&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   if (dco-&gt;c-&gt;mode =3D=3D CM_TOP)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    dco_update_peer_stat(dco-&gt;c-&gt;m=
ulti, dco-&gt;dco_message_peer_id, bytes);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                else</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    dco-&gt;c-&gt;c2.dco_read_bytes =3D=
 nvlist_get_number(bytes, &quot;in&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    dco-&gt;c-&gt;c2.dco_write_bytes=
 =3D nvlist_get_number(bytes, &quot;out&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                }</span><br><span>             =
}</span><br><span> </span><br><span>             dco-&gt;dco_message_type =
=3D OVPN_CMD_DEL_PEER;</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1290?usp=3Demail">change 12=
90</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1290?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--Qh5eOiwJPp0=--

