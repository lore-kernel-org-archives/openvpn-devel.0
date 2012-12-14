Date: Fri, 14 Dec 2012 19:18:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121214181815.GQ22465@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlSMH5l3zSLowFdz"
Content-Disposition: inline
Subject: [Openvpn-devel] coverity issue 2 - dead default / code cleanup in
	mtcp.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--UlSMH5l3zSLowFdz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

next one: mtcp.c, about line 470:

  unsigned int flags =3D MTP_NONE;

  if (TUN_OUT(c))
    flags |=3D MTP_TUN_OUT;
  if (LINK_OUT(c))
    flags |=3D MTP_LINK_OUT;

  switch (flags)
    {
    case MTP_TUN_OUT|MTP_LINK_OUT:
    case MTP_TUN_OUT:
      newaction =3D TA_TUN_WRITE;
      break;
    case MTP_LINK_OUT:
      newaction =3D TA_SOCKET_WRITE;
      break;
    case MTP_NONE:
      if (mi && socket_read_residual (c->c2.link_socket))
        newaction =3D TA_SOCKET_READ_RESIDUAL;
      else
        multi_tcp_set_global_rw_flags (m, mi);
      break;
    default:
      {
        struct gc_arena gc =3D gc_new ();
        msg (M_FATAL, "MULTI TCP: multi_tcp_post bad state, mi=3D%s flags=
=3D%d",
             multi_instance_string (mi, false, &gc),
             flags);
        gc_free (&gc);
        break;
      }
    }



coverity is complaining that the "default:" clause can never be reached,
as all the possible values for "flags" are covered - and it's obviously
right.  It's not something critical, more a "code cleanup" thing.

(The whole usage of switch/case here reeks a bit, given that I think the=20
code would be simpler by directly setting "newaction" depending on
"if (TUN_OUT(c))" etc., not bothering with "flags" in the first place)

Cleanup in 2.4?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--UlSMH5l3zSLowFdz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUMttZ6kuBuNlUUl1AQI+XgP+LiZhg1QISiSTN2BPmjM8gpNSzkb9UJ3Q
MLBXVu+Q0roWraDw/jBEF37v3w7IPPTTF9aT+eqGdTwUbvZ3BXt2KbluUVMeFG9a
frTkNzdezsnRdWDUg2HIxnobbwJy3aVCEflk77HnbbPxTmrU+FFP8tsU9Ogsljtu
QiQpNHTczU4=
=PU3p
-----END PGP SIGNATURE-----

--UlSMH5l3zSLowFdz--

