Date: Sun, 30 Aug 2015 22:37:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150830203749.GW34798@...1296...>
References: <20150830002336.32791c7b.movrax-dev@...2061...>
	<20150830115444.GU34798@...1296...>
	<20150830162534.4ee0c9f2.movrax-dev@...2061...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wwSFAA0Com6UqrPP"
Content-Disposition: inline
In-Reply-To: <20150830162534.4ee0c9f2.movrax-dev@...2061...>
Subject: Re: [Openvpn-devel] [PATCH] Privileges not being dropped if the
 first connection is not successful
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Lukasz K." <movrax-dev@...2061...>
Cc: openvpn-devel@lists.sourceforge.net

--wwSFAA0Com6UqrPP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Aug 30, 2015 at 04:25:34PM +0200, Lukasz K. wrote:
> -  if (c->first_time && c0 && !c0->uid_gid_set)
> +  if (c0 && !c0->uid_gid_set)
>      {
>        /* chroot if requested */
>        if (c->options.chroot_dir)
>  	{
>  	  if (no_delay)
>  	    platform_chroot (c->options.chroot_dir);
> -	  else
> +	  else if (c->first_time)
>  	    msg (M_INFO, "NOTE: chroot %s", why_not);
>  	}

Looking a bit more closely at this one.  What happens if you do not
set uid/gid, but *do* set --chroot?  Will it then execute the chroot
call every single time (since effectively the first_time check is
removed, and c0->uid_git_set will never be set)?

Or am I misreading this?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--wwSFAA0Com6UqrPP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVeNpnKkuBuNlUUl1AQKkqQP/RIGZ3LF9DiV1tNT7gjk09prE4aaRinEc
FEI2yvWMWOCajbF2t5/S+kZRQkSLrvn0TnHF3IwRE7S7VmfxS0VmbQlIkkxUcNmn
l+mkVbiLy2q4KW4CoFVn6sAH5b5w0CmxVqZNMivtxezqDdESu9ZcKOWGSBknTenA
CUXOyERCbCw=
=EmUn
-----END PGP SIGNATURE-----

--wwSFAA0Com6UqrPP--

