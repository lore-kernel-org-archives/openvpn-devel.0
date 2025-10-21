From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Tue, 21 Oct 2025 08:09:24 +0000
References: <gerrit.1761034162000.I92b5f3996f2a2180fa5e94719603078c1fc2f7f6@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a42101299ca9bfeeb5a434de8d125b9cf2890b23-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mJ9C+bGS9jU="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mJ9C+bGS9jU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1290?usp=3Demail

to review the following change.


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
---
M src/openvpn/dco_freebsd.c
1 file changed, 11 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/1290/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I92b5f3996f2a2180fa5e94719603078c1fc2f7f6
Gerrit-Change-Number: 1290
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--mJ9C+bGS9jU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1290?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dco-freebsd: fix peer stats storage on clie=
nt instances<br><br>Commit bf01a96 introduced a bug in the dco-freebsd path=
 by attempting to<br>store peer statistics in a structure that only exists =
on server<br>instances. This leads to a SIGSEGV on non-server instances due=
 to a NULL<br>multi_context pointer.<br><br>Resolve this by checking what m=
ode the current instance is running in<br>and storing peer stats accordingl=
y.<br><br>Fixes: https://github.com/OpenVPN/openvpn/issues/875<br>Change-Id=
: I92b5f3996f2a2180fa5e94719603078c1fc2f7f6<br>Signed-off-by: Ralf Lici &lt=
;ralf@...2726...&gt;<br>---<br>M src/openvpn/dco_freebsd.c<br>1 file change=
d, 11 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/90/1290/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><span=
>index e51f8dd..3521fca 100644</span><br><span>--- a/src/openvpn/dco_freebs=
d.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -634=
,7 +634,17 @@</span><br><span> </span><br><span>             if (nvlist_exi=
sts_nvlist(nvl, &quot;bytes&quot;))</span><br><span>             {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                dco_update_pee=
r_stat(dco-&gt;c-&gt;multi, dco-&gt;dco_message_peer_id, nvlist_get_nvlist(=
nvl, &quot;bytes&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                const nvlist_t *bytes =3D nvlist_get_nvlist(nvl, &quo=
t;bytes&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (dco=
-&gt;c-&gt;mode =3D=3D CM_TOP)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    dco_update_peer_stat(dco-&gt;c-&gt;multi, dco-=
&gt;dco_message_peer_id, bytes);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    dco-&gt;c-&gt;c2.dco_read_bytes =3D nvlist_ge=
t_number(bytes, &quot;in&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    dco-&gt;c-&gt;c2.dco_write_bytes =3D nvlis=
t_get_number(bytes, &quot;out&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                }</span><br><span>             }</span><b=
r><span> </span><br><span>             dco-&gt;dco_message_type =3D OVPN_CM=
D_DEL_PEER;</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1290?usp=3Demail">change 1290</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1290?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I92b5f3996f2a2180fa5e9471960=
3078c1fc2f7f6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1290 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--mJ9C+bGS9jU=--

