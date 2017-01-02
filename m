Date: Mon, 2 Jan 2017 15:33:24 +0100
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20170102143324.fkg2fzb4l7fbj666@...30...>
References: <20170102141723.mtgdfznx5rcsdurs@...30...>
	<20170102142646.GL78624@...1296...>
MIME-Version: 1.0
In-Reply-To: <20170102142646.GL78624@...1296...>
Subject: Re: [Openvpn-devel] 2.4 sees all client certificates as expired
 when using crl-verify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Jan 02, 2017 at 03:26:46PM +0100, Gert Doering wrote:
> Hi,
>=20
> On Mon, Jan 02, 2017 at 03:17:23PM +0100, Alberto Gonzalez Iniesta wrote:
> > I just got this [1] bug report on OpenVPN 2.4 threating all certs as
> > expired when upgrading from 2.3. I find this quite weird, but until I h=
ave
> > some time to test it I thought asking here would be faster.
>=20
> From the bug report:
>=20
> Mon Jan  2 07:37:10 2017 us=3D466023 1.2.3.4:36241 VERIFY ERROR: depth=3D=
0, error=3DCRL has expired: C=3DXX, ST=3DXX, L=3DXXX, O=3DNone, CN=3Dmycn, =
emailAddress=3Dmy@...2228...
>=20
> "what the log says" :-)
>=20
> 2.4 checks CRLs much more rigidly than 2.3 (precisely: 2.3 had some
> built-in checking which only looked at revocations, while 2.4 leaves this=
=20
> to the crypto library, and they check all fields more rigidly).
>=20
> Specifically, CRLs with an expired "next update" field are flagged as
> "expired" by OpenSSL, while the built-in check in 2.3 did not.
>=20
>=20
> Since this bit a few people already, I wonder how we could communicate
> this better.
>=20
> gert
>=20
>=20

Oh! I see. Thanks Gert!!

I can/will add a note on the Debian package, but that has a limited
audience.

Cheers,

Alberto

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
mailto/sip: agi@...64... | en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55

