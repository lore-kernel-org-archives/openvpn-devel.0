Date: Tue, 18 Feb 2014 12:50:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140218115015.GW16637@...1296...>
References: <5302AADC.80801@...277...> <20140218085500.GU16637@...1296...>
	<530340C4.5060702@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xh9GJMgkD8Kj4g3J"
Content-Disposition: inline
In-Reply-To: <530340C4.5060702@...277...>
Subject: Re: [Openvpn-devel] ECDH support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: pietrek -- <pietrek.j@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--xh9GJMgkD8Kj4g3J
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 18, 2014 at 12:15:16PM +0100, pietrek -- wrote:
> > Which parts of the key handshake does it cover?  Signature/Certificates,
> > or *only* DH?
> Handshake only, EC certificates worked for me without doing anything.
> Also, DH didn't work with EC certificates( no such cipher ).

I see.

Seems what we need as well is a README file that explains about EC crypto,
as in=20

 - how do I generate and use an EC certificate?
 - how do I use an EC curve for DH?
 - how do I use EC for session keying?

because otherwise our users will be even more confused than I am.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--xh9GJMgkD8Kj4g3J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUwNI96kuBuNlUUl1AQLvgwP/VGJRbw9nUB2/yMNNV+xWz0KacLNVIqm3
0u65vWRd3wOd3OuDv+ntIAL/LqXcmg1tHZbLpHqClnAWywa21pEhsvIW9G5aZoLb
n65+IGJzE9sAHwbjADa0JJeLFwHVVaK5priHClj+Rc3epdkAn7fXGSkH9C0iKCPQ
+8m8sHYjisQ=
=fv62
-----END PGP SIGNATURE-----

--xh9GJMgkD8Kj4g3J--

