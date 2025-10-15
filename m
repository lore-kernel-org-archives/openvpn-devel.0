From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Wed, 15 Oct 2025 07:25:26 +0000
References: <gerrit.1760513121000.I53dd40fabdeacb9dca843e28fdd3b357711c5a84@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <11ff4f4bf16ddc43aadead1650f215c82a5884be-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7oq4K9MX4j0="; charset=UTF-8
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

--7oq4K9MX4j0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1275?usp=3Demail

to review the following change.


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
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/1275/1

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index b9f6bc7..5791257 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -621,8 +621,8 @@
             {
                 const nvlist_t *bytes =3D nvlist_get_nvlist(nvl, "bytes");

-                dco->dco_read_bytes =3D nvlist_get_number(bytes, "in");
-                dco->dco_write_bytes =3D nvlist_get_number(bytes, "out");
+                dco->c->c2.dco_read_bytes =3D nvlist_get_number(bytes, "in=
");
+                dco->c->c2.dco_write_bytes =3D nvlist_get_number(bytes, "o=
ut");
             }

             dco->dco_message_type =3D OVPN_CMD_DEL_PEER;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1275?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I53dd40fabdeacb9dca843e28fdd3b357711c5a84
Gerrit-Change-Number: 1275
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--7oq4K9MX4j0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1275?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dco-freebsd: store peer stats directly in c=
2<br><br>The dco_context_t structure includes a reference to the general co=
ntext<br>structure c, which allows us to store dco_read_bytes and dco_write=
_bytes<br>directly as c2 fields. This aligns the FreeBSD implementation wit=
h how<br>we handle DCO peer stats on Linux and Windows.<br><br>Change-Id: I=
53dd40fabdeacb9dca843e28fdd3b357711c5a84<br>Signed-off-by: Ralf Lici &lt;ra=
lf@...2726...&gt;<br>---<br>M src/openvpn/dco_freebsd.c<br>1 file changed, =
2 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/75/1275/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>inde=
x b9f6bc7..5791257 100644</span><br><span>--- a/src/openvpn/dco_freebsd.c</=
span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -621,8 +6=
21,8 @@</span><br><span>             {</span><br><span>                 con=
st nvlist_t *bytes =3D nvlist_get_nvlist(nvl, &quot;bytes&quot;);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   dco-&gt;dco_read_bytes =3D nvlist_get_number(bytes, &quot;in&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                dco-&gt;d=
co_write_bytes =3D nvlist_get_number(bytes, &quot;out&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                dco-&gt;c-&gt;c2.=
dco_read_bytes =3D nvlist_get_number(bytes, &quot;in&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                dco-&gt;c-&gt;c2.d=
co_write_bytes =3D nvlist_get_number(bytes, &quot;out&quot;);</span><br><sp=
an>             }</span><br><span> </span><br><span>             dco-&gt;dc=
o_message_type =3D OVPN_CMD_DEL_PEER;</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1275?usp=3De=
mail">change 1275</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1275?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53dd40fabdeacb9dca843e28fdd=
3b357711c5a84 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1275 </div>
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

--7oq4K9MX4j0=--

