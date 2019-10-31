From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <6a1b6995-67c1-e30b-bdc1-af1d5485fda5@...515...>
Message-ID: <d34d5974-30ac-6949-9be4-7f4a55126564@...515...>
Date: Thu, 31 Oct 2019 14:04:45 +0200
MIME-Version: 1.0
In-Reply-To: <6a1b6995-67c1-e30b-bdc1-af1d5485fda5@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oo8fg4qWgVjZf1JK2bvSoSqLJ51jpNSif"
Subject: Re: [Openvpn-devel] OpenVPN 2.4.8 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oo8fg4qWgVjZf1JK2bvSoSqLJ51jpNSif
Content-Type: multipart/mixed; boundary="mDWKQQTvHusgdOP2dxiAeXz0wPO0wTiPF";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net,
 openvpn-announce@lists.sourceforge.net
Message-ID: <d34d5974-30ac-6949-9be4-7f4a55126564@...515...>
Subject: Re: OpenVPN 2.4.8 released
References: <6a1b6995-67c1-e30b-bdc1-af1d5485fda5@...515...>
In-Reply-To: <6a1b6995-67c1-e30b-bdc1-af1d5485fda5@...515...>

--mDWKQQTvHusgdOP2dxiAeXz0wPO0wTiPF
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We recently found out that the code signing certificate the 2.4.8
Windows installers use expired a couple of weeks ago. I will get a new
certificate today evening (~6 hours) and push out new installers.

This problem only seems to affect the prompt you get when you
double-click on the installer executable. You probably see "Unknown
publisher" there. Besides that Windows seems to be perfectly happy with
the executables and libraries. That is the main reason why a problem
such as this was able to slip through testing.

Samuli

Il 31/10/19 12:27, Samuli Sepp=C3=A4nen ha scritto:
> The OpenVPN community project team is proud to release OpenVPN 2.4.8. It
> can be downloaded from here:
>=20
> <https://openvpn.net/community-downloads/>
>=20
> This is primarily a maintenance release with bugfixes and improvements.
> The Windows installers (I601) have several improvements compared to the
> previous release:
>=20
> * New tap-windows6 driver (9.24.2) which fixes some suspend and resume
> issues
> * Latest OpenVPN-GUI
> * Considerable performance boost due to new compiler optimization flags
>=20
> A summary of all included changes is available here:
>=20
> <https://github.com/OpenVPN/openvpn/blob/release/2.4/Changes.rst>
>=20
> A full list of changes is available here:
>=20
> <https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24>
>=20
> Please note that LibreSSL is not a supported crypto backend. We accept
> patches and we do test on OpenBSD 6.0 which comes with LibreSSL, but if
> newer versions of LibreSSL break API compatibility we do not take
> responsibility to fix that.
>=20
> Also note that  Windows installers have been built with NSIS version
> that has been patched against several NSIS installer code execution and
> privilege escalation problems:
>=20
> <https://community.openvpn.net/openvpn/wiki/NSISBug1125>
>=20
> Based on our testing, though, older Windows versions such as Windows 7
> might not benefit from these fixes. We thus strongly encourage you to
> always move NSIS installers to a non-user-writeable location before
> running them. Our long-term plan is to migrate to using MSI installers
> instead.
>=20
> Compared to OpenVPN 2.3 this is a major update with a large number of
> new features, improvements and fixes. Some of the major features are
> AEAD (GCM) cipher and Elliptic Curve DH key exchange support, improved
> IPv4/IPv6 dual stack support and more seamless connection migration when
> client's IP address changes (Peer-ID). Also, the new --tls-crypt feature
> can be used to increase users' connection privacy.
>=20
> OpenVPN GUI bundled with the Windows installer has a large number of new
> features compared to the one bundled with OpenVPN 2.3. One of major
> features is the ability to run OpenVPN GUI without administrator privileg=
es.
>=20
> For full details, look here:
>=20
> <https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24>
>=20
> The new OpenVPN GUI features are documented here:
>=20
> <https://github.com/OpenVPN/openvpn-gui>
>=20
> Please note that OpenVPN 2.4 installers will not work on Windows XP.
>=20
> For generic help use these support channels:
>=20
> Official documentation:
> <http://openvpn.net/index.php/open-source/documentation/howto.html>
> Wiki: <https://community.openvpn.net>
> Forums: <https://forums.openvpn.net>
> User mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
> User IRC channel: #openvpn at irc.freenode.net
>=20
> Please report bugs and ask development questions here:
>=20
> Bug tracker and wiki: <https://community.openvpn.net>
> Developer mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
> Developer IRC channel: #openvpn-devel at irc.freenode.net (requires
> Freenode registration)
>=20
>=20
> Samuli
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20



--mDWKQQTvHusgdOP2dxiAeXz0wPO0wTiPF--

--oo8fg4qWgVjZf1JK2bvSoSqLJ51jpNSif
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl26zd0ACgkQKVhNn0CG
RXgoZwgArLptqvXLLt81G4tyAugiXdOd/5MgsiFOdKwBHtrODnZbbAlSzKRA2ySa
tsSuwLkpMEppFhHrdlwK9MMa92Ce5r8/IGJPcTdzU5PBoaP8KfK8sSM8czyTEU5t
MFT+8kl8wXzu/GrQoVJdmS7otJAicP2+Wcen25XkEa/dcWB3MlzuvQaEUINInjYa
d2ksg017XyGVO6byWcH+STQOMJz/3059GErKy1zQ/kErrK6S+wRR3Ul9JLblSSEw
WInwQ9/PipxxLaamViOer1VPg0CWgTfNnWXbnXqlENqzwmgriYzjz0HXgypb0JoV
ZZ3dvnVNiiW5EUZR73pkcQxU5m4kzQ==
=FETI
-----END PGP SIGNATURE-----

--oo8fg4qWgVjZf1JK2bvSoSqLJ51jpNSif--

