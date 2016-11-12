Date: Sat, 12 Nov 2016 16:07:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161112150712.GF28918@...1296...>
References: <1478870201-17943-1-git-send-email-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JGRpDW+vuEVQ9uQb"
Content-Disposition: inline
In-Reply-To: <1478870201-17943-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] tun: Fix compiler warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--JGRpDW+vuEVQ9uQb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 11, 2016 at 02:16:41PM +0100, David Sommerseth wrote:
> @@ -917,6 +915,12 @@ do_ifconfig (struct tuntap *tt,
>        management_android_control (management, "IFCONFIG", buf_bptr(&out)=
);
>=20=20
>  #elif defined(TARGET_SOLARIS)
> +      const char *ifconfig_ipv6_remote =3D NULL;
> +
> +      if (tt->did_ifconfig_ipv6_setup )
> +        {
> +	  ifconfig_ipv6_remote =3D print_in6_addr (tt->remote_ipv6, 0, &gc);
> +        }

NAK :-) - if you clean it up, do it right.  Just stuff this into the
if clause where it is used, not introducing yet another if(), and make
the variable local to that block.


      if ( do_ipv6 )
        {
          argv_printf (&argv, "%s %s inet6 unplumb",
                            IFCONFIG_PATH, actual );
          argv_msg (M_INFO, &argv);
          openvpn_execve_check (&argv, es, 0, NULL);

          if ( tt->type =3D=3D DEV_TYPE_TUN )
           {
+	      const char *ifconfig_ipv6_remote =3D print_in6_addr (tt->remote_ipv=
6, 0, &gc);
              argv_printf (&argv,
                            "%s %s inet6 plumb %s/%d %s up",
                            IFCONFIG_PATH,
                            actual,
                            ifconfig_ipv6_local,
                            tt->netbits_ipv6,
                            ifconfig_ipv6_remote
                            );
            }


> @@ -1606,7 +1610,9 @@ open_tun_generic (const char *dev, const char *dev_=
type, const char *dev_node,
>        tt->actual_name =3D string_alloc (dynamic_opened ? dynamic_name : =
dev, NULL);
>      }
>  }
> +#endif // !WIN32 && !TARGET_LINUX

And NAK again - we do not do // comments.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--JGRpDW+vuEVQ9uQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWCcwIKkuBuNlUUl1AQKHYQP/T/MvGR+jUoths0YIFrwFcM9D4S4maANg
Qy7+R/x8Y6HHxYvYu0GGQTREBwDU1PBHjCfy9Lhmn6jFyRKMpUU4bmm36RuhEudi
A6T9doaEM3xXxl1JJKOxTWSw5YDVNyLGkirpvr6KG4deZKY6y3ZeuedHwLdNFtAv
RE7ElkG/dNE=
=cPNM
-----END PGP SIGNATURE-----

--JGRpDW+vuEVQ9uQb--

