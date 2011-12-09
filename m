Date: Fri, 9 Dec 2011 09:02:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111209080212.GC18948@...1296...>
References: <1323301588-29815-1-git-send-email-davids@...1347...>
	<1323357860-2506-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MzdA25v054BPvyZa"
Content-Disposition: inline
In-Reply-To: <1323357860-2506-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH v3] Move away from openvpn_basename()
	over to platform provided basename()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

--MzdA25v054BPvyZa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 08, 2011 at 04:24:20PM +0100, David Sommerseth wrote:
> This kicks out the openvpn_basename() function from misc.[ch] and puts
> glibc equivalents into compat.[ch].  This is to provide the same
> functionality on platforms not having a native basename() function
> available.
>=20
> In addition this patch adds dirname() which commit 0f2bc0dd92f43c91e
> depends.  Without dirname(), openvpn won't build in Visual Studio.
>=20
> v2: Move all functions from compat.h to compat.c
> v3: Use glibc versions of basename() and dirname() instead

ACK for the dirname() part.

I'm not particularily happy with the basename() changes, though.

> --- a/init.c
> +++ b/init.c
> @@ -862,8 +862,10 @@ init_verb_mute (struct context *c, unsigned int flag=
s)
>  void
>  init_options_dev (struct options *options)
>  {
> -  if (!options->dev)
> -    options->dev =3D openvpn_basename (options->dev_node);
> +  if (!options->dev && options->dev_node) {
> +    char *dev_node =3D strdup(options->dev_node); /* POSIX basename() im=
plementaions may modify its arguments */
> +    options->dev =3D basename (dev_node);
> +  }
>  }

These changes, just to take into account some system somewhere that
has a basename() implementation that modifies the argument string, are
ugly, and prone to memleak-errors.  Also, some other "basename(3)" man
pages talk about basename() returning a pointer to an internal static
storage which can be overwritten at the next call - so the code above=20
would then not work on such a system (as the next call to basename()=20
would modify the memory are where options->dev is pointing to).


So I'd propose to keep openvpn_basename() - it's simple and short enough,
and has well-defined semantics that can be relied upon.


OTOH, David's compat.c basename() is nicer than what we currently have -
so let's use that implementation, but let's call it openvpn_basename().

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MzdA25v054BPvyZa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTuHAhKkuBuNlUUl1AQJc+wP+MoUdFb443n+ofeI7dFPbkZfIbZx64C9l
BxX/Z9p4rnXhPYVQ1skiUgXPuDNsbNlqoR2qUtsx+PbuCfE6vipixa4KwvcDqIHp
bS0vsXmePaCjH8oXzoLpzxpOound1HQVxw0sthBY4nMk5h84gFRsp7SlV7hoHAe8
7teQMrUanDU=
=RcxY
-----END PGP SIGNATURE-----

--MzdA25v054BPvyZa--

