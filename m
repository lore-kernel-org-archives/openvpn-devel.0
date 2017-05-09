MIME-Version: 1.0
In-Reply-To: <1494355368-20238-1-git-send-email-steffan.karger@...1435...>
References: <1664a9e5-12f1-116f-5515-deec2d8392dc@...1856...>
	<1494355368-20238-1-git-send-email-steffan.karger@...1435...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 9 May 2017 15:58:06 -0400
Message-ID: <CAKuzo_gDM-kwboDCy2BwMLynb-RMm5i+COWqTcq1JLg7nH7CwQ@...278...>
Content-Type: multipart/alternative; boundary=001a113a40846f03de054f1cc707
Subject: Re: [Openvpn-devel] [PATCH v2] Document tls-crypt security
 considerations in man page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113a40846f03de054f1cc707
Content-Type: text/plain; charset=UTF-8

Hi,

Looks good except for some typos:

On Tue, May 9, 2017 at 2:42 PM, Steffan Karger <steffan.karger@...1435...>
wrote:

> The tls-crypt commit message contained an elaborate discussion on the
> function's security properties.  This commit adds the gist of that
> discussion, "rotate keys periodically" to the man page.
>
> (The 'real' solution will follow later: add support for per-client
> tls-crypt keys.  That will make tls-crypt useful for VPN providers too.)
>
> Note to non-crypto-geek reviewers: please verify that this text is clear
> enough to explain you when you need to replace tls-crypt keys.
>
> Note to crypto-geek reviewers: please check the numbers - see the
> --tls-crypt commit message (c6e24fa3) for details.
>
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
> v2: clarify that 2^16 packets is a conservative estimate, use plural
> year*s*
>
>  doc/openvpn.8 | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index c3248fd..06f8c66 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -5090,6 +5090,29 @@ In contrast to
>  .B \-\-tls\-crypt
>  does *not* require the user to set
>  .B \-\-key\-direction\fR.
> +
> +.B Security Considerations
> +
> +All peers use the same
> +.B \-\-tls-crypt
> +pre-shared group key to authenticate and encrypt control channel
> messages.  To
> +ensure that IV collisions remain unlikely, this key should not be used to
> +encrypt more than 2^48 client-to-server or 2^48 server-to-client control
>
+channel messages.  A typical initial negotiation is about 10 packets in
> each
> +direction.  Assuming both initial negotation and renogatiations are at
> most
>

"negotiation", "renegotiations"


> +2^16 (65536) packets (too be conservative), and (re)negotiations happen
> each
>

"to" instead of "too"


> +minute for each user (24/7), this limits the tls\-crypt key lifetime to
> 8171
> +years divided by the number of users.  So a setup with 1000 users should
> rotate
> +the key at least once each eight years.  (And a setup with 8000 users each
> +year.)
> +
> +If IV collisions were to occur, this could result in the security of
> +.B \-\-tls\-crypt
> +degrading to the same security as using
> +.B \-\-tls\-auth\fR.
> +That is, the control channel still benefits from the extra protection
> against
> +active man-in-the-middle-attacks and DoS attacks, but may no longer offer
> +extra privacy and post-quantum security on top of what TLS itself offers.
>  .\"*********************************************************
>  .TP
>  .B \-\-askpass [file]
>

Reads well otherwise. So ACK assuming typos will be fixed :)

Selva

--001a113a40846f03de054f1cc707
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br></div>Looks good except for some typos:<br=
><div><div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">O=
n Tue, May 9, 2017 at 2:42 PM, Steffan Karger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:steffan.karger@...1435..." target=3D"_blank">steffan.karger@...1386...=
435...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"">The tls-crypt commit message contained an elaborate discussion on the=
<br>
function&#39;s security properties.=C2=A0 This commit adds the gist of that=
<br>
discussion, &quot;rotate keys periodically&quot; to the man page.<br>
<br>
(The &#39;real&#39; solution will follow later: add support for per-client<=
br>
tls-crypt keys.=C2=A0 That will make tls-crypt useful for VPN providers too=
.)<br>
<br>
</span><span class=3D"">Note to non-crypto-geek reviewers: please verify th=
at this text is clear<br>
enough to explain you when you need to replace tls-crypt keys.<br>
<br>
Note to crypto-geek reviewers: please check the numbers - see the<br>
--tls-crypt commit message (c6e24fa3) for details.<br>
<br>
Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan.karger@...2191...=
..">steffan.karger@...1435...</a>&gt;<br>
---<br>
</span>v2: clarify that 2^16 packets is a conservative estimate, use plural=
 year*s*<br>
<br>
=C2=A0doc/openvpn.8 | 23 +++++++++++++++++++++++<br>
=C2=A01 file changed, 23 insertions(+)<br>
<br>
diff --git a/doc/openvpn.8 b/doc/openvpn.8<br>
index c3248fd..06f8c66 100644<br>
--- a/doc/openvpn.8<br>
+++ b/doc/openvpn.8<br>
@@ -5090,6 +5090,29 @@ In contrast to<br>
<span class=3D"">=C2=A0.B \-\-tls\-crypt<br>
=C2=A0does *not* require the user to set<br>
=C2=A0.B \-\-key\-direction\fR.<br>
+<br>
+.B Security Considerations<br>
+<br>
+All peers use the same<br>
+.B \-\-tls-crypt<br>
</span>+pre-shared group key to authenticate and encrypt control channel me=
ssages.=C2=A0 To<br>
+ensure that IV collisions remain unlikely, this key should not be used to<=
br>
+encrypt more than 2^48 client-to-server or 2^48 server-to-client control <=
br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
+channel messages.=C2=A0 A typical initial negotiation is about 10 packets =
in each<br>
+direction.=C2=A0 Assuming both initial negotation and renogatiations are a=
t most<br></blockquote><div><br></div><div>&quot;negotiation&quot;, &quot;r=
enegotiations&quot;<br>=C2=A0=C2=A0 <br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
+2^16 (65536) packets (too be conservative), and (re)negotiations happen ea=
ch<br></blockquote><div><br></div><div>&quot;to&quot; instead of &quot;too&=
quot;<br>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+minute for each user (24/7), this limits the tls\-crypt key lifetime to 81=
71<br>
+years divided by the number of users.=C2=A0 So a setup with 1000 users sho=
uld rotate<br>
+the key at least once each eight years.=C2=A0 (And a setup with 8000 users=
 each<br>
+year.)<br>
<span class=3D"im HOEnZb">+<br>
+If IV collisions were to occur, this could result in the security of<br>
+.B \-\-tls\-crypt<br>
+degrading to the same security as using<br>
+.B \-\-tls\-auth\fR.<br>
+That is, the control channel still benefits from the extra protection agai=
nst<br>
+active man-in-the-middle-attacks and DoS attacks, but may no longer offer<=
br>
+extra privacy and post-quantum security on top of what TLS itself offers.<=
br>
=C2=A0.\&quot;***************************<wbr>*****************************=
*<br>
=C2=A0.TP<br>
=C2=A0.B \-\-askpass [file]</span><br></blockquote><div><br></div><div>Read=
s well otherwise. So ACK assuming typos will be fixed :)<br><br></div><div>=
Selva<br></div><div><br>=C2=A0<br></div></div></div></div></div></div></div>

--001a113a40846f03de054f1cc707--

