MIME-Version: 1.0
In-Reply-To: <CAFHpkQH8b3PMTh6KEB7CbO2HaUnJ94aNwHt+RHTqXkEUKoAbdg@...278...>
References: <CAFHpkQH8b3PMTh6KEB7CbO2HaUnJ94aNwHt+RHTqXkEUKoAbdg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 17 Nov 2016 15:34:20 -0500
Message-ID: <CAKuzo_jHuSVd2cKco-ftKAmpL2ReJJTF2phZhubmYshGfad5Mw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c05839877509e0541851e8b
Subject: Re: [Openvpn-devel] why do we include openssl.exe in windows
 installer ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c05839877509e0541851e8b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 17, 2016 at 1:57 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> I noticed that openssl.exe is included
>
> https://github.com/OpenVPN/openvpn-build/blob/master/windows
> -nsis/openvpn.nsi#L348
>
> and it can be checked independently from easy rsa.
>
> what is use case from user point of view of openssl.exe ?


Having openssl.exe around on the client host is quite useful for inspecting
the certificate, change key password etc. On a client machine one wouldn't
normally install easy-rsa, so openvpn installer including this is very
handy.

Selva

--94eb2c05839877509e0541851e8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Nov 17, 2016 at 1:57 PM, =D0=98=
=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"=
ltr">&lt;<a href=3D"mailto:chipitsine@...277..." target=3D"_blank">chipitsi=
ne@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><=
div>I noticed that openssl.exe is included<br><br><a href=3D"https://github=
.com/OpenVPN/openvpn-build/blob/master/windows-nsis/openvpn.nsi#L348" targe=
t=3D"_blank">https://github.com/OpenVPN/ope<wbr>nvpn-build/blob/master/wind=
ows<wbr>-nsis/openvpn.nsi#L348</a><br><br></div>and it can be checked indep=
endently from easy rsa.<br><br></div>what is use case from user point of vi=
ew of openssl.exe ?</blockquote></div><div class=3D"gmail_extra"><br></div>=
Having openssl.exe around on the client host is quite useful for inspecting=
 the certificate, change key password etc. On a client machine one wouldn&#=
39;t normally install easy-rsa, so openvpn installer including this is very=
 handy.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra=
">Selva</div></div>

--94eb2c05839877509e0541851e8b--

