Message-ID: <54E10A03.3000400@...1227...>
Date: Sun, 15 Feb 2015 22:05:07 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <20150124170446.GA504@...2009...>
In-Reply-To: <20150124170446.GA504@...2009...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="EFMag9UnbSX6KUPI3KInxUQ8Q35aXqPF4"
Subject: Re: [Openvpn-devel] [PATCH v3] Mac OS X Keychain management client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vasily Kulikov <segoon@...2008...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EFMag9UnbSX6KUPI3KInxUQ8Q35aXqPF4
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 24.01.15 um 18:04 schrieb Vasily Kulikov:
> This patch adds support for using certificates stored in the Mac OSX
> Keychain to authenticate with the OpenVPN server.  This works with
> certificates stored on the computer as well as certificates on hardware
> tokens that support Apple's tokend interface.
>
> This patch version implements management client which handles RSA-SIGN
> command for RSA offloading.  Also it handles new 'NEED-CERTIFICATE'
> request to pass a certificate from the keychain to OpenVPN.
>
> OpenVPN itself gets new 'NEED-CERTIFICATE" command which is called when
> --management-external-cert is used.  It is implemented as a multiline
> command very similar to an existing 'RSA-SIGN' command.
>
> The patch is against commit 3341a98c2852d1d0c1eafdc70a3bdb218ec29049.
>
>
ACK from me to the OpenVPN part. I also tested the patch in OpenVPN for
Android and the RSA-SIGN still works as expected. I have not reviewed
the OS X contrib program (other than a quick glance at the code) but I
think marking it as contrib it should be allowed to be still included.

Arne


--EFMag9UnbSX6KUPI3KInxUQ8Q35aXqPF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlThCgQACgkQe8+cMNS4zRd9XgCcCJ0tcoEF0UqmWyAKruZY87QA
52IAn2chk5F6oOZVCM5SFH3yIZYqUNzZ
=538s
-----END PGP SIGNATURE-----

--EFMag9UnbSX6KUPI3KInxUQ8Q35aXqPF4--

