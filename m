MIME-Version: 1.0
In-Reply-To: <20180401063058.23913-1-gert@...1296...>
References: <20180401063058.23913-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 1 Apr 2018 10:19:37 -0400
Message-ID: <CAKuzo_gRyd++KVmH=iGALbz0kjPiXLhK6DkAGA0Uu0mcV6RG8A@...278...>
Content-Type: multipart/alternative; boundary="0000000000000736b80568ca2b9d"
Subject: Re: [Openvpn-devel] [PATCH] Depreciate IPv4-related options.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000000736b80568ca2b9d
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, Apr 1, 2018 at 2:30 AM, Gert Doering <gert@...1296...> wrote:

> As discussed in trac #208 and on IRC with Antonio, OpenVPN 2.5 will
> be IPv6-only.  Removal of IPv4-related code and options will dramatically
> reduce code complexity, confusing options, bugs and user questions.
>
> Add deprecation warnings for IPv4-related config options to 2.4 branch,
> so users have enough time to move their setups to work on IPv6-only
> before 2.5 will be released.
>
> This affects:
>
>   --ifconfig
>   --route
>   --server
>   --proto udp4/tcp4
>   --ifconfig-pool
>
> More IPv4-related options will be identified and depreciated later.
>

Nice try :)

Selva

--0000000000000736b80568ca2b9d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Sun, Apr 1, 2018 at 2:30 AM, Gert Doering <span dir=3D"ltr">&lt;<=
a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">As discussed in trac #208 =
and on IRC with Antonio, OpenVPN 2.5 will<br>
be IPv6-only.=C2=A0 Removal of IPv4-related code and options will dramatica=
lly<br>
reduce code complexity, confusing options, bugs and user questions.<br>
<br>
Add deprecation warnings for IPv4-related config options to 2.4 branch,<br>
so users have enough time to move their setups to work on IPv6-only<br>
before 2.5 will be released.<br>
<br>
This affects:<br>
<br>
=C2=A0 --ifconfig<br>
=C2=A0 --route<br>
=C2=A0 --server<br>
=C2=A0 --proto udp4/tcp4<br>
=C2=A0 --ifconfig-pool<br>
<br>
More IPv4-related options will be identified and depreciated later.<br></bl=
ockquote><div><br></div><div>Nice try :)</div><div><br></div><div>Selva</di=
v></div></div></div>

--0000000000000736b80568ca2b9d--

