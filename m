Date: Thu, 8 Dec 2011 11:22:49 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111208102249.GP18948@...1296...>
References: <1323301588-29815-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <1323301588-29815-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Move away from openvpn_basename() over
	to platform provided basename()
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

--T7mxYSe680VjQnyC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 08, 2011 at 12:46:28AM +0100, David Sommerseth wrote:
> This kicks out the openvpn_basename() function from misc.[ch] andputs
> it into compat.[ch].  This is to provide the same functionality on
> platforms not having a native basename() function available.

Agree with this in principle, but...

> diff --git a/compat.h b/compat.h
> new file mode 100644
> index 0000000..d44ab56
[..]

> +#ifndef HAVE_DIRNAME
> +static inline char *
> +dirname(char *str)
> +{
> +  return openvpn_dirbasename(str, DIRNAME);
> +}
> +#endif /* HAVE_DIRNAME */

... I don't think we should put even more code into .h files than we
already have.  This is not a performance critical call, and it makes
following the sources so much harder if actual functions are hidden in
header files.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTuCP+akuBuNlUUl1AQKAhAP/RNNxWK9d12JGFJ06yXl8sRxmPLqNjJ6R
gPmOXxaxJkPvkM7kBtEX59YWd+/VuugfZGqrE1E2Lp0GxxvSPXDj3e2muEGfLC1P
eavBvtp1i+XX8H4zBtRsRTuVrsVadlWYm9+bjYBGfC9U0/zsJeNG4oR4ZnnhFzht
DC1Orrz1uiw=
=+WwR
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--

