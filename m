Resent-Message-ID: <20090609092401.GA31033@...1226...>
Resent-To: openvpn-devel@lists.sourceforge.net
Date: Tue, 9 Jun 2009 10:59:37 +0200
From: Jan-Frode Myklebust <janfrode@...1225...>
Message-ID: <20090609085937.GA29364@...1226...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
Subject: [Openvpn-devel] specfile fix (no managemenet)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--PmA2V3Z32TCmWXqI
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I can't find any "management" directory in the openvpn-2.1-rc18.tar.gz,
and the openvpn.spec file fail to build when it can't find it. Also
added a comment about how to build the RPM without PKCS11, so please
apply :-)



  -jf

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="openvpn.spec.diff"
Content-Transfer-Encoding: quoted-printable

--- ../../../openvpn-2.1_rc18/openvpn.spec	2009-06-07 08:48:33.000000000 +0=
200
+++ openvpn.spec	2009-06-09 11:35:24.000000000 +0200
@@ -2,6 +2,9 @@
=20
 # OPTIONS
 #
+# Disable PKCS11
+#   rpmbuild -tb [openvpn.x.tar.gz] --define 'with_pkcs11 0'
+#
 # Disable LZO
 #   rpmbuild -tb [openvpn.x.tar.gz] --define 'without_lzo 1'
 #
@@ -223,7 +226,7 @@
 %endif
=20
 # Install extra %doc stuff
-%doc contrib/ easy-rsa/ management/ sample-*/ plugin/README.*
+%doc contrib/ easy-rsa/ sample-*/ plugin/README.*
=20
 %changelog
 * Thu Dec 14 2006 Alon Bar-Lev

--ZGiS0Q5IWpPtfppv--

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFKLiR55zjUY2TLWqARAukoAJsEfVQeZeduzwn7Z2vHcEqXpYYOiACgkHyy
ar/ZsFcoWAIW58l1aa1W9KE=
=5Ktj
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--

