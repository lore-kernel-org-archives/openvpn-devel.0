Date: Tue, 25 Dec 2012 13:48:56 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121225124856.GT22465@...1296...>
References: <50D6F4EA.6050504@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ceiKzP3Ly84zZ4d5"
Content-Disposition: inline
In-Reply-To: <50D6F4EA.6050504@...1227...>
Subject: Re: [Openvpn-devel] Crash on duplicate PUSH_CONTROL message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--ceiKzP3Ly84zZ4d5
Content-Type: multipart/mixed; boundary="r/9DUdLmUVHbFUch"
Content-Disposition: inline

--r/9DUdLmUVHbFUch
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 23, 2012 at 01:11:22PM +0100, Arne Schwabe wrote:
> I fear we may have to delay the final release. While debugging a problem=
=20
> with a user of my app I found a nasty bug which causes OpenVPN to crash=20
> if two PUSH_CONTROL messages are received.

The appended patch fixes this for me (Client on Linux/i386, but that=20
should be OS and architecture agnostic).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--r/9DUdLmUVHbFUch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Fix-client-crash-on-double-PUSH_REPLY.patch"
Content-Transfer-Encoding: quoted-printable

=46rom f38ff2ee809f85b6a7c1dc08bb8cf9bfc350070f Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Tue, 25 Dec 2012 13:41:50 +0100
Subject: [PATCH] Fix client crash on double PUSH_REPLY.

Introduce an extra bool variable c2.pulled_options_md5_init_done to
keep track of md5_init state of pulled_options_state - avoid accessing
uninitialized state when a second PUSH_REPLY comes in (which only happens
under very particular circumstances).

Bug tracked down by Arne Schwabe <arne@...1796...>.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/openvpn.h |    1 +
 src/openvpn/push.c    |    7 ++++++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 7abfb08..bdfa685 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -474,6 +474,7 @@ struct context_2
   bool did_pre_pull_restore;
=20
   /* hash of pulled options, so we can compare when options change */
+  bool pulled_options_md5_init_done;
   struct md5_state pulled_options_state;
   struct md5_digest pulled_options_digest;
=20
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 05a38e0..be50bef 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -446,10 +446,14 @@ process_incoming_push_msg (struct context *c,
       if (ch =3D=3D ',')
 	{
 	  struct buffer buf_orig =3D buf;
+	  if (!c->c2.pulled_options_md5_init_done)
+	    {
+	      md5_state_init (&c->c2.pulled_options_state);
+	      c->c2.pulled_options_md5_init_done =3D true;
+	    }
 	  if (!c->c2.did_pre_pull_restore)
 	    {
 	      pre_pull_restore (&c->options);
-	      md5_state_init (&c->c2.pulled_options_state);
 	      c->c2.did_pre_pull_restore =3D true;
 	    }
 	  if (apply_push_options (&c->options,
@@ -463,6 +467,7 @@ process_incoming_push_msg (struct context *c,
 	      case 1:
 		md5_state_update (&c->c2.pulled_options_state, BPTR(&buf_orig), BLEN(&bu=
f_orig));
 		md5_state_final (&c->c2.pulled_options_state, &c->c2.pulled_options_dige=
st);
+	        c->c2.pulled_options_md5_init_done =3D false;
 		ret =3D PUSH_MSG_REPLY;
 		break;
 	      case 2:
--=20
1.7.8.6


--r/9DUdLmUVHbFUch--

--ceiKzP3Ly84zZ4d5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUNmguKkuBuNlUUl1AQIg+gP/ZM22mB0aaMuEiYcbpHjkPWBJqzyLDw5k
PBApnWlyXEaWCvxHfV2m8D3GnlXoz1EzvJicvoKlJUEmIre1k51O3Fzh0GgNMKlO
bl6OMhoJvVyxOU/mLXlzQd7t51rdveQIA0ebadtJuzXe3YqEgJO34JwM5D58GKkF
SAzcULzKDAo=
=Gdwz
-----END PGP SIGNATURE-----

--ceiKzP3Ly84zZ4d5--

