MIME-Version: 1.0
References: <CAGyAFMWXS9F3OzSchqGtizgBoj+7E5JTEnKrnCQqMiejTuHs4g@...278...>
 <1573234655-905-1-git-send-email-lstipakov@...277...>
 <CAKuzo_iQD0ehZHisNQyTN1LtcwEogAgdTOBouPrbBb5OPyg8uA@...278...>
 <20191119073719.GK40538@...1296...>
 <CAGyAFMXwPXRZ-963U0LP72F6RhEV7CzT0DXyzQWuPKhFHVG1Rw@...278...>
In-Reply-To: <CAGyAFMXwPXRZ-963U0LP72F6RhEV7CzT0DXyzQWuPKhFHVG1Rw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 19 Nov 2019 10:39:53 -0500
Message-ID: <CAKuzo_jPhjaJ4QAOY6A=roBWwekB4oJup2L_ZpgVXnkfBWur=Q@...278...>
Content-Type: multipart/alternative; boundary="0000000000002556c70597b4e1a7"
Subject: Re: [Openvpn-devel] [PATCH v3] wintun: add --windows-driver config
 option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000002556c70597b4e1a7
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Nov 19, 2019 at 3:29 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hello,
>
> ti 19. marrask. 2019 klo 9.37 Gert Doering (gert@...1296...)
> kirjoitti:
>
> > Looks like this will most likely break any dhcp-related options
>> > in the client config.. Say "dhcp-option DNS xxx".
>
>
> Oops, indeed. When I add those to client config, I got:
>
> > Options error: --dhcp-options requires --ip-win32 dynamic or adaptive
>
>
>> We currently require ip_win32_type to be  adaptive or dynamic when such
>> options are specified.
>>
>
> That limitation has been presented since the very first commit in github:
>
>     if (options->tuntap_options.dhcp_options
>         && options->tuntap_options.ip_win32_type != IPW32_SET_DHCP_MASQ
>         && options->tuntap_options.ip_win32_type != IPW32_SET_ADAPTIVE)
>     {
>         msg(M_USAGE, "--dhcp-options requires --ip-win32 dynamic or
> adaptive");
>     }
>
> I commented it out and client-side --dhcp-options worked for me. Any ideas
> why we have this code?
>
>
>> > I think we should set this to adaptive here, and then handle it in tun.c
>>
>
> Actually, in follow-up commit I have changed IPAPI to NETSH - if I
> remember correctly
> I could not set up routing using former, although it works when done by
> iserv.
>
> If we don't know why we have that check and we could apply dhcp options
> from client config
> without it, shouldn't we just get rid of it?
>
>
>> >
>> > Although there is no dhcp when wintun is used, we'll still support
>> > dhcp-options such as DNS etc using netsh or service, right?
>>
>
> That's correct. At the moment we use:
>
>  - netsh when running openvpn without interactive service
>  - iserv, which itself uses both IPAPI (for setting up IP address and
> routing) and netsh (for setting up DNS)
>

The ip-win32 mess does need clenup but at least it would be nice to use the
same API/method in iservice and the core. Can we figure out why IP helper
API is not working for setting IP? Unfortunately there is no API for
setting DNS (not that I know of) so there the use of netsh is unavoidable.

Anyway,  wintun + dhcp-option in client config is broken right now. Looks
like it may work when dhcp-option is pushed (not tested) but there are
cases where we do use it directly in the config.

Selva

--0000000000002556c70597b4e1a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Nov 19, 2019 at 3:29 AM Lev Stipakov =
&lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><div dir=3D"ltr">Hello,<div><br></div></div><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">ti 19. marrask. 2019 klo 9.37 Gert Do=
ering (<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...=
</a>) kirjoitti:</div><div dir=3D"ltr" class=3D"gmail_attr"><br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
&gt; Looks like this will most likely break any dhcp-related options<br>
&gt; in the client config.. Say &quot;dhcp-option DNS xxx&quot;.</blockquot=
e><div><br></div><div>Oops, indeed. When I add those to client config, I go=
t:</div><div><br></div><div>&gt; Options error: --dhcp-options requires --i=
p-win32 dynamic or adaptive</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">We currently require=C2=A0ip_win32_type to be=C2=
=A0 adaptive or dynamic when such options are specified.<br></blockquote><d=
iv><br></div><div>That limitation has been presented since the very first c=
ommit in github:</div><div><br></div><div>=C2=A0 =C2=A0 if (options-&gt;tun=
tap_options.dhcp_options<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; options-=
&gt;tuntap_options.ip_win32_type !=3D IPW32_SET_DHCP_MASQ<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &amp;&amp; options-&gt;tuntap_options.ip_win32_type !=3D IPW3=
2_SET_ADAPTIVE)<br>=C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_USA=
GE, &quot;--dhcp-options requires --ip-win32 dynamic or adaptive&quot;);<br=
>=C2=A0 =C2=A0 }<br></div><div><br></div><div>I commented it out and client=
-side --dhcp-options worked for me. Any ideas why we have this code?</div><=
div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; I think we should set this to adaptive here, and then handle it in tun=
.c<br></blockquote><div><br></div><div>Actually, in follow-up commit I have=
 changed IPAPI to NETSH - if I remember correctly</div><div>I could not set=
 up routing using former, although it works when done by iserv.</div><div><=
br></div><div>If we don&#39;t know why we have that check and we could appl=
y dhcp options from client config</div><div>without it, shouldn&#39;t we ju=
st get rid of it?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
&gt; <br>
&gt; Although there is no dhcp when wintun is used, we&#39;ll still support=
<br>
&gt; dhcp-options such as DNS etc using netsh or service, right?<br></block=
quote><div><br></div><div>That&#39;s correct. At the moment we use:</div><d=
iv><br></div><div>=C2=A0- netsh when running openvpn without interactive se=
rvice</div><div>=C2=A0- iserv, which itself uses both IPAPI (for setting up=
 IP address and routing) and netsh (for setting up DNS)</div></div></div></=
blockquote><div><br></div><div>The ip-win32 mess does need clenup but at le=
ast it would be nice to use the same API/method in iservice and the core. C=
an we figure out why IP helper API is not working for setting IP? Unfortuna=
tely there is no API for setting DNS (not that I know of) so there the use =
of netsh is unavoidable.<br></div></div><div class=3D"gmail_quote"><br></di=
v><div class=3D"gmail_quote">Anyway,=C2=A0 wintun + dhcp-option in client c=
onfig is broken right now. Looks like it may work when dhcp-option is pushe=
d (not tested) but there are cases where we do use it directly in the confi=
g.<br></div><div><br></div><div>Selva<br></div></div>

--0000000000002556c70597b4e1a7--

