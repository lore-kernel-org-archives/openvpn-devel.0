Date: Mon, 29 Jun 2020 09:20:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200629072053.GK1431@...1296...>
References: <1593197385-30618-1-git-send-email-max@...1047...>
 <1593197385-30618-2-git-send-email-max@...1047...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EoQBMqkHWuh670Ll"
Content-Disposition: inline
In-Reply-To: <1593197385-30618-2-git-send-email-max@...1047...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Add --bind-dev option.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Maximilian Wilhelm <max@...1047...>
Cc: openvpn-devel@lists.sourceforge.net, Maximilian Wilhelm <max@...2564...>

--EoQBMqkHWuh670Ll
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

reading this more closely at merging/testing time, I do have a change
request...

On Fri, Jun 26, 2020 at 08:49:44PM +0200, Maximilian Wilhelm wrote:
> +#ifdef TARGET_LINUX
> +    else if (streq (p[0], "bind-dev") && p[1])
> +    {
> +        VERIFY_PERMISSION (OPT_P_SOCKFLAGS);
> +        options->bind_dev =3D p[1];
> +    }
> +#endif

One could argue whether the argument should be changed for IFNAMSIZ here
(so we can error-out right away if it's too long).  But this is just=20
something to consider.

> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -1138,6 +1138,14 @@ create_socket(struct link_socket *sock, struct add=
rinfo *addr)
>      /* set socket to --mark packets with given value */
>      socket_set_mark(sock->sd, sock->mark);
>=20=20
> +#if defined(TARGET_LINUX)
> +    if (sock->bind_dev)
> +    {
> +        msg (M_INFO, "Using bind-dev %s", sock->bind_dev);
> +        setsockopt (sock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_de=
v, strlen (sock->bind_dev) + 1);
> +    }
> +#endif

Here, we *must* have a return code check, and logging of an error message
if setsocktopt() fails.

Imagine someone calling "openvpn --bind-dev eht0" (because he has fat
fingers).  The current code will silently fail the setsockopt() - because
there is no such interface name - but nothing in the logs will show a hint
*why* openvpn is just not doing what requested.


Sorry for not spotting this in the first review.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--EoQBMqkHWuh670Ll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe+ZZUAAoJEB2Cnv7KVigSdzMMAKN7xylEkoynZbSNbCaCH+zD
oHlesyIpOuafA1RNcCo9mJIITNrMvUqrd2VUqWtDQM91TPenP0IU1GAGde4c83aS
vGPPgsKeGEJ7GjsD1zjk4Wq/nn4coVjevOxT7aGPaOkOq2MWBRDD44qb/c4PCWY+
aKNHcqCiQshLb/qGhFBHpJwDaUKvW6zzShFg40s62NlaZ5p4bM5vJaFUAnkyQfCH
cK3/KWSNF5NDTYz/pH17783EVrDvEaogEcHj/ZDudPEo6jYh83D+26NdjccqUalT
4b0ipPjwnyUvqArmzXUTLL5mJ4Wah3zW2JSs1FMLd7GRSr1xKh7w5EKjZ9+g0rDb
fsZKnkzx26VWICW7yQFEcpQCxGO4ReuYfPlK9sPO8EnkHSMGWUVy3999SGUUg+HR
qmpys0lbvh0k4bzOpQYlrJ/p3BFkvfGeXbXV0U9jplLnvmZtIafxoGNmuyA7IxR3
JzsYSA5Bd/C9ubJwZJm4iaHsg8K23IJDjPZfq+uYNA==
=KuKy
-----END PGP SIGNATURE-----

--EoQBMqkHWuh670Ll--

