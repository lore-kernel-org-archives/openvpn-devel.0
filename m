Date: Wed, 21 Aug 2013 12:15:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130821101523.GH16543@...1296...>
References: <51C77F12.1090802@...515...> <5210B1EB.7000409@...1227...>
	<20130821072739.GG16543@...1296...>
	<52147A34.7050406@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4MTjg8yAiOaLjoFv"
Content-Disposition: inline
In-Reply-To: <52147A34.7050406@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] TLS versioning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, James Yonan <james@...515...>

--4MTjg8yAiOaLjoFv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 21, 2013 at 10:28:36AM +0200, Arne Schwabe wrote:
> Well I am not really sure what is going on on the Tomato firmware. I
> build a OpenSSL 0.9.7e (0.9.7e-3sarge3 to be exact, might already have
> some fixes in it, Tomato has 0.9.8d) on amd64 + OpenVPN 2.2.2 and that
> worked against 2.4-master. Before backing out the change or adding a
> backward fix I would like to understand what the real problem here is.

Yeah, fine with me.  I thought it was somewhat easily reproduceable
and affected a larger user base - "doing nothing except document that
this is a very rare ocurrance and can be fixed by <x>" is much better=20
than adding code :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--4MTjg8yAiOaLjoFv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUhSTO6kuBuNlUUl1AQIqEwQAmvgBAMlw9f+JYuieZnfzLO/OTqbW9m0S
y/KMpLepvrP2e1AdN5OIT3VwCoeqG+RWc0e46v4F6ZVrBsywaDSiYILxaZV8rlxA
5dD/p+RazGMKPQg3PUcsOZjG9oHsiuCueMF5bFFUbWzcfS7+XLplzlxS5N8vrL4F
seZcnaHQtSA=
=7YyH
-----END PGP SIGNATURE-----

--4MTjg8yAiOaLjoFv--

