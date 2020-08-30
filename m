MIME-Version: 1.0
References: <f10b3cfd-d020-5598-ec84-95fc8cd0e8e9@...515...>
In-Reply-To: <f10b3cfd-d020-5598-ec84-95fc8cd0e8e9@...515...>
From: Rafael Gava <gava100@...277...>
Date: Sat, 29 Aug 2020 22:00:04 -0300
Message-ID: <CAAWBBYO=_X7gN96_-fNLshTS23ttLnt9+O8Sh1JjEYYqsMq0fA@...278...>
Content-Type: multipart/alternative; boundary="0000000000000e6a2805ae0dcf92"
Subject: Re: [Openvpn-devel] Help testing OpenVPN 2.5-beta2 driver
 installation?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000000e6a2805ae0dcf92
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Although I've got an issue (below) in your release, reported in another
email, the installation worked fine in a Windows 10 Enterprise
Evaluation  Build 19041.vb_release. 191206-1406.

2020-08-29 16:02:53 us=3D643016 OPTIONS ERROR: failed to negotiate cipher
with server.  Add the server's cipher ('BF-CBC') to --data-ciphers
(currently 'BF-CBC') if you want to connect to this server.
2020-08-29 16:02:53 us=3D659181 ERROR: Failed to apply push options

BR

Gava

On Fri, Aug 28, 2020 at 10:10 AM Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

> Hi,
>
> It would be great if somebody would find time to test the following
> installer:
>
>
> https://build.openvpn.net/downloads/releases/OpenVPN-2.5-beta2-I601-amd64=
.msi
>
> In particular I'd like to know if anyone else has problems installing
> Wintun or Tap-windows6. My exact issue is described here:
>
> https://github.com/OpenVPN/openvpn-build/issues/187
>
> At the moment two people have successfully ran that installer and one
> (me) have failed.
>
> Samuli
>
>
> PS. The installer has a known, upgrade-related issue as well, but we
> already have plans on how to tackle that:
>
> https://github.com/OpenVPN/openvpn-build/issues/188
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--0000000000000e6a2805ae0dcf92
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Although I&#39;ve got an issue (bel=
ow) in your release, reported in another email, the installation worked fin=
e in a Windows=C2=A010 Enterprise Evaluation=C2=A0=C2=A0Build 19041.vb_rele=
ase. 191206-1406.</div><div><br></div><div>2020-08-29 16:02:53 us=3D643016 =
OPTIONS ERROR: failed to negotiate cipher with server.=C2=A0 Add the server=
&#39;s cipher (&#39;BF-CBC&#39;) to --data-ciphers (currently &#39;BF-CBC&#=
39;) if you want to connect to this server.<br>2020-08-29 16:02:53 us=3D659=
181 ERROR: Failed to apply push options<br></div><div><br></div><div>BR=C2=
=A0</div><div><br></div><div>Gava</div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 28, 2020 at 10:10 AM Sam=
uli Sepp=C3=A4nen &lt;<a href=3D"mailto:samuli@...515...">samuli@...515...<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">H=
i,<br>
<br>
It would be great if somebody would find time to test the following<br>
installer:<br>
<br>
<a href=3D"https://build.openvpn.net/downloads/releases/OpenVPN-2.5-beta2-I=
601-amd64.msi" rel=3D"noreferrer" target=3D"_blank">https://build.openvpn.n=
et/downloads/releases/OpenVPN-2.5-beta2-I601-amd64.msi</a><br>
<br>
In particular I&#39;d like to know if anyone else has problems installing<b=
r>
Wintun or Tap-windows6. My exact issue is described here:<br>
<br>
<a href=3D"https://github.com/OpenVPN/openvpn-build/issues/187" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/OpenVPN/openvpn-build/issues/1=
87</a><br>
<br>
At the moment two people have successfully ran that installer and one<br>
(me) have failed.<br>
<br>
Samuli<br>
<br>
<br>
PS. The installer has a known, upgrade-related issue as well, but we<br>
already have plans on how to tackle that:<br>
<br>
<a href=3D"https://github.com/OpenVPN/openvpn-build/issues/188" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/OpenVPN/openvpn-build/issues/1=
88</a><br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--0000000000000e6a2805ae0dcf92--

