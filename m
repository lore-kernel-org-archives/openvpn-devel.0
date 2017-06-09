Date: Fri, 9 Jun 2017 21:12:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170609191246.GD97029@...1296...>
References: <CAO5O-ELO64OT4zjNSLvXn2tNRj6eMi=z0zQsx1TGt29ioFAS2Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hYEzKNDjtsyo7/CP"
Content-Disposition: inline
In-Reply-To: <CAO5O-ELO64OT4zjNSLvXn2tNRj6eMi=z0zQsx1TGt29ioFAS2Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix a null-pointer dereference in
 establish_http_proxy_passthru()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Guido Vranken <guidovranken@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--hYEzKNDjtsyo7/CP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 08, 2017 at 11:56:38PM +0200, Guido Vranken wrote:
> +                if ( !realm || !nonce )
> +                {
> +                    goto error;
> +                }
> +

Generally, ACK, as it solves the problem at hand.

I would prefer to see an error message here, though - after all, we've=20
already started talking to the proxy, and all of a sudden we silently(!)
decide "this proxy is no good" - this is not helpful in the face of a=20
true malfunction on the proxy side (and generally not what openvpn=20
tries to do).

I'd add something like:

 msg(D_LINK_ERRORS, "HTTP proxy: digest auth failed, malformed response "
     "from server: realm=3D or nonce=3D missing" );

so it's easier to see why it is giving up.

thanks :)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--hYEzKNDjtsyo7/CP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZOvMuAAoJEB2Cnv7KVigS20MMAIhdby41sE8oxaZMiPJJVRId
DG0EFZz51UsvU5jhHrgVmNUJcRq84zrZ2NUURlDTPgOAmaVbNmn5TOFQjQ9JMezV
aYMPk0iMFL4SQ1VOP95CZ9DLr03SAi+bM5ggzhQy2uOIBSqxVMJUODPCF1A06ctp
yOwTbYG2sxyXX0Mhb/fkurBmBsg1gvJNxvFvZ7f7VL7BMyFUI96ZNchhrd93vL9f
E2PvI9GeK7dEYuVFle+MYQlGSh4K7UhoEQ6AXeOtLAQ+XOnKjeXLy4HDu+PNzTTC
HOopqrxufztinRzuu7LBZFMlzNY9QcdOCQ6hmLWB5eycSkrtxjg0gYCgrEUdX2Su
YAQPv8Rk0vTO9ZCVs1sRbdykPcmS8Jvbu5ufbtrJUi43FgyZlctry70TYtP9niNk
R+Lh8nRVglzEvmUpG5IQOYsO8449ebNRYVOqCnZ6VdwiSciO9lem9nnwfnUjKtWR
wL5D/+tpOpjadNe40LXoPBV10lYwJ4sJORRIPEK+dA==
=tA9f
-----END PGP SIGNATURE-----

--hYEzKNDjtsyo7/CP--

