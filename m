From: Peter Sagerson <psagers@...1829...>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_4BC086CE-EF12-4633-BC14-94E8A1302D58";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <8B6DA5B7-E5EF-434A-89C5-F9C89D8A8451@...1829...>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Date: Mon, 17 Jun 2013 11:51:53 -0700
References: <5C629764-6A77-4E0D-8B27-AF0AE8B29025@...1829...>
	<51BCF5D1.6070407@...1227...>
	<BC613B74-D9A7-48B9-94B3-2AFF99BF8847@...1829...>
	<51BE2AA0.7060908@...1227...>
	<CAEsd45QVPywukuUO=h8f+PddGs1EPX2MCRC=ir=iBWEqdKx6zA@...278...>
	<20130617173949.GT20843@...1296...>
In-Reply-To: <20130617173949.GT20843@...1296...>
Subject: Re: [Openvpn-devel] Native OS X tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_4BC086CE-EF12-4633-BC14-94E8A1302D58
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Just a recommendation, but I wouldn't necessarily consider the two proposal=
s alternatives. The only interesting thing going on here is an implementati=
on of open_tun that creates utun devices. The rest is just wiring. Even ope=
n_tun isn't really subtle or complex, merely a bit arcane. I suspect the ke=
y decisions are how aggressive to make the migration path and how discovera=
ble to make the configuration--if any--at which point there is now more tha=
n enough raw material from which to assemble the feature.

Thanks


On Jun 17, 2013, at 10:39 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>=20
> On Mon, Jun 17, 2013 at 11:33:54AM -0400, Jonathan K. Bullard wrote:
>> I have a slight preference forArne's patch, which doesn't introduce yet
>> another new OpenVPN option.
>=20
> Without having compared the code itself, I second that argument.  No more
> super-special-case options (which depend on #ifdef TARGET_XYZ), please.
>=20
> Now it might be a good idea to find time to actually read both patches
> before Thursday and have a more educated opinion :-) *put on TODO list*
>=20
> gert
>=20
> --=20
> USENET is *not* the non-clickable part of WWW!
>                                                           //www.muc.de/~g=
ert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...
> -------------------------------------------------------------------------=
-----
> This SF.net email is sponsored by Windows:
>=20
> Build for Windows Store.
>=20
> http://p.sf.net/sfu/windows-dev2dev______________________________________=
_________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--Apple-Mail=_4BC086CE-EF12-4633-BC14-94E8A1302D58
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)

iQIcBAEBAgAGBQJRv1rLAAoJENfXJ2LQ+g52S/EQAIwhO7M51ytEApjybqsqIV1D
eP9GK1FttgCu0CT8lsl2IAJNsS5dTrbO6PzrDnBMbtBCnWTqAFPY8p9qQxYJAzna
twbRnLILF7fBcB/o4t7/1EuFEtHPl3Mpkjz47LuRf8gta0snxpj9xAZqPblfv+H9
MBMpHjS1W1FeAibzCI8n+Dr+5QUp82YJwVR+hTySjLt3jQadI6q4920kwug9GoYF
2ZAZO/M2ZoluMcypVi9Psmc7qO4I6kdEpG5zlkPrK3ziGRMgbxznU5OtrMqjGAg4
U5NuXzuVDzUG/TSIrQynNaN+saGg4ccyfa62Y3In4OfZyl++pDEKHAWnYPUTqWwv
pa6mMf3M0O9O8eMkd3CVqMsZ+v/1kV3Jri5GOVuwYPLdyVBBrK5JfGRrYOCXbwC8
2kayHokF+EVk+oXKwHzneLzwle+sJu45IExgkZeiTuqQKIYY2MzR7VYE5v85jOEa
vAqyJmmv2AuDObmB9/LdLD9xkQrVyOTo/dY5z6WkfaFVumVsNYB/76gPBQEwQCKc
654GnTTMpeFkpsdY5T33irZKpu0eHn1/hUFfJAB6zYYIocvRwEHtZN+rLpnGxrVC
5yP8eo3/NTGClv24vRtLwBnou5hJ4ba33YqNycuDiKGfPqs/ruWfTQDhX6YbjUjA
6ELDCtPu1jHc1mf1PPRU
=oJmR
-----END PGP SIGNATURE-----

--Apple-Mail=_4BC086CE-EF12-4633-BC14-94E8A1302D58--

