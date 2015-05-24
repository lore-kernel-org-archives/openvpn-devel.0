Date: Sun, 24 May 2015 21:30:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150524193011.GK382@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LXsBfGm2MIDJcXyT"
Content-Disposition: inline
Subject: [Openvpn-devel] rfd: 'serial-tests' automake option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--LXsBfGm2MIDJcXyT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

somewhere between automake-1.11 and automake-1.14 the default for handling
"make check" changed from "serial-tests" to "parallel-tests" - which=20
sounds harmless, but has the interesting side effect of hiding the output
of all (potentially parallel-run) test scripts until the summary at the
end, and even then, only printing the summary, not the detail output.

I can see that this looks much more pretty (and colours, wooh!), but
for my day-to-day regression testing and for analyzing buildbot failures,
this just adds extra steps to figure out what it is doing right now, and
where and why it failed this time - especially in the buildbot case, the
difference is "the reason is right in the mail" vs "I need to login to
the buildbot machine, go to the right build directory (of many), and=20
grab the log file from there".


Fortunately, there is an automake option for this, which I'd propose to
enable... (well hidden inside "info automake-1.14" -> "Options")

diff --git a/tests/Makefile.am b/tests/Makefile.am
index b7980e0..02fa392 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -9,6 +9,8 @@
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
=20
+AUTOMAKE_OPTIONS =3D serial-tests
+
 MAINTAINERCLEANFILES =3D \
        $(srcdir)/Makefile.in
=20

... which brings back the old behaviour.

I'm not sure whether it can be passed on an "autoreconf -vif" command
line, and if yes, how, but I presume that really nobody who bothers to
run "make check" will be bothered by the normal test output - and especially
nobody who bothers to set up a t_client.rc test rig in the first place...

But I'm open for discussion and alternative suggestions on this.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--LXsBfGm2MIDJcXyT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVWImw6kuBuNlUUl1AQIGAQP/TrCrB4lsPhFxjcM/KbCjXiedU/vuM9jN
0m72yL6IL3h+cMXqFuuQeCQ7a3e+JdG56fKgJuWI4Oc+JzB8i+9eo9PiRJNWPOHb
741Bjp4oaRguEfrNRj28zsKOd3cOApBkbLfC7PPb9lbFhejih2PzG52vYJlAnpre
1gjTTw/zjSo=
=iLDy
-----END PGP SIGNATURE-----

--LXsBfGm2MIDJcXyT--

