Date: Mon, 22 Sep 2025 12:24:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aNEj7-Vvo6VZe2Xu@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aIFWhDRiWATZ9iwe"
Content-Disposition: inline
Subject: [Openvpn-devel] 2.6.15 commit push mishap
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--aIFWhDRiWATZ9iwe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

just so it's clear that nobody external is manipulating our git repos=20
- I'm working on the v2.6.15 release commit, and due to fat fingers / bad
timing a "not quite ready" version slipped out to github and gitlab.

I have now force-pushed the "this should be the final commit" to all
repos, so it's consistent, and hopefully the window where the wrong
commit is out there is small enough that not so many people will get
surprised by this.

The current "this is likely to be 2.6.15" commit is

commit 90bdd59a95170169585a171d4993ba0b1851a3f9
Author: Gert Doering <gert@...1296...>
Date:   Sun Sep 21 15:50:10 2025 +0200

    preparing release 2.6.15

the one that accidentially escaped was

commit be4d38d142c162537316b271b81cfe4432695c06
Author: Gert Doering <gert@...1296...>
Date:   Sun Sep 21 15:50:10 2025 +0200

    preparing release 2.6.15

... which is based on the same parent (t_net.sh fix, so no actual
difference in *code* here), the difference is in last-minute fixes to
"Changes.rst" and "ChangeLog".

No erroneous tags have been pushed.

Apologies for being too impatient and messing this up.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--aIFWhDRiWATZ9iwe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJo0SPvAAoJEB2Cnv7KVigSvy8L/1sLw+z0lR74Iil8jdDH+3+6
b/iQyNepx9dS4FaHBBxiH4krZs4vcZVWW6Vq35EOkwkuvLpMKkfVBGinY23xt+fb
ok3bDtyZbBD8+SxFsGZakeMxBH+4HGXxbIV+NcXI6MlpcRTzNikHrjFtI7+IdaIn
cQslnAid6Y5nFmreM0RZj9VygqznVV96R+pQrpKajoUnRmuZxrsw1x01Xb24OTl3
8O5Z/xrcUjmJ1EXORs4udOxIuB4vzhDBX9yUKis7MUJhB2eqkVJttmx0BUo+8Y1B
g4iEmaDYtZOt7kSnkzyziL9t9ypszSBOJKgRPtYI78F4MtQyAPGhyqw3y3J1f46r
msavQ8MYS1jOcFik+SQqj8pmxLIaz+rqFchRlc0u1TFOmA74ppDx793tP95y0QOk
tEnraiw+6zI3s8PwBsp/Fw7zmVtUSTW6iBxxxra2Lfvyp53PaIIfcODBsPkfqcLV
Z1jMdGa1FPHqSbm8PJMiq09CmdCSmeyzUlz5w3pfPw==
=tphf
-----END PGP SIGNATURE-----

--aIFWhDRiWATZ9iwe--

