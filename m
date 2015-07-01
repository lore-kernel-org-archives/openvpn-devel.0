Date: Wed, 1 Jul 2015 17:40:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150701154039.GG382@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r4XptB1irwxzaV4E"
Content-Disposition: inline
Subject: [Openvpn-devel] RfD: speed up PUSH_REQUEST...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--r4XptB1irwxzaV4E
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

experimenting with the MTU patch, I discovered that we basically sit
idle for two seconds on the client between "TLS is up!" and "PUSH_REQUEST".

This is part due to the coarse granularity of, well, our coarse timers,
but in part due to *two* timers having to fire...

- TLS is done, we schedule an "wait_for_connect" timer to fire in +1 second
  (init.c, do_init_timers())

- when that timer fires, 1 second after TLS completes, we set up *another*
  timer inside check_connection_established_dowork(), that is intended to
  fire in +1 second

- +1 second later, we send PUSH_REQUEST

due to the calling sequence and check_push_request() being called right
after check_connection_established(), it seems to be fairly safe to just
set up the event to "fire right away" (*having* the event is needed to
be able to reset it to "fire again in +5 seconds").

So, with the patch below on top of the MTU patch, connection times to a
server which is 150ms away from me went down from 5 seconds to 2 seconds
- which I consider quite significant :-)

Anyone better versed in the history of this code who can tell me whether
this is safe, or why the extra delay is there?

gert




diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6d459d2..e1571ec 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -212,8 +212,8 @@ check_connection_established_dowork (struct context *c)
 					0);
 		}
 #endif
-	      /* send push request in 1 sec */
-	      event_timeout_init (&c->c2.push_request_interval, 1, now);
+	      /* fire up push request right away (already 1s delayed) */
+	      event_timeout_init (&c->c2.push_request_interval, 0, now);
 	      reset_coarse_timers (c);
 	    }
 	  else
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--r4XptB1irwxzaV4E
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVZQJ96kuBuNlUUl1AQK9rwQAorvir4UVB5gCT46UJGk5MWOv4H1+/G0q
Phg9sKGwDLnQcF562xqrAVmE97MLpgWUWooOfDNbxReWWHKBAKyuLjHaJrJeL+1V
m1U+AlrFjT963WPPRo/v5E392zqnAMigrZU2ZCHFE5FurWD+X9VAdt/oZ1ovXXOG
iq5XjZCBUK0=
=7Vzq
-----END PGP SIGNATURE-----

--r4XptB1irwxzaV4E--

