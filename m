From: Kristof Provost <kprovost@...2661...>
Date: Thu, 16 Oct 2025 18:02:21 +0200
Message-ID: <A49904D6-D9EF-415D-94CA-A163229541DF@...2661...>
In-Reply-To: <11ff4f4bf16ddc43aadead1650f215c82a5884be-HTML@...2715...>
References: <gerrit.1760513121000.I53dd40fabdeacb9dca843e28fdd3b357711c5a84@...2715...>
 <11ff4f4bf16ddc43aadead1650f215c82a5884be-HTML@...2715...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_MailMate_C85ED817-7034-471C-880D-72D5B2456B10_="
Content-Transfer-Encoding: 8bit
Subject: Re: [Openvpn-devel] [XS] Change in openvpn[master]: dco-freebsd:
 store peer stats directly in c2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf@...2726..., plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, flichtenheld <frank@...2641...>

--=_MailMate_C85ED817-7034-471C-880D-72D5B2456B10_=
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

LGTM.

—
Kristof

On 15 Oct 2025, at 9:25, ralf_lici (Code Review) wrote:

> Attention is currently required from: flichtenheld, plaisthos.
>
> Hello plaisthos, flichtenheld,
>
> I'd like you to do a code review.
> Please visit
>
>   http://gerrit.openvpn.net/c/openvpn/+/1275?usp=email
>
> to review the following change.
>
>
> Change subject: dco-freebsd: store peer stats directly in c2
> ......................................................................
>
> dco-freebsd: store peer stats directly in c2
>
> The dco_context_t structure includes a reference to the general 
> context
> structure c, which allows us to store dco_read_bytes and 
> dco_write_bytes
> directly as c2 fields. This aligns the FreeBSD implementation with how
> we handle DCO peer stats on Linux and Windows.
>
> Change-Id: I53dd40fabdeacb9dca843e28fdd3b357711c5a84
> Signed-off-by: Ralf Lici <ralf@...2726...>
> ---
> M src/openvpn/dco_freebsd.c
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>
>
>   git pull ssh://gerrit.openvpn.net:29418/openvpn 
> refs/changes/75/1275/1
>
> diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
> index b9f6bc7..5791257 100644
> --- a/src/openvpn/dco_freebsd.c
> +++ b/src/openvpn/dco_freebsd.c
> @@ -621,8 +621,8 @@
>              {
>                  const nvlist_t *bytes = nvlist_get_nvlist(nvl, 
> "bytes");
>
> -                dco->dco_read_bytes = nvlist_get_number(bytes, "in");
> -                dco->dco_write_bytes = nvlist_get_number(bytes, 
> "out");
> +                dco->c->c2.dco_read_bytes = nvlist_get_number(bytes, 
> "in");
> +                dco->c->c2.dco_write_bytes = nvlist_get_number(bytes, 
> "out");
>              }
>
>              dco->dco_message_type = OVPN_CMD_DEL_PEER;
>
> -- 
> To view, visit http://gerrit.openvpn.net/c/openvpn/+/1275?usp=email
> To unsubscribe, or for help writing mail filters, visit 
> http://gerrit.openvpn.net/settings?usp=email
>
> Gerrit-MessageType: newchange
> Gerrit-Project: openvpn
> Gerrit-Branch: master
> Gerrit-Change-Id: I53dd40fabdeacb9dca843e28fdd3b357711c5a84
> Gerrit-Change-Number: 1275
> Gerrit-PatchSet: 1
> Gerrit-Owner: ralf_lici <ralf@...2726...>
> Gerrit-Reviewer: flichtenheld <frank@...2641...>
> Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
> Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
> Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
> Gerrit-Attention: flichtenheld <frank@...2641...>

> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--=_MailMate_C85ED817-7034-471C-880D-72D5B2456B10_=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/xhtml; charset=3Dutf-8">
</head>
<body><div style=3D"font-family: sans-serif;"><div class=3D"plaintext" styl=
e=3D"white-space: normal;"><p dir=3D"auto">LGTM.</p>
<p dir=3D"auto">=E2=80=94
<br>
Kristof</p>
<p dir=3D"auto">On 15 Oct 2025, at 9:25, ralf_lici (Code Review) wrote:</p>
</div><blockquote class=3D"embedded" style=3D"margin: 0 0 5px; padding-left=
: 5px; border-left: 2px solid #136BCE; color: #136BCE;"><div id=3D"541646E0=
-7658-42D8-AE11-CDB48B12BD40">

<p>Attention is currently required from: flichtenheld, plaisthos.</p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.</p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1275?usp=3Demail">View =
Change</a></p>
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dco-freebsd: store peer stats directly in c2<br><br>The dco_c=
ontext_t structure includes a reference to the general context<br>structure=
 c, which allows us to store dco_read_bytes and dco_write_bytes<br>directly=
 as c2 fields. This aligns the FreeBSD implementation with how<br>we handle=
 DCO peer stats on Linux and Windows.<br><br>Change-Id: I53dd40fabdeacb9dca=
843e28fdd3b357711c5a84<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<=
br>---<br>M src/openvpn/dco_freebsd.c<br>1 file changed, 2 insertions(+), 2=
 deletions(-)<br><br></pre>
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
75/1275/1</pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span=
><br><span>index b9f6bc7..5791257 100644</span><br><span>--- a/src/openvpn/=
dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><sp=
an>@@ -621,8 +621,8 @@</span><br><span>             {</span><br><span>     =
            const nvlist_t *bytes =3D nvlist_get_nvlist(nvl, "bytes");</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        dco-&gt;dco_read_bytes =3D nvlist_get_number(bytes, "in");</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                dco-&gt;dco_wr=
ite_bytes =3D nvlist_get_number(bytes, "out");</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                dco-&gt;c-&gt;c2.dco_read_bytes =
=3D nvlist_get_number(bytes, "in");</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                dco-&gt;c-&gt;c2.dco_write_bytes =3D nvlist=
_get_number(bytes, "out");</span><br><span>             }</span><br><span> =
</span><br><span>             dco-&gt;dco_message_type =3D OVPN_CMD_DEL_PEE=
R;</span><br><br></pre>
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1275?usp=
=3Demail">change 1275</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p>
<div itemscope itemtype=3D"http://schema.org/EmailMessage">
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
">
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1275?u=
sp=3Demail">
<meta itemprop=3D"name" content=3D"View Change"></div>
</div>
<div style=3D"display:none">Gerrit-MessageType: newchange</div>
<div style=3D"display:none">Gerrit-Project: openvpn</div>
<div style=3D"display:none">Gerrit-Branch: master</div>
<div style=3D"display:none">Gerrit-Change-Id: I53dd40fabdeacb9dca843e28fdd3=
b357711c5a84</div>
<div style=3D"display:none">Gerrit-Change-Number: 1275</div>
<div style=3D"display:none">Gerrit-PatchSet: 1</div>
<div style=3D"display:none">Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt;=
</div>
<div style=3D"display:none">Gerrit-Reviewer: flichtenheld &lt;frank@...2746...=
...&gt;</div>
<div style=3D"display:none">Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...493...=
1227...&gt;</div>
<div style=3D"display:none">Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1514...=
s.sourceforge.net&gt;</div>
<div style=3D"display:none">Gerrit-Attention: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt;</div>
<div style=3D"display:none">Gerrit-Attention: flichtenheld &lt;frank@...2716...=
1...&gt;</div></div></blockquote>
<div class=3D"plaintext" style=3D"white-space: normal;">
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px s=
olid #136BCE; color: #136BCE;"><p dir=3D"auto">____________________________=
___________________
<br>
Openvpn-devel mailing list
<br>
Openvpn-devel@lists.sourceforge.net
<br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel">http=
s://lists.sourceforge.net/lists/listinfo/openvpn-devel</a></p>
</blockquote></div>

</div>
</body>

</html>

--=_MailMate_C85ED817-7034-471C-880D-72D5B2456B10_=--

