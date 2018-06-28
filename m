References: <DM5PR08MB36429068FCBF60610B6E85CFB94F0@...2422...>
 <20180628065703.GS57262@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <046f2ff7-2340-abd0-7f3a-6a31455b2fc3@...515...>
Date: Thu, 28 Jun 2018 10:52:57 +0300
MIME-Version: 1.0
In-Reply-To: <20180628065703.GS57262@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JK4KUMI0EiL6ivHnSgBkk8fChO4XgFNdA"
Subject: Re: [Openvpn-devel] OpenVPN GUI, and routes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, "Morris, Russell" <rmorris@...1315...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JK4KUMI0EiL6ivHnSgBkk8fChO4XgFNdA
Content-Type: multipart/mixed; boundary="aFF29yrjTvZAVqNqSivrIL5f6fobtwugV";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: Gert Doering <gert@...1296...>, "Morris, Russell"
 <rmorris@...1315...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <046f2ff7-2340-abd0-7f3a-6a31455b2fc3@...515...>
Subject: Re: [Openvpn-devel] OpenVPN GUI, and routes
References: <DM5PR08MB36429068FCBF60610B6E85CFB94F0@...2422...>
 <20180628065703.GS57262@...1296...>
In-Reply-To: <20180628065703.GS57262@...1296...>

--aFF29yrjTvZAVqNqSivrIL5f6fobtwugV
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Il 28/06/2018 09:57, Gert Doering ha scritto:
> HI,
>=20
> On Thu, Jun 28, 2018 at 12:54:23AM +0000, Morris, Russell wrote:
>> This may be by design ??? if so just say that and I???ll go away ??? ???=
?. But that said ??? it seems I have to run the OpenVPN GUI (manually) as a=
n administrator, for routes to be set / added as directed by the server. Is=
 this expected? Unfortunately it won???t even allow the client to connect i=
f this step fails.
>=20
> With 2.4.x, the GUI is supposed to run with normal user privs.  Route
> handling is done by the "OpenVPN Interactive Service", which needs to
> be running.
>=20
> If you install the normal installer provided by us, everything will be=20
> set up so it just works.
>=20
> If not, provide platform details, logs, etc.
>=20

The Windows service name is "OpenVPNServiceInteractive". You can check
its status from Powershell:

  Get-Service OpenVPNServiceInteractive

To start it:

  Start-Service OpenVPNServiceInteractive

That said, it _should_ be running already if you installed OpenVPN 2.4.x
using our standard installers.


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--aFF29yrjTvZAVqNqSivrIL5f6fobtwugV--

--JK4KUMI0EiL6ivHnSgBkk8fChO4XgFNdA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAls0k9kACgkQKVhNn0CG
RXhbJgf+O7u14i4veIu6irvBXehMznr4KumKhp3ojhsFjTxOw8o2mJmVQL4MR0T9
lK5r58pc66SHaf5i26cHiE+z4BW5YmZr4iyvj8xtAuM1ojc2T2bHWIzsOnlN5+0i
smBueAQcv2QIw4NSC+aKXXSfp3mhZOPzBGlaU6S0Jhu5kcdA6ZbvvaVb7ieCgePx
z/HqUY7raEY/J4nYpw3SwhR2enZhziRxhmoffq9o7moaOPmmX1JIaFBtrxyD5e+3
JWWjrhvhXCFmV5rssLpuApY+mpNGEETXt7ivd1kItEN3MtSk9lVh2EAod54IH11M
G+Gf9WJ39xaS7HtGyED3Bp4vU7znpw==
=oQrk
-----END PGP SIGNATURE-----

--JK4KUMI0EiL6ivHnSgBkk8fChO4XgFNdA--

