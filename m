From: Till Maas <opensource@...519...>
Date: Sun, 12 Oct 2008 23:48:44 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart305968290.YIbVueOfQV";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200810122349.00935.opensource@...519...>
Subject: [Openvpn-devel] [PATCH] wrong error message for failing TUNSETGROUP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn devel <openvpn-devel@lists.sourceforge.net>

--nextPart305968290.YIbVueOfQV
Content-Type: multipart/mixed;
  boundary="Boundary-01=_9Cn8IESwy0Y+S5t"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_9Cn8IESwy0Y+S5t
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hiyas,

currently openvpn prints that TUNSETOWNER failed if TUNSETGROUP failed.=20
Attached patch fixes this.

Btw. it seems that the kernel shipped with CentOS does not support --group=
=20
with --mktun, in case someone wants to document it somewhere.

Regards,
Till

--Boundary-01=_9Cn8IESwy0Y+S5t
Content-Type: text/x-diff; charset="us-ascii";
	name="openvpn-2.1_rc13-tunsetgroup_errormessage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="openvpn-2.1_rc13-tunsetgroup_errormessage.patch"

diff -up openvpn-2.1_rc13/tun.c.tunsetgroup_errormessage openvpn-2.1_rc13/tun.c
--- openvpn-2.1_rc13/tun.c.tunsetgroup_errormessage	2008-10-12 23:40:24.548623210 +0200
+++ openvpn-2.1_rc13/tun.c	2008-10-12 23:40:31.964621830 +0200
@@ -1279,7 +1279,7 @@ tuncfg (const char *dev, const char *dev
         msg (M_ERR, "Cannot get group entry for %s", groupname);
       else
         if (ioctl (tt->fd, TUNSETGROUP, group_state.gr->gr_gid) < 0)
-          msg (M_ERR, "Cannot ioctl TUNSETOWNER(%s) %s", groupname, dev);
+          msg (M_ERR, "Cannot ioctl TUNSETGROUP(%s) %s", groupname, dev);
     }
   close_tun (tt);
   msg (M_INFO, "Persist state set to: %s", (persist_mode ? "ON" : "OFF"));

--Boundary-01=_9Cn8IESwy0Y+S5t--

--nextPart305968290.YIbVueOfQV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iQIVAwUASPJwvWo6ELMcEJUXAQIs/RAAq42setdpZiNa99XLxDB5EUGndcIV3xdh
/AznOT7EHo3eSYu4d/6vW/CyCGAwx5Sq2UmSrSfTN4IQzSvqyrbIKtcKNYa3Hn1e
xKQkbNmkFZpswcpHWhD4i01z7HREkW85jjcEjjobPdvjVFugUCAQJiu2Xf+setmG
QRN042FYRGUGTtK4VD/R+ynrMGL9M07UG+J9dSMbCLIhxz967uXiaY/RstR0k6AU
oPE5s21SBcg6+mzjSSQzA77LMt3AiGltuXJaNthHy621ibvr/pLWVIgviqVmZbZV
Kwx9+vNpLeugOvnyrezFJ6nhMIDVUNCT93vSrIy9xaWKxsZP3cXvXoUU6NkEr291
lPXNbaP1eDb9RVupjnns9zi5ZmI/b7o4s7BQV6p57uKHxjQsZmZ9VVPgWv85xZHc
jKDrwo6jNMY2QjHVYyg4UrbgVem8IEJ/+l2gk0pNitQANIjQLBr93Cv4jAOfHU2B
GPvjSvim/diD6HPCYd534K7SZPLH/Rym8dym/qOsZC8YO3TT/6CQ5nhOfkdFJBP5
a3WnzrY1oP/NO9QtZ32+KVyJVQm4UTUahm1hoHrjRWzr9vNJMU12M12ily7DE1j2
wvM9uw58iW8EER3w8RliavviShf5+epi1OWgv2sTyly67aDXStqUOi6euHJj49M5
6ozwsd5qBTs=
=W3qb
-----END PGP SIGNATURE-----

--nextPart305968290.YIbVueOfQV--

