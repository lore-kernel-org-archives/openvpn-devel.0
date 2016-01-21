Date: Thu, 21 Jan 2016 22:59:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160121215912.GR24952@...1296...>
References: <1439311312-2682-1-git-send-email-openvpn.list@...1114...>
	<1439311312-2682-3-git-send-email-openvpn.list@...1114...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p5b0PktyBqVim8XT"
Content-Disposition: inline
In-Reply-To: <1439311312-2682-3-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/4] Re-implement the systemd support
 using the new query user API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--p5b0PktyBqVim8XT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 11, 2015 at 06:41:50PM +0200, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> This provides exactly the same systemd functionality which existed
> before the query user infrastructure got implemented.
>=20
>  [v2 - Removed the QUERY_USER_FOREACH macro]

A few nags...

> +
> +
> +if ENABLE_SYSTEMD
> +#
> +# If --enable-systemd have been used, build the alternative systemd mech=
anism
> +# The CFLAGS macro set here ensures the alternative mechanism is being u=
sed.
> +# See console.h for more information.
> +#
> +AM_CFLAGS +=3D -DQUERY_USER_EXEC_ALTERNATIVE
> +openvpn_SOURCES +=3D console_systemd.c
> +endif

Why make it so complicated?  We have #ifdef ENABLE_SYSTEMD already, so
we could just do this in the console.h header file...

#if defined(ENABLE_SYSTEMD) || defined(MAGIC_OTHER_CONSOLE) || ...
# define QUERY_USER_EXEC_ALTERNATIVE
#endif

IOW, we have way too many corners that spring C #define's into life,
and I don't think we should invent yet a new one without very good reason
- especially if that needs a long comment to explain why it's there.

Thinking more about it - why not just always add console_systemd.c to
openvpn_SOURCES (which, I think, is also relevant for "make dist", no?)
and *inside* console_systemd.c wrap it with=20

  #if defined(ENABLE_SYSTEMD)
  ..
  #endif

so it gets compiled into an empty .o - like we do with win32.c or the
ssl_$library.c variants today, so it seems to work on enough platforms=20
to not worry about that.  Plus, it's "what we do elsewhere"...

[..]
> diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
> new file mode 100644
> index 0000000..a9cfbe6
> --- /dev/null
> +++ b/src/openvpn/console_systemd.c
> @@ -0,0 +1,112 @@

This looks good to me, except for the #ifdef :-) - and...

> +/*
> + * is systemd running
> + */
> +
> +static bool
> +check_systemd_running ()

... any particular reason for not having a (void) in there?  Technically,
it's "moving code without changes" (good!) but while at it, you could
add this in 4/4 to be proper ANSI C :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--p5b0PktyBqVim8XT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVqFUr6kuBuNlUUl1AQJU7QQAqRAE7olDa9Oj4PWVbv3DrjHth2VVzhN+
a+B+oKWYBjLk7TnlTmqJ6GIjI9CFrDz3Sy7WMOxO2aspCDRR74kJOYDAiaWmhJJO
7NAoiJiuUxXSn4vqgjx3LPHhjGCXZt8IK1Dlni75M8p/LuQ1Yl0SMrnmS7x+GFdm
0y53aIQfU4A=
=GMLp
-----END PGP SIGNATURE-----

--p5b0PktyBqVim8XT--

