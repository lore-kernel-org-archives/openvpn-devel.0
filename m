From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Sun, 19 Oct 2025 08:36:58 +0000
In-Reply-To: <gerrit.1760513121000.I53dd40fabdeacb9dca843e28fdd3b357711c5a84@...2715...>
References: <gerrit.1760513121000.I53dd40fabdeacb9dca843e28fdd3b357711c5a84@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726..., gert@...1296...
Message-ID: <621cc5c4e16fba7674ba0ac7100d4ca125fd3050-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0qZUHFHyK9c="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco-freebsd: store
 peer stats directly in c2
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

--0qZUHFHyK9c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, ralf_=
lici.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1275?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: dco-freebsd: store peer stats directly in c2
......................................................................

dco-freebsd: store peer stats directly in c2

The dco_context_t structure includes a reference to the general context
structure c, which allows us to store dco_read_bytes and dco_write_bytes
directly as c2 fields. This aligns the FreeBSD implementation with how
we handle DCO peer stats on Linux and Windows.

Change-Id: I53dd40fabdeacb9dca843e28fdd3b357711c5a84
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/dco_freebsd.c
1 file changed, 1 insertion(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/1275/3

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 947a769..056430b 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -619,10 +619,7 @@

             if (nvlist_exists_nvlist(nvl, "bytes"))
             {
-                const nvlist_t *bytes =3D nvlist_get_nvlist(nvl, "bytes");
-
-                dco->dco_read_bytes =3D nvlist_get_number(bytes, "in");
-                dco->dco_write_bytes =3D nvlist_get_number(bytes, "out");
+                dco_update_peer_stat(dco->c->multi, dco->dco_message_peer_=
id, nvlist_get_nvlist(nvl, "bytes"));
             }

             dco->dco_message_type =3D OVPN_CMD_DEL_PEER;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1275?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I53dd40fabdeacb9dca843e28fdd3b357711c5a84
Gerrit-Change-Number: 1275
Gerrit-PatchSet: 3
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ralf_lici <ralf@...2726...>

--0qZUHFHyK9c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos, ralf_lici. </p>
<p>ralf_lici <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1275?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">dco-freebsd: store peer stats direc=
tly in c2<br><br>The dco_context_t structure includes a reference to the ge=
neral context<br>structure c, which allows us to store dco_read_bytes and d=
co_write_bytes<br>directly as c2 fields. This aligns the FreeBSD implementa=
tion with how<br>we handle DCO peer stats on Linux and Windows.<br><br>Chan=
ge-Id: I53dd40fabdeacb9dca843e28fdd3b357711c5a84<br>Signed-off-by: Ralf Lic=
i &lt;ralf@...2726...&gt;<br>---<br>M src/openvpn/dco_freebsd.c<br>1 file c=
hanged, 1 insertion(+), 4 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/1275/3</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><sp=
an>index 947a769..056430b 100644</span><br><span>--- a/src/openvpn/dco_free=
bsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -6=
19,10 +619,7 @@</span><br><span> </span><br><span>             if (nvlist_e=
xists_nvlist(nvl, &quot;bytes&quot;))</span><br><span>             {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                const nvlist=
_t *bytes =3D nvlist_get_nvlist(nvl, &quot;bytes&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                dco-&gt;dco_read_bytes =3D nvlist_get_number(=
bytes, &quot;in&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                dco-&gt;dco_write_bytes =3D nvlist_get_number(bytes, &quo=
t;out&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          dco_update_peer_stat(dco-&gt;c-&gt;multi, dco-&gt;dco_message_pee=
r_id, nvlist_get_nvlist(nvl, &quot;bytes&quot;));</span><br><span>         =
    }</span><br><span> </span><br><span>             dco-&gt;dco_message_ty=
pe =3D OVPN_CMD_DEL_PEER;</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1275?usp=3Demail">change=
 1275</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1275?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53dd40fabdeacb9dca843e28fdd=
3b357711c5a84 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1275 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>

</body></html>=

--0qZUHFHyK9c=--

