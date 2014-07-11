Date: Fri, 11 Jul 2014 14:38:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140711123855.GH1118@...1296...>
References: <1405075659-7881-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+8qnELIAc9OiRmNX"
Content-Disposition: inline
In-Reply-To: <1405075659-7881-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix server routes not working in
	topology subnet with --server
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

--+8qnELIAc9OiRmNX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 11, 2014 at 12:47:39PM +0200, Arne Schwabe wrote:
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -2704,7 +2704,7 @@ on sufficiently fast hardware.  SSL/TLS authenticat=
ion must
>  be used in this mode.
>  .\"*********************************************************
>  .TP
> -.B \-\-server network netmask
> +.B \-\-server network netmask ['nopool']
>  A helper directive designed to simplify the configuration
>  of OpenVPN's server mode.  This directive will set up an
>  OpenVPN server which will allocate addresses to clients
> @@ -2739,6 +2739,9 @@ expands as follows:
>     if !nopool:
>       ifconfig-pool 10.8.0.2 10.8.0.254 255.255.255.0
>     push "route-gateway 10.8.0.1"
> +   if redirect-gateway unset:
> +     redirect-gateway 10.8.0.1
> +=20=20=20=20=20=20

Typo here, this needs to be "route-gateway", of course.  But the
patch itself looks like an elegant way to get this done.

It might not actually *work* on all platforms - windows (tap, ethernet,
ARP!) might need this to be set to 10.8.0.2 - well, "anything that is not
itself".  Which won't be that hard to add either...  is this in host
format, as in "we can just add +1 to o->ifconfig_local and it will=20
work cross-endian"?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--+8qnELIAc9OiRmNX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU7/a36kuBuNlUUl1AQL5EQQAnKGPU8CyebUawBMJBZsZ7yBltt4YliFL
C/rQaRPIil7chTPVlh3zNhjbbYN1N1lzADp6uQUFLcIIIZMa0hKdIg9/e+OPkcQP
N7FD3OW2cX1Ad7jo+pHsOwy7ISkBpUkFhwC3aYgf9e5WKlGaazVbDr1CllT8zr//
H0FnmQ7ewbE=
=y1SG
-----END PGP SIGNATURE-----

--+8qnELIAc9OiRmNX--

