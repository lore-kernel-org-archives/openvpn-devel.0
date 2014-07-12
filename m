Date: Sat, 12 Jul 2014 15:50:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140712135046.GS1118@...1296...>
References: <53BF9998.5020906@...1921...> <53C02A4E.6040103@...1147...>
	<53C02E63.9070909@...1856...> <53C07082.8060906@...1147...>
	<306985396.19324.1405156126494.JavaMail.zimbra@...1795...>
	<20140712094130.GM1118@...1296...>
	<63900614.19358.1405161674053.JavaMail.zimbra@...1795...>
	<20140712113109.GQ1118@...1296...>
	<1555229996.19407.1405169721263.JavaMail.zimbra@...1795...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MeI2286SkxeSCmZ5"
Content-Disposition: inline
In-Reply-To: <1555229996.19407.1405169721263.JavaMail.zimbra@...1795...>
Subject: Re: [Openvpn-devel] [PATCH] Add topology in sample server
	configuration file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--MeI2286SkxeSCmZ5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 12, 2014 at 02:55:21PM +0200, David Sommerseth wrote:
> > Well, OpenSSL considers this a "feature", not an "issue"... and being
> > able to turn off session resumption is also considered a "feature"...
>=20
> Ahh, right!
>=20
> I thought this was related to a CVE, but it seems not, according the
> OpenSSL changelog I found on the net [1].  SSL_OP_NO_TICKET comes with th=
e=20
> implementation of RFC4507, which was introduced in 0.9.8f.  I just double
> checked EL5, and it uses 0.9.8e as the base version.  According to the=20
> RPM changelog, I don't see that RFC4507 has ever been backported.

Ah.  So if that is correct, our simplistic implementation "if it is not
there, just #define SSL_OP_NO_TICKET 0" would be perfectly safe in this
regard, then.

> But it would be good if others can double this and see if I've understood=
 this
> correctly, just so I don't say anything wrong.

Indeed :-) - Steffann?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MeI2286SkxeSCmZ5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU8E9NqkuBuNlUUl1AQIUqwP9Gvt+1K69d53ijogBpQBujJEIzXXsl4+l
76XtFa2deyiRqOlFn7ogoWL5/pTXqSYLjQyt7DETfSNW5s6IfGXlT/TNX91IOzbU
LjsIE71S8uAWTge7uPT6KzbM1NJadUY4pwxL8ldjOVeRLQg7MdeqK5fsGyhA+RaW
LkDGy4MPZMg=
=+/DZ
-----END PGP SIGNATURE-----

--MeI2286SkxeSCmZ5--

