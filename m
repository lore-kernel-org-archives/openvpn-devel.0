Date: Sun, 28 Apr 2013 13:35:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130428113548.GP20843@...1296...>
References: <1367006045-13576-1-git-send-email-arne@...1227...>
	<1367006045-13576-3-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Content-Disposition: inline
In-Reply-To: <1367006045-13576-3-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [[Patch v3] 3/3] Android platform specific
	changes.
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

--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 26, 2013 at 09:54:05PM +0200, Arne Schwabe wrote:
> +/*
> + * The android control method will instruct the GUI part of openvpn to
> + * do the route/ifconfig/open tun command.=20
> + */
> +bool management_android_control (struct management *man, const char *com=
mand, const char *msg)
> +{
> +  struct user_pass up;=20=20=20=20
> +  strcpy(up.username, msg);
> +=20=20
> +  management_query_user_pass(management, &up , command, GET_USER_PASS_NE=
ED_OK,(void*) 0);
> +  return strcmp ("ok", up.password)=3D=3D0;
> +}
>  #endif

Much better :-) - but if I may voice some extra wishes... :-)

  CLEAR(up);
  strncp(up.username, msg, sizeof(up.username)-1);

"just to be sure"

> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 8eb112b..ade9aad 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -725,6 +726,14 @@ create_socket (struct link_socket *sock)
>      {
>        ASSERT (0);
>      }
> +#ifdef TARGET_ANDROID
> +    struct user_pass up;
> +
> +    management->connection.fdtosend =3D sock->sd;
> +    management_android_control (management, "PROTECTFD", __func__);
> +
> +#endif
> +=20=20=20=20

A stray "struct user_pass" is dangling around here :-) - and I think this
code would be helped by a comment

   /* pass socket FD to management interface to pass on to VPN API=20
    * as "protected socket" (exempt from being routed into tunnel)
    */

[..]
> +  /* Set the actual name to a dummy name */
> +  tt->actual_name =3D malloc(sizeof(ANDROID_TUNNAME));
> +  strcpy(tt->actual_name, ANDROID_TUNNAME);

Uh... strdup()?  And malloc return value checking?

... but besides these, I think we're getting close :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUX0JlKkuBuNlUUl1AQLTMAP/biDt7vhX/seSubSlxubDzZeXxT6ZDeHQ
w09iKmj63Wk84sozV2B9nvZhAfx58C3NR67rjCx970wyS47sTgQaUrUPs+Udf//o
iqoszgPlysSRmukiEp64jRcWyq9/l3HdfIfmDC3NEh1IMaRWj3IvG6k4iuKNQBR/
mo2e/YZQPYU=
=Xrj6
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--

