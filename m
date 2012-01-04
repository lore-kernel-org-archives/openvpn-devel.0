Date: Wed, 4 Jan 2012 21:50:00 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120104205000.GZ5060@...1296...>
References: <d3f7c10b2411aa41afce3788970ca839@...1528...>
	<4EE08E3A.7010209@...1114...>
	<CAOazyz1MCx8x42YK6-fQs0iAzDS0kRLvZ1sw4hvmcZ4gikJrUA@...278...>
	<4EE0EDA4.2090704@...1338...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oIMVlEQ///Q2JYC7"
Content-Disposition: inline
In-Reply-To: <4EE0EDA4.2090704@...1338...>
Subject: Re: [Openvpn-devel] [PATCH] Add option to disable priority tagged
	packets (VID=0)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fabian Knittel <fabian.knittel@...1338...>
Cc: alon.barlev@...277..., davids@...1347..., "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--oIMVlEQ///Q2JYC7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 08, 2011 at 06:02:28PM +0100, Fabian Knittel wrote:
> What I was meaning to ask: Did you guys come up with some kind of test
> framework in the last year?  I was looking at creating something like
> that for the VLAN patchset, but it was far too time intensive for my
> extremely limited OpenVPN time budget ...

There's the t_client.sh/t_client.rc frame work, which works quite well
to run well-defined=20

  - invoke openvpn (-client) like *this*
  - then test that ping to *that* list of addresses works

test sets.  Creating the tests can be a bit of a nuisance, but after
that it really eases automated testing :-)  (and of course you need
a known-working reference server).


Automated testing of the server end is a bit more tricky, and thus not
yet done.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--oIMVlEQ///Q2JYC7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTwS7eKkuBuNlUUl1AQKEOwQAp1YAa7mmVRN6JN7DNhFElpGbEifqp4lK
K6ez00af39N1aHtBOldBQadUt2Jg87F9sRblU4Ba6EIS2gamMaGdKZgYsj/RzvOa
2XzNQWTGhbtxySeVwC+d1RMw4aA+l3Qwi1T7D2DnjCILWf+RQcAj/MEInFSSvfKY
4rf3yq5ZokY=
=3tRp
-----END PGP SIGNATURE-----

--oIMVlEQ///Q2JYC7--

