Date: Thu, 16 Jul 2020 21:25:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200716192532.GH1431@...1296...>
References: <20200716134315.17742-1-arne@...1227...>
 <20200716134315.17742-4-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="AIJHt11vbnUA7Dqz"
Content-Disposition: inline
In-Reply-To: <20200716134315.17742-4-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v7 4/6] client-connect: Add deferred
 support to the client-connect plugin v1 handler
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--AIJHt11vbnUA7Dqz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 16, 2020 at 03:43:13PM +0200, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
>=20
> Uses the infrastructure provided and used in the previous patch to provide
> deferral support to the v1 client-connect plugin handler as well.

start client jobs...
22...
Test sets succeeded: 1 2 3 4 6 8.
Test sets failed: none.
23.small...
Test sets succeeded: 1 2 3 4.
Test sets failed: none.
23...
Test sets succeeded: 1 1a 1b 1d 2 2a 2b 2c 2d 3 4 5 6 8 8a 9.
Test sets failed: none.
24...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 4a 5 6 8 8a 9.
Test sets failed: none.
master...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 5 5x 6 7 7x 8 8a=
 9 2f 4b.
Test sets failed: none.


(not actually testing any particulars of this patch yet, just keeping the
test rig busy)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--AIJHt11vbnUA7Dqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfEKmrAAoJEB2Cnv7KVigSWn4L/ilHsTmQLiGDh17t0ts5JQFJ
Q2M8NshxbpJbhjmKMcU9LEfpNj9yAcfmvI4YEx74o9csOpIViYO+WHPSeeObbOuh
JlTtNdlq/ZQiuy+c+/J1SgY3Iv9WA1gTz2AjNRenCB3PcHf9/c/kR8IER6w0AvSL
q7bghUCEp3WXdGqlK5kXNY/GHgJUAwF7RZ1ltcdLQPykiZOKjOBlg6TFTcPTsG5C
QI9aJdMDSwHprIDA9E63gA6yLSYBfnZJihxO6C5egeMptTvMxDcGixXJRuXUxXhN
4uT0urYobwuDzpP0aZJO+Jbgo3hEsF8SZgZntqjwCa7HygmZ71c8TnybZafl1sHO
/d72Yn/L8ReVYUI7NETHl3YYnimkNIc56kGK6irENyDzsrIpQD671XGuZHt/XGiz
ipLttL5c3OdY61YlbX1l2uXJPj2oxbCgTqowrTlUnIbSWYipS8c6Hem1ht0eSfAr
/yLUrbiJWSqpy1iYhsSLJWL/BCLn8t/zYXBvqYnSuw==
=VFs3
-----END PGP SIGNATURE-----

--AIJHt11vbnUA7Dqz--

