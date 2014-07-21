Message-ID: <53CD2C15.6080100@...1114...>
Date: Mon, 21 Jul 2014 17:04:53 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <11052645.930865.1405935348844.JavaMail.root@...1893...>	<20140721120346.GL1118@...1296...>
	<53CD0B1B.6000801@...515...>
In-Reply-To: <53CD0B1B.6000801@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="w0hLbXaLSOAEFoD8quNCIP5S55CbvfK8u"
Subject: Re: [Openvpn-devel] OpenSSL in OpenVPN software to be replaced?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, Gert Doering <gert@...1296...>, Lisa Minogue <lminogue@...1892...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w0hLbXaLSOAEFoD8quNCIP5S55CbvfK8u
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 21/07/14 14:44, Samuli Sepp=E4nen wrote:
> Although we probably can all agree
> that the state of OpenSSL leaves a lot to be desired, it's now funded by
> the Core Infratructure Initiative:
>=20
> <http://www.linuxfoundation.org/programs/core-infrastructure-initiative>
>=20
> I don't know if money (=3Dfew full-time developers) can save the can of
> worms, but probably we should not panic quite yet. Opinions?

No libraries are perfect.  OpenSSL is also far from perfect.  But I
think the press and the OpenSSL-haters have abused their screen time
somewhat much too.  So, I would say: No need to panic.

It takes long to really build confidence in a crypto library, just like
the math behind cryptographic functions.

Currently, PolarSSL is more attractive because of the smaller code base
(but also less support for features OpenSSL have).  So PolarSSL is
easier to do a proper code review on.  But also bear in mind that
PolarSSL had their first releases around early 2009.  OpenSSL was
released mid/late 1990's.  The age difference is 10 years(!).

I more strongly believe we will have a more secure world if it is more
unpredictable which SSL implementation is being used.  So I welcome
PolarSSL very much, and I believe that just their _presence_ and being
used by some of our users are important.  Just as well as I'd like to
see someone looking at an NSS implementation in OpenVPN.


--=20
kind regards,

David Sommerseth


--w0hLbXaLSOAEFoD8quNCIP5S55CbvfK8u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPNLBUACgkQDC186MBRfromGwCcCBZRbto7aatoccfRiBh+JE+a
O0EAnj9XKHveYmG+tNaFvCk0fyH+3lx3
=vaKj
-----END PGP SIGNATURE-----

--w0hLbXaLSOAEFoD8quNCIP5S55CbvfK8u--

