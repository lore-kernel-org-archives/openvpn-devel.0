Date: Tue, 24 Nov 2015 09:39:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151124083944.GY24952@...1296...>
References: <564BA6DB.4070703@...2070...>
	<564DE8B3.9030803@...2070...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WZeJG8ZfZjbXm/g1"
Content-Disposition: inline
In-Reply-To: <564DE8B3.9030803@...2070...>
Subject: Re: [Openvpn-devel] [PATCH v4-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WZeJG8ZfZjbXm/g1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 19, 2015 at 06:20:19PM +0300, ValdikSS wrote:
> This option blocks all out-of-tunnel communication on TCP/UDP port 53 (ex=
cept
> for OpenVPN itself), preventing DNS Leaks on Windows 8.1 and 10.

Indeed, what Selva said - the patch is whitespace-mangled.  Valdikss,=20
could you please send it with "git-send-email"?

> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1468,6 +1468,20 @@ do_open_tun (struct context *c)
>   		   "up",
>   		   c->c2.es);
>   +#if defined(WIN32)
> +      if (c->options.block_outside_dns)
> +      {

these extra blanks should not be there...  thus it won't apply without
force.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--WZeJG8ZfZjbXm/g1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlQiT6kuBuNlUUl1AQLRWgP5ASlTQdPzqk4zMk68ptb07MIzFFmujJQt
8dkw8T2xthVFPR+bB72CyK0nP6sC1rfeb6AkuBwXgqQQjcsWMSkNLYO8U7xL1Mh6
ADtHVou/EGqUIgLaHOsfBewDQrNFiLd4AMIs8CdqWSA27DMRsFfQMZvs3YNu5Dag
q+4vA069fiE=
=PrrA
-----END PGP SIGNATURE-----

--WZeJG8ZfZjbXm/g1--

