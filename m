MIME-Version: 1.0
References: <CAGyAFMUgS+WaDf5Xx8S-jX3MbAu4QT7_Ln86JDtmZEaV2PPLcA@...278...>
 <1561637226-18464-1-git-send-email-lstipakov@...277...>
 <CAKuzo_jqHYt-xbwkTG59DEbEpNKT7GPtWE8T6t-Jiwv0CiyhOQ@...278...>
 <CAGyAFMUDx_eD4Yk9TtvWKDXNnpLg55-0tZT0zL6T61zDALTTvw@...278...>
In-Reply-To: <CAGyAFMUDx_eD4Yk9TtvWKDXNnpLg55-0tZT0zL6T61zDALTTvw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 17 Jul 2019 10:51:06 -0400
Message-ID: <CAKuzo_hMBG_5ivztY4Zvj7kTnrjWSZyN1iYbK2d5Rh__XvyMYQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000008ce9bf058de1a07e"
Subject: Re: [Openvpn-devel] [PATCH v3] openvpnserv: enable interactive
 service to open tun
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

--0000000000008ce9bf058de1a07e
Content-Type: text/plain; charset="UTF-8"

Hi

On Wed, Jul 17, 2019 at 8:20 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> Sorry for delay - I was on vacation.
>
> (i) The new message is named message_open_tun, but it allows opening
>> any file using the service. This is not secure.
>
>
> I am thinking of possible vector of attack here.
>
> In our case it is service which launches openvpn process using
> path set in registry, opens pipe and passes pipe handle to launched
> process.
>
> To make service run malicious process one needs either to replace
> executable or
> modify registry. For both actions you need to be administrator, assuming
> default security policy.
>
> Alternatively, can random process hijack the pipe handle from another
> process?
>

Because the pipe handle is targeted for OpenVPN process id and not
inheritable that may not be possible. But an attack is very simple:

Just write a plugin and use the service to open files from it. Passing the
pipe handle to the plugin is trivial. Anyone in OpenVPNAdministrators group
can then use a custom config file and get access any file on the system.
Membership in that group is not supposed to provide any privileges to
limited users beyond setting up routes or manipulating some interface
parameters.


>
>> We need to restrict it to open tun/tap device nodes only.
>>
>
> Without adding too much code, I can think of:
>
>  - check that path starts with \\\\.\\Global\\ to make sure we open
> device, not file
>
> and
>
>  - check that path starts with \\\\.\\Global\\WINTUN or ends with .tap
>
> Is this good enough or do you have better ideas?
>

That'll probably work with some extra sanity checks on the file name.
Ideally we should just pass the dev-node (empty if unspecified) and type of
device (TAP6 or WINTUN), but that will require a lot of  duplication of
code in the service, as you noted.

One option is to pass the device guid in case of tap or the index in case
of wintun and construct the path in the service. That requires very little
extra code. Otherwise a thorough sanitization of the path is required as
there could be obscure ways of breaking out using "..\" or otherwise,
though I'm not sure. Things like \\.\C:\..\D:\ works on Windows so I won't
take any chances.

Selva

PS. Just noticed you've already posted a v4 -- I haven't looked at it yet.

--0000000000008ce9bf058de1a07e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Jul 17, 2019 at 8:20 AM Lev Stipakov &lt;<a=
 href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>Sorry for delay - I=
 was on vacation.</div><div><br></div></div><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
(i) The new message is named message_open_tun, but it allows opening<br>
any file using the service. This is not secure. </blockquote><div><br></div=
><div>I am thinking of possible vector of attack here.</div><div><br></div>=
<div>In our case it is service which launches openvpn process using</div><d=
iv>path set in registry, opens pipe and passes pipe handle to launched proc=
ess.</div><div><br></div><div>To make service run malicious process one nee=
ds either to replace executable or</div><div>modify registry. For both acti=
ons you need to be administrator, assuming default security policy.</div><d=
iv><br></div><div>Alternatively, can random process hijack the pipe handle =
from another process?</div></div></div></blockquote><div><br></div><div>Bec=
ause the pipe handle is targeted for OpenVPN process id and not inheritable=
 that may not be possible. But an attack is very simple: <br></div><div><br=
></div><div>Just write a plugin and use the service to open files from it. =
Passing the pipe handle to the plugin is trivial. Anyone in OpenVPNAdminist=
rators group can then use a custom config file and get access any file on t=
he system. Membership in that group is not supposed to provide any privileg=
es to limited users beyond setting up routes or manipulating some interface=
 parameters.<br></div><div><br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">We need to restrict it to o=
pen tun/tap device nodes only.<br></blockquote><div><br></div><div>Without =
adding too much code, I can think of:</div><div><br></div><div>=C2=A0- chec=
k that path starts with=C2=A0\\\\.\\Global\\ to make sure we open device, n=
ot file</div><div><br></div><div>and</div><div>=C2=A0</div><div>=C2=A0- che=
ck that path starts with=C2=A0\\\\.\\Global\\WINTUN or ends with .tap</div>=
<div><br></div><div>Is this good enough or do you have better ideas?</div><=
/div></div></blockquote><div><br></div><div>That&#39;ll probably work with =
some extra sanity checks on the file name. Ideally we should just pass the =
dev-node (empty if unspecified) and type of device (TAP6 or WINTUN), but th=
at will require a lot of=C2=A0 duplication of code in the service, as you n=
oted.<br></div><div><br></div><div>One option is to pass the device guid in=
 case of tap or the index in case of wintun and construct the path in the s=
ervice. That requires very little extra code. Otherwise a thorough sanitiza=
tion of the path is required as there could be obscure ways of breaking out=
 using &quot;..\&quot; or otherwise, though I&#39;m not sure. Things like \=
\.\C:\..\D:\ works on Windows so I won&#39;t take any chances.<br></div><di=
v>=C2=A0 <br></div><div>Selva</div><div><br></div><div>PS. Just noticed you=
&#39;ve already posted a v4 -- I haven&#39;t looked at it yet.<br></div></d=
iv></div>

--0000000000008ce9bf058de1a07e--

