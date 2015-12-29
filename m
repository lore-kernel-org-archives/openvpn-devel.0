Date: Tue, 29 Dec 2015 21:07:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151229200710.GP24952@...1296...>
References: <1451404984-6048-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zpr2sLAIjR0wKPza"
Content-Disposition: inline
In-Reply-To: <1451404984-6048-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Detecting Windows version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--zpr2sLAIjR0wKPza
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 29, 2015 at 06:03:04PM +0200, Lev Stipakov wrote:
> * Use adapter name instead of index on WinXP - sadly XP does not support =
indexes
> * Write Windows version to log
> * Send it with peer-info as IV_PLAT_VER

Overall, I'm fine with the patch - thanks a lot.=20=20

I've built release/2.3 + patch on ubuntu 14.04 and tested on XP SP3, and
it nicely worked - sending IV_PLAT_VER=3D5.1 ("WIN_XP"), and using interface
name again.

A few small details (half of them already discussed on IRC):

 - please send IV_PLAT_VER only if the client requested this (push-peer-inf=
o)
   (this is slightly more sensitive information, comparable to library
   versions, and when introducing library versions in IV_SSL, we decided
   to not send such information by default)

 - and please send a patch of the windows version bits for master ("all but
   the changes against route.c and tun.c" :) )

 - src/compat/compat-versionhelpers.h needs to be listed "somewhere"
   (src/compat/Makefile.am libcompat_la_SOURCES=3D... maybe?) so that
   "make dist" will include it into the generated .tar.gz

>  #elif defined (WIN32)
>=20=20
> -  struct buffer out =3D alloc_buf_gc (64, &gc);
> -  buf_printf (&out, "interface=3D%d", tt->adapter_index );
> -  device =3D buf_bptr(&out);
> +  if (win32_version_info() !=3D WIN_XP)
> +    {
> +	struct buffer out =3D alloc_buf_gc (64, &gc);
> +	buf_printf (&out, "interface=3D%d", tt->adapter_index );
> +	device =3D buf_bptr(&out);
> +    }

the indentation on these is off - they are indented with a full <tab>
but our funny 2.3 convention requires *six* spaces here...  (sorry for
being a pain... trying to be consistent)

Same thing for delete_route_ipv6().

Functionally, this all looks perfectly fine (I only tested on XP, but
as the rest is just existing code, it will "obviously" work for the
non-XP case).

[..]
> +int
> +win32_version_info()
> +{
> +    if (!IsWindowsXPOrGreater())
> +    {
> +        msg (M_FATAL, "Error: Windows version must be XP or greater.");
> +    }
> +
> +    if (!IsWindowsVistaOrGreater())
> +    {
> +        return WIN_XP;
> +    }

I'm not sure if this is the canonical best version to deal with it or
not, but I don't particularily *want* to get myself involved into this.

If someone else thinks this needs improvement (like, working Win10
detection :-) ) I'm all open to accept additional patches on top of it,
but to solve our immediate needs, this is good enough for me and does=20
not *need* changes.

thanks, and waiting for v2 :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--zpr2sLAIjR0wKPza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVoLn3qkuBuNlUUl1AQLQSQQAndqsfCt90IJhJTjQrSsgn5uE+2e5BR1V
F0+e8nYrw0xGPMx2iwtOQbVaVWSRLmqVBTVS3BTCbdWsrled6A6j1NfawEHa6QQ8
dd8IRju9WCSSOrDtGwtCMDbDcqWqDfOEWN1F+xkQakR1R5qJTzbzHhoDMSpSmN50
sEBgAA4kCsc=
=0a5S
-----END PGP SIGNATURE-----

--zpr2sLAIjR0wKPza--

