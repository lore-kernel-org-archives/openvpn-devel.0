MIME-Version: 1.0
References: <CAGyAFMUgS+WaDf5Xx8S-jX3MbAu4QT7_Ln86JDtmZEaV2PPLcA@...278...>
 <1561637226-18464-1-git-send-email-lstipakov@...277...>
 <CAKuzo_jqHYt-xbwkTG59DEbEpNKT7GPtWE8T6t-Jiwv0CiyhOQ@...278...>
 <CAGyAFMUDx_eD4Yk9TtvWKDXNnpLg55-0tZT0zL6T61zDALTTvw@...278...>
 <CAKuzo_hMBG_5ivztY4Zvj7kTnrjWSZyN1iYbK2d5Rh__XvyMYQ@...278...>
In-Reply-To: <CAKuzo_hMBG_5ivztY4Zvj7kTnrjWSZyN1iYbK2d5Rh__XvyMYQ@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 18 Jul 2019 11:01:28 +0300
Message-ID: <CAGyAFMV9WbXt_OvjpJdy6uWTb6XDWjdC=h4UYUKxDmF1qdyfuQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000e3ae05058df004a0"
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000e3ae05058df004a0
Content-Type: text/plain; charset="UTF-8"

Hi,


> That'll probably work with some extra sanity checks on the file name.
> Ideally we should just pass the dev-node (empty if unspecified) and type of
> device (TAP6 or WINTUN), but that will require a lot of  duplication of
> code in the service, as you noted.
>
> One option is to pass the device guid in case of tap or the index in case
> of wintun and construct the path in the service. That requires very little
> extra code. Otherwise a thorough sanitization of the path is required as
> there could be obscure ways of breaking out using "..\" or otherwise,
> though I'm not sure. Things like \\.\C:\..\D:\ works on Windows so I won't
> take any chances.
>

You are right, just tested and one can escape global like this:

\\.\Global\..\C:\lol.tap

I'll do as you've proposed - pass a string which is either guid or number,
a boolean flag (wintun/tap6) and add some validation.


> PS. Just noticed you've already posted a v4 -- I haven't looked at it yet.
>

v5 is coming!

-- 
-Lev

--000000000000e3ae05058df004a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>Hi,</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div cla=
ss=3D"gmail_quote"><div>That&#39;ll probably work with some extra sanity ch=
ecks on the file name. Ideally we should just pass the dev-node (empty if u=
nspecified) and type of device (TAP6 or WINTUN), but that will require a lo=
t of=C2=A0 duplication of code in the service, as you noted.<br></div><div>=
<br></div><div>One option is to pass the device guid in case of tap or the =
index in case of wintun and construct the path in the service. That require=
s very little extra code. Otherwise a thorough sanitization of the path is =
required as there could be obscure ways of breaking out using &quot;..\&quo=
t; or otherwise, though I&#39;m not sure. Things like \\.\C:\..\D:\ works o=
n Windows so I won&#39;t take any chances.<br></div></div></div></blockquot=
e><div><br></div><div>You are right, just tested and one can escape global =
like this:</div><div><br></div><div>\\.\Global\..\C:\lol.tap</div><div><br>=
</div><div>I&#39;ll do as you&#39;ve proposed - pass a string which is eith=
er guid or number, a boolean flag (wintun/tap6) and add some validation.</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"ltr"><div class=3D"gmail_quote"><div>PS. Just noticed you&#39;ve alr=
eady posted a v4 -- I haven&#39;t looked at it yet.<br></div></div></div>
</blockquote></div><br clear=3D"all"><div>v5 is coming!</div><div><br></div=
>-- <br><div dir=3D"ltr" class=3D"m_-638331621436307497gmail_signature">-Le=
v</div></div>

--000000000000e3ae05058df004a0--

