From: Eric Crist <ecrist@...1286...>
Message-Id: <C63D20D2-1878-4E2A-AF77-2E444C7C33D2@...1286...>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5AFDC0B8-32ED-4620-A5D2-0AF5742D3E44";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Date: Mon, 27 Aug 2018 04:19:46 -0500
In-Reply-To: <CAJY0qZJk8i7si2v9vVU2ki2s73pTAiX4KcQX6uoCoC=25s3e9A@...278...>
References: <149619ba-265f-1a7a-6403-f99c6f4b7eac@...1227...>
 <f89c1cbd-4899-432a-5288-1055b5045318@...2080...>
 <20180824191654.GK997@...1296...>
 <CAJY0qZ+RSaUQZ28EMjkr0B5i-wT4ZG--YB6jsgBBiMKby2vh1A@...278...>
 <7e4cbf14-4f3e-4564-0328-d7daec2b4fb8@...1227...>
 <CAJY0qZJk8i7si2v9vVU2ki2s73pTAiX4KcQX6uoCoC=25s3e9A@...278...>
Subject: Re: [Openvpn-devel] Discussion: Moving forward with compression and
 voracle
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Derek Zimmer <derek@...2095...>
Cc: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_5AFDC0B8-32ED-4620-A5D2-0AF5742D3E44
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_7B6EAF10-4115-40F5-9638-B8D98B375091"

--Apple-Mail=_7B6EAF10-4115-40F5-9638-B8D98B375091
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I agree with Arne on this one.  I=E2=80=99m OK with a warning, but I don=E2=
=80=99t think we should make it impossible.  This is where nasty forks star=
t to show up because we broke something upstream (recall the day s of the l=
ack of password-save in our Windows client).

Eric F Crist


> On Aug 27, 2018, at 03:10:31, Derek Zimmer <derek@...2095...> wrote:
>=20
>> That is a terrible idea. The intention is good but users will then opt
>> out of encryption because they want compression or build stacked VPNs.
>=20
> That was the point of the idea though. If you want to go that far to
> go around security, you are very aware of the consequences of what
> you're doing. If we don't want to force the users hand, a big and ugly
> warning that shows up when compression + encryption is enabled may
> lead to the same end result.
>=20
> In my opinion as long as the user is acutely aware of the risks and we
> make the documentation and warnings very clear, the project is as safe
> as it can be from user error driven security suicide.
> Derek Zimmer
> Chief Executive Officer
> Open Source Technology Improvement Fund
>=20
>=20
> On Mon, Aug 27, 2018 at 2:25 AM, Arne Schwabe <arne@...1227...> wrote:
>> Am 27.08.18 um 00:55 schrieb Derek Zimmer:
>>> There's always the option of not allowing encryption to be enabled
>>> with compression enabled. This keeps things like using OpenVPN as
>>> fancy proxy working without endangering the privacy VPN use-case.
>>=20
>> That is a terrible idea. The intention is good but users will then opt
>> out of encryption because they want compression or build stacked VPNs.
>>=20
>> Arne
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--Apple-Mail=_7B6EAF10-4115-40F5-9638-B8D98B375091
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; line-break: after-white-space;" class=3D"">I agree with Arne on this =
one. &nbsp;I=E2=80=99m OK with a warning, but I don=E2=80=99t think we shou=
ld make it impossible. &nbsp;This is where nasty forks start to show up bec=
ause we broke something upstream (recall the day s of the lack of password-=
save in our Windows client).<br class=3D""><div class=3D""><br class=3D"web=
kit-block-placeholder"></div><div class=3D"">
<div dir=3D"auto" style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); =
letter-spacing: normal; text-align: start; text-indent: 0px; text-transform=
: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: =
0px; text-decoration: none; word-wrap: break-word; -webkit-nbsp-mode: space=
; line-break: after-white-space;" class=3D""><div style=3D"margin: 0in 0in =
0.0001pt; font-size: 11pt; font-family: Calibri, sans-serif;" class=3D""><b=
 class=3D""><span style=3D"font-size: 10pt; font-family: Verdana, sans-seri=
f; color: rgb(31, 73, 125);" class=3D"">Eric F Crist<o:p class=3D""></o:p><=
/span></b></div><div style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt; fo=
nt-family: Calibri, sans-serif;" class=3D""><br class=3D""></div></div></di=
v><div class=3D""><br class=3D"webkit-block-placeholder"></div><div><blockq=
uote type=3D"cite" class=3D""><div class=3D"">On Aug 27, 2018, at 03:10:31,=
 Derek Zimmer &lt;<a href=3D"mailto:derek@...2095..." class=3D"">derek@...1665...=
095...</a>&gt; wrote:</div><br class=3D"Apple-interchange-newline"><div cla=
ss=3D""><div class=3D""><blockquote type=3D"cite" class=3D"">That is a terr=
ible idea. The intention is good but users will then opt<br class=3D"">out =
of encryption because they want compression or build stacked VPNs.<br class=
=3D""></blockquote><br class=3D"">That was the point of the idea though. If=
 you want to go that far to<br class=3D"">go around security, you are very =
aware of the consequences of what<br class=3D"">you're doing. If we don't w=
ant to force the users hand, a big and ugly<br class=3D"">warning that show=
s up when compression + encryption is enabled may<br class=3D"">lead to the=
 same end result.<br class=3D""><br class=3D"">In my opinion as long as the=
 user is acutely aware of the risks and we<br class=3D"">make the documenta=
tion and warnings very clear, the project is as safe<br class=3D"">as it ca=
n be from user error driven security suicide.<br class=3D"">Derek Zimmer<br=
 class=3D"">Chief Executive Officer<br class=3D"">Open Source Technology Im=
provement Fund<br class=3D""><br class=3D""><br class=3D"">On Mon, Aug 27, =
2018 at 2:25 AM, Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." class=
=3D"">arne@...1227...</a>&gt; wrote:<br class=3D""><blockquote type=3D"cite=
" class=3D"">Am 27.08.18 um 00:55 schrieb Derek Zimmer:<br class=3D""><bloc=
kquote type=3D"cite" class=3D"">There's always the option of not allowing e=
ncryption to be enabled<br class=3D"">with compression enabled. This keeps =
things like using OpenVPN as<br class=3D"">fancy proxy working without enda=
ngering the privacy VPN use-case.<br class=3D""></blockquote><br class=3D""=
>That is a terrible idea. The intention is good but users will then opt<br =
class=3D"">out of encryption because they want compression or build stacked=
 VPNs.<br class=3D""><br class=3D"">Arne<br class=3D""></blockquote><br cla=
ss=3D"">-------------------------------------------------------------------=
-----------<br class=3D"">Check out the vibrant tech community on one of th=
e world's most<br class=3D"">engaging tech sites, <a href=3D"http://Slashdo=
t.org" class=3D"">Slashdot.org</a>! <a href=3D"http://sdm.link/slashdot" cl=
ass=3D"">http://sdm.link/slashdot</a><br class=3D"">_______________________=
________________________<br class=3D"">Openvpn-devel mailing list<br class=
=3D""><a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" class=3D"">Ope=
nvpn-devel@lists.sourceforge.net</a><br class=3D"">https://lists.sourceforg=
e.net/lists/listinfo/openvpn-devel<br class=3D""></div></div></blockquote><=
/div><br class=3D""></body></html>=

--Apple-Mail=_7B6EAF10-4115-40F5-9638-B8D98B375091--

--Apple-Mail=_5AFDC0B8-32ED-4620-A5D2-0AF5742D3E44
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEzBAEBCAAdFiEEyPyj5/eHByzeuR0vcpZCGTkNDQ4FAluDwjIACgkQcpZCGTkN
DQ74+Qf/YiqkR1tcklq6SrodriYEg/dFQEcCQKOFFEmvmpqLAraaiJkS6fxM4YHd
K/821YwrBTI48C78UM9w6Hofka/kHnvtfaxQTsqsOm49ih1itZZhCSE37Z7r+FKS
bpImw2gdxjVyXQbwUwf7OUGkC/SPJEkwK09NMnrPsmvkKjSbMnLOAIrsG0ancJhe
7lzm3WjhEDoacO/bcbIkytjQxjs/t5LnmGu3e3GhOjXQtdA87QJP01115qOy3Nea
4E1oZKRjWcO0mfM3gtmvh5QuxOVGJ0k64ycFutdh8VqbXDLa7CrRO0lgivb5kIU0
Fk2y23FmiqxpCXNNIiAaphUaRjGhKg==
=8/zK
-----END PGP SIGNATURE-----

--Apple-Mail=_5AFDC0B8-32ED-4620-A5D2-0AF5742D3E44--

