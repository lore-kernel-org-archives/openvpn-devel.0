MIME-Version: 1.0
In-Reply-To: <1500293278.28621.32.camel@...1866...>
References: <f7687ebf-a75f-095d-67ca-e32a5c4e53e7@...515...>
 <1500293278.28621.32.camel@...1866...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 18 Oct 2017 12:43:38 +0500
Message-ID: <CAFHpkQGMFD0JX5NHsxy_QCrzFMJ-Tcj5HS9xnkzvsQ6Vk3aQGw@...278...>
Content-Type: multipart/alternative; boundary="94eb2c05bd8ce545b1055bcd65fc"
Subject: Re: [Openvpn-devel] Windows installer with updated pkcs11-helper
 (1.22) available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c05bd8ce545b1055bcd65fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-07-17 17:07 GMT+05:00 David Woodhouse <dwmw2@...1866...>:

> On Fri, 2017-07-14 at 17:07 +0300, Samuli Sepp=C3=A4nen wrote:
> > Hi all,
> >
> > Those of you who use pkcs11 on Windows: could you please test this new
> > Windows installer:
> >
> >
> >
> > The previous installer(s) had pkcs11-helper 1.11. This one has 1.22, so
> > some regression testing would be good to have.
>
> Please include the pkcs11-helper patch from
> https://github.com/OpenSC/pkcs11-helper/pull/4 to make it support using
> RFC7512 PKCS#11 URIs to specify certificates/keys instead of its own
> non-standard identifiers.
>


David, can you have a look, please ?

https://github.com/OpenVPN/openvpn-build/pull/110


>
> (It still accepts the old form, for compatibility).
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--94eb2c05bd8ce545b1055bcd65fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-07-17 17:07 GMT+05:00 David Woodhouse <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:dwmw2@...1866..." target=3D"_blank">dwmw2@...1866...</a>&gt;</s=
pan>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"g=
mail-">On Fri, 2017-07-14 at 17:07 +0300, Samuli Sepp=C3=A4nen wrote:<br>
&gt; Hi all,<br>
&gt;<br>
&gt; Those of you who use pkcs11 on Windows: could you please test this new=
<br>
&gt; Windows installer:<br>
&gt;<br>
&gt;<br>
&gt;<br>
</span><span class=3D"gmail-">&gt; The previous installer(s) had pkcs11-hel=
per 1.11. This one has 1.22, so<br>
&gt; some regression testing would be good to have.<br>
<br>
</span>Please include the pkcs11-helper patch from<br>
<a href=3D"https://github.com/OpenSC/pkcs11-helper/pull/4" rel=3D"noreferre=
r" target=3D"_blank">https://github.com/OpenSC/<wbr>pkcs11-helper/pull/4</a=
>=C2=A0to make it support using<br>
RFC7512 PKCS#11 URIs to specify certificates/keys instead of its own<br>
non-standard identifiers.<br></blockquote><div><br><br></div><div>David, ca=
n you have a look, please ?<br><br><a href=3D"https://github.com/OpenVPN/op=
envpn-build/pull/110">https://github.com/OpenVPN/openvpn-build/pull/110</a>=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
(It still accepts the old form, for compatibility).<br>--------------------=
----------<wbr>------------------------------<wbr>------------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>_________=
_____________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
<br></blockquote></div><br></div></div>

--94eb2c05bd8ce545b1055bcd65fc--

