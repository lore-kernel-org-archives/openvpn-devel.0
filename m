MIME-Version: 1.0
In-Reply-To: <1468495519-25102-1-git-send-email-arne@...1227...>
References: <1468495519-25102-1-git-send-email-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 14 Jul 2016 11:39:28 -0400
Message-ID: <CAKuzo_jYOzokoNhQn9cc+ma60MFbpe8_tSeXmeoGNK7jsMEQZA@...278...>
Content-Type: multipart/alternative; boundary=001a1149e926d8878105379a4f49
Subject: Re: [Openvpn-devel] [PATCH] Incorporate the Debian typo fixes where
 appropriate and make show_opt default message clearer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1149e926d8878105379a4f49
Content-Type: text/plain; charset=UTF-8

On Thu, Jul 14, 2016 at 7:25 AM, Arne Schwabe <arne@...1227...> wrote:

> @@ -5487,7 +5487,7 @@ virtual DHCP server address.  In
>  .B \-\-dev tun
>  mode, OpenVPN will cause the DHCP server to masquerade as if it were
>  coming from the remote endpoint.  The optional offset parameter is
> -an integer which is > -256 and < 256 and which defaults to 0.
> +an integer which is > \-256 and < 256 and which defaults to 0.
>

Not a fault of this patch, but may be its time to make this info right.
Currently the default offset in --dev tun mode is not 0, but -1. Thus the
ip (broadcast - 1) is removed from the pool. Unlike what the man page and
comments in helper.c implies.

I think its better to bring the source in line with the docs as suggested
in this patch: http://article.gmane.org/gmane.network.openvpn.devel/10687

Selva

--001a1149e926d8878105379a4f49
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Jul 14, 2016 at 7:25 AM, Arne Schwabe <span dir=3D"ltr">&lt;<a href=
=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex"><div>@@ -5487,7 +5487,7 @@ virtual DHCP server=
 address.=C2=A0 In<br>
=C2=A0.B \-\-dev tun<br>
=C2=A0mode, OpenVPN will cause the DHCP server to masquerade as if it were<=
br>
=C2=A0coming from the remote endpoint.=C2=A0 The optional offset parameter =
is<br>
-an integer which is &gt; -256 and &lt; 256 and which defaults to 0.<br>
+an integer which is &gt; \-256 and &lt; 256 and which defaults to 0.</div>=
</blockquote></div><br>Not a fault of this patch, but may be its time to ma=
ke this info right. Currently the default offset in --dev tun mode is not 0=
, but -1. Thus the ip (broadcast - 1) is removed from the pool. Unlike what=
 the man page and comments in helper.c implies.</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">I think its better to bring the s=
ource in line with the docs as suggested in this patch:=C2=A0<a href=3D"htt=
p://article.gmane.org/gmane.network.openvpn.devel/10687" target=3D"_blank">=
http://article.gmane.org/gmane.network.openvpn.devel/10687</a></div><div cl=
ass=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div></div>

--001a1149e926d8878105379a4f49--

