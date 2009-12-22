Date: Tue, 22 Dec 2009 14:07:09 +0100
From: Frederic Jaeckel <jchome@...1283...>
Message-ID: <20091222140709.3563c8f7jchome@...1283...@jc-ix.net>
In-Reply-To: <20091222121545.6310972bjchome@...1283...@jc-ix.net>
References: <20091222121545.6310972bjchome@...1283...@jc-ix.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	boundary="Sig_/JjGFB2HqhYdVjK8GvVM9wBT";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] Setting lladdr in NetBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Sig_/JjGFB2HqhYdVjK8GvVM9wBT
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Ok, after some heavy testing this won't fix the problem.

Besides NetBSD wants an 'activate' after the lladdr, NetBSD won't
calculate the inet6 address using the set lladdr, because somehow the
ifconfig command will be provided _before_ the lladdr is set. Even the
generic openvpn based lladdr is set _before_ the custom lladdr is set.

Dunno why, but it has to be fixed anyway. I'll look deeper into that in
my free time soon.

regards,
Frederic Jaeckel

On Tue, 22 Dec 2009 12:15:45 +0100
Frederic Jaeckel <jchome@...1283...> wrote:

> Hi,
>=20
> todays openvpn isn't supporting NetBSDs way to set the lladdr for
> tap(4) devices.
>=20
> Here's the patch to support this.
>=20
> Please integrate this in the next release.
>=20
> best regards and thanks for the work,
> Frederic Jaeckel
>=20
> --- lladdr.c    2009-12-22 12:08:23.000000000 +0100
> +++ lladdr.c.b  2009-12-22 12:08:14.000000000 +0100
> @@ -36,6 +36,11 @@=20=20
>                     "%s %s lladdr %s",
>                     IFCONFIG_PATH,
>                     ifname, lladdr);
> +#elif defined(TARGET_NETBSD)
> +  argv_printf (&argv,
> +                   "%s %s link %s",
> +                   IFCONFIG_PATH,
> +                   ifname, lladdr);
>  #elif defined(TARGET_DARWIN)
>    argv_printf (&argv,
>                     "%s %s lladdr %s",

--Sig_/JjGFB2HqhYdVjK8GvVM9wBT
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkswxH0ACgkQ33vaRvWgIxRsOACfZsT9S+OFSXK7MNrzcX/Qx/n6
Xj0AoIixWvaxgNIxjHGTOQNDoe3vMf2W
=XHzk
-----END PGP SIGNATURE-----

--Sig_/JjGFB2HqhYdVjK8GvVM9wBT--

