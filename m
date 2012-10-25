Message-ID: <5089796B.6070803@...1114...>
Date: Thu, 25 Oct 2012 19:39:55 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CA+=Fv5QP9FY3AZoxfV62kG7rP0mU3Ad2UVtzt_LGTYONUJW9PA@...278...>
In-Reply-To: <CA+=Fv5QP9FY3AZoxfV62kG7rP0mU3Ad2UVtzt_LGTYONUJW9PA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFA42DEF449F150F2FAB53860"
Subject: Re: [Openvpn-devel] openvpn on solaris
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Magnus Lindholm <linmag7@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA42DEF449F150F2FAB53860
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 25/10/12 18:24, Magnus Lindholm wrote:
> Hi all,
>=20
> with openvpn-2.2.2 I get "unable to redirect default gateway -- Cannot
> read current default gateway from system" on my solaris sparc box.
> Maybe I missed something but I solved this by putting together some
> code into a patch to route.c that lets openvpn read the default
> gateway correctly on solaris boxes (.SunOS 5.11 snv_151a sun4u) Let me
> know if anyone is interested in incorporating this functionality into
> openvpn

Hey Magnus!

Thanks a lot for digging into this, and I hope you can dare to share a
patch with us here on the mailing list.  First of all, it would be good
if we could get this patch based upon the latest openvpn code base, and
if you even can manage it as a git patch that would be really great!

We have some info on how to contribute here:
<https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>

This will all help the review process.  I believe Gert who already
replied have some hands-on experience with Solaris as well, so I hope he
can have some time to help review your patch(es) as well.

If we get a patch rather soonish, we can probably manage to squeeze such
a fix into the very soonish 2.3_RC1 release.


kind regards,

David Sommerseth


--------------enigFA42DEF449F150F2FAB53860
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlCJeWsACgkQDC186MBRfrqLXACeNCWHSCLHIAh04r3FPjX97M+V
npYAnj1Ci2jjDO3ZDbmTE2CODgbZuAC9
=7xcB
-----END PGP SIGNATURE-----

--------------enigFA42DEF449F150F2FAB53860--

