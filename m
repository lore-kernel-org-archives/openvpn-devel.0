Date: Sat, 21 May 2016 11:54:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160521095424.GQ53051@...1296...>
References: <1463822525-2532-1-git-send-email-openvpn-devel@...2127...>
	<1463822525-2532-2-git-send-email-openvpn-devel@...2127...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+KjDhyVkVl9ZTxoC"
Content-Disposition: inline
In-Reply-To: <1463822525-2532-2-git-send-email-openvpn-devel@...2127...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Refactor t_client.sh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@...2127...
Cc: openvpn-devel@lists.sourceforge.net

--+KjDhyVkVl9ZTxoC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, May 21, 2016 at 11:22:04AM +0200, openvpn-devel@...2127... wrote:
> +# ----------------------------------------------------------
> +# global variables
> +# ----------------------------------------------------------
> +
> +# list of succeeded tests (e.g. 1 2 3)
> +declare  SUMMARY_OK=3D""
> +
> +# list of failed tests
> +declare  SUMMARY_FAIL=3D""
> +
> +# number of failed checks for a test (# of calls to fail())
> +declare -i fail_count=3D0

Generally speaking, I'm in favour of reworking t_client.sh and making
the output more readable, etc. - it was a quick hack, and more polishing
would be welcome.

I'm not exactly sure about the shell constructs you use, specifically
arrays and varaible declarations - is that posix shell, or "bash"?

This script needs to run on all platforms we support, and that includes
more esoteric ones like AIX and Solaris - OpenSolaris /bin/sh is a ksh93
variant (nowadays), so if it works in ksh and dash (Debian /bin/sh), I'm=20
fine...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--+KjDhyVkVl9ZTxoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV0AwUKkuBuNlUUl1AQIuwQQAkc0T3cVinBoBIls0m09tAIfbOQo1TW1G
Qi9O1jiQkEav0LpjvB7MMeARRpJuxpZbvVqmPfM1zWLciHinw5salyNpD3bYqtra
am0HRxxMw5sRKLCo6tKGRRgfmiqbm/EY2i/Nn0T8ON65RPrmlmThcUV/EiAvjWSt
bOg4JGdlpfg=
=i0D8
-----END PGP SIGNATURE-----

--+KjDhyVkVl9ZTxoC--

