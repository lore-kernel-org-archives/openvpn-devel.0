MIME-Version: 1.0
References: <1600126181-16364-1-git-send-email-selva.nair@...277...>
 <CAGyAFMUU_zfnEFseD=Ni_iSU6TLcupNdPOL7MjzzD4CaR2_7Xw@...278...>
In-Reply-To: <CAGyAFMUU_zfnEFseD=Ni_iSU6TLcupNdPOL7MjzzD4CaR2_7Xw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 15 Sep 2020 10:13:47 -0400
Message-ID: <CAKuzo_hoF3K6fsuoiEG=jhEQ=xss1XOU1jxmPvbERRzD_-q5jw@...278...>
Content-Type: multipart/alternative; boundary="000000000000b090e005af5ac3a1"
Subject: Re: [Openvpn-devel] [PATCH] Allow --dhcp-option in config file when
 windows-driver is wintun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000b090e005af5ac3a1
Content-Type: text/plain; charset="UTF-8"

Hi

On Tue, Sep 15, 2020 at 2:48 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> > -        msg(M_USAGE, "--dhcp-options requires --ip-win32 dynamic or
> adaptive");
> > +        msg(M_USAGE, "--dhcp-option requires --ip-win32 dynamic or
> adaptive");
>
> Nice, this typo has been there since at least 2005.
>
> It looks like that warning is not quite correct - for example,
> DNS can be set via iservice or netsh, which means that
>
> --ip-win32 netsh
> --dhcp-option DNS 8.8.8.8
>
> is a valid combination regardless of driver type. On the other hand,
> NBDD/NTP are set via DHCP.
>
> It would be good to make the warning condition more fine-grained, but
> this patch is good enough as it is, since it fixes important case - specify
> DNS in the ovpn profile when using wintun.
>

We could deprecate --ip-win32 as a user option. Default to dynamic or
adaptive, automatically fail-over to alternate methods or change it
internally as required for wintun etc.

And work towards supporting more dhcp-options when dhcp is not possible --
using iservice, API, netsh etc.

Selva

--000000000000b090e005af5ac3a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Sep 15, 2020 at 2:48 AM Lev Stipakov &lt;<a=
 href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_USAGE, &quot;--dhcp-options require=
s --ip-win32 dynamic or adaptive&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_USAGE, &quot;--dhcp-option requires=
 --ip-win32 dynamic or adaptive&quot;);<br>
<br>
Nice, this typo has been there since at least 2005.<br>
<br>
It looks like that warning is not quite correct - for example,<br>
DNS can be set via iservice or netsh, which means that<br>
<br>
--ip-win32 netsh<br>
--dhcp-option DNS 8.8.8.8<br>
<br>
is a valid combination regardless of driver type. On the other hand,<br>
NBDD/NTP are set via DHCP.<br>
<br>
It would be good to make the warning condition more fine-grained, but<br>
this patch is good enough as it is, since it fixes important case - specify=
<br>
DNS in the ovpn profile when using wintun.<br></blockquote><div><br></div><=
div>We could deprecate --ip-win32 as a user option. Default to dynamic or a=
daptive, automatically fail-over to alternate methods or change it internal=
ly as required for wintun etc.</div><div><br></div><div>And work towards su=
pporting more dhcp-options when dhcp is not possible -- using iservice, API=
, netsh etc.</div><div><br></div><div>Selva</div></div></div>

--000000000000b090e005af5ac3a1--

