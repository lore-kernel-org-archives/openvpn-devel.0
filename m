References: <e6f1b674-b382-0626-03c8-a20e0fbefc1b@...2080...>
	<1491996924-24576-1-git-send-email-steffan.karger@...1435...>
	<024c8d0b-b82d-4ea2-2445-9c57bf734c83@...1435...>
	<afa63dbb-715c-8775-2ac9-4dbdf0e7aaf5@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <193f3a1c-dab5-f1f1-7ed4-f34740c066a0@...1435...>
Date: Thu, 13 Apr 2017 15:37:13 +0200
MIME-Version: 1.0
In-Reply-To: <afa63dbb-715c-8775-2ac9-4dbdf0e7aaf5@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RHSVSw8fBIUoTOnPbMxdkqnX3eqsTJMT5"
Subject: Re: [Openvpn-devel] [PATCH v2] Add --tls-cert-profile option for
 mbedtls builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--RHSVSw8fBIUoTOnPbMxdkqnX3eqsTJMT5
Content-Type: multipart/mixed; boundary="mlHDfsQus0w6osFrHrif0RsX8JQTU8PJl";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <193f3a1c-dab5-f1f1-7ed4-f34740c066a0@...1435...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add --tls-cert-profile option for
	mbedtls builds
References: <e6f1b674-b382-0626-03c8-a20e0fbefc1b@...2080...>
	<1491996924-24576-1-git-send-email-steffan.karger@...1435...>
	<024c8d0b-b82d-4ea2-2445-9c57bf734c83@...1435...>
	<afa63dbb-715c-8775-2ac9-4dbdf0e7aaf5@...2080...>
In-Reply-To: <afa63dbb-715c-8775-2ac9-4dbdf0e7aaf5@...2080...>

--mlHDfsQus0w6osFrHrif0RsX8JQTU8PJl
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 13-04-17 15:09, David Sommerseth wrote:
> I'm however a bit puzzled of the "non-changes" (well, the indenting is
> changing, unless I'm blind to other changes) to --remote-cert-cu,
> --remote-cert-tls and --ns-cert-type.  If we want to change the
> indenting, I think that should be kept in a separate patch, and keep
> --tls-cert-profile as a patch of its own.

Ah, indeed.  The indenting change is needed to make Github parse the rst
correctly.  Feel free to remove the indenting changes and I'll send a
follow-up patch doing just that.

> On a more generic note to this patch.  I wonder if we should keep
> "legacy" the default in the v2.4 branch.  In the Fedora 26 (and
> Rawhide/27) builds I had to do something similar [1] to keep users
> happy.  As OpenVPN isn't ready for OpenSSL v1.1, I had to switch to mbed
> TLS.  Unfortunately that haven't been as successful as I really hoped it
> would be, but that's an entirely different story (and mail thread).  As
> long as the Fedora builds need to be built with mbed TLS, I will need to
> ensure 'legacy' is the default there for a while.  For the coming Fedora
> Rawhide (which will be F28), I can make some announcements preparing
> users to move to stricter defaults.
>=20
> [1]
> <http://pkgs.fedoraproject.org/cgit/rpms/openvpn.git/tree/0001-workaround=
-Allow-weaker-RSA-keys-and-MD-algorithms-i.patch?h=3Df26>

The current mbed TLS builds already reject legacy crypto (except the
fedora packaged build, apparently).  With this patch users have the
ability to use legacy stuff again, but I would prefer to not go any
further than that.  I think we should encourage people to drop the
legacy.  Just like the browser vendors are doing.

And for Fedora, they chose to experience intense pain when they chose to
go for OpenSSL 1.1 this fast, that's their problem I guess...  If they
want to be that cutting edge, they should also stop using legacy crypto.
 And otherwise, it will be a simple patch in the fedora packaging.

-Steffan


--mlHDfsQus0w6osFrHrif0RsX8JQTU8PJl--

--RHSVSw8fBIUoTOnPbMxdkqnX3eqsTJMT5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY738RAAoJEEEwndWOY1w5ZjEIAI3zkTb9feWmkn/FHja8p4tn
Ri4UxLX5ol1DLb17xrqmu5LNBOwlLoBMn4APXAVOoCDwF+czjQnCEWzC2gvgH+gP
v+jTJTpTXsfJ9ZuKj8Zx0VjcBJtVgQdyugqyoDd5CPIYn8wU4X+6tQU1v9ebDOhX
hVHBeDc7tBfgi0LrDn8HihLVxU0nGipzwX7MpX2wvuE1/wftWQCNSMlVxUs8H+KE
yJhAYz8fHoFWNLdOGeYJ9GgQeCiYBrKVnsT+d272tzz8DfK2k5kRQdcOmaebat/T
+DKfQ67udswNiSTDKFqXCvMjCql+CYu9QfaQwN6GXTV4q9uGe+D577QLt8hwQNo=
=pasw
-----END PGP SIGNATURE-----

--RHSVSw8fBIUoTOnPbMxdkqnX3eqsTJMT5--

