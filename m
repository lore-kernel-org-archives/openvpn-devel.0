Date: Sat, 1 Feb 2025 08:54:39 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Z53TP7qTBJSc8tca@...1296...>
References: <20250201062437.4059652-1-dqfext@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9FhD9zER+AlqRpT/"
Content-Disposition: inline
In-Reply-To: <20250201062437.4059652-1-dqfext@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] dco: fix source IP selection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Qingfang Deng <dqfext@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--9FhD9zER+AlqRpT/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 01, 2025 at 02:24:37PM +0800, Qingfang Deng wrote:
>  #endif
> +    if (sock->bind_local && sock->info.lsa->bind_local) {
> +        localaddr =3D sock->info.lsa->bind_local->ai_addr;
> +    }
> +

This is still not correct style - the opening "{" needs to go on its own
line.  Also see below on whether this is necessary at all.

>      int ret =3D dco_new_peer(&c->c1.tuntap->dco, multi->peer_id,
> -                           c->c2.link_sockets[0]->sd, NULL, remoteaddr, =
NULL, NULL);
> +                           c->c2.link_sockets[0]->sd, localaddr, remotea=
ddr, NULL, NULL);
>      if (ret < 0)
>      {
>          return ret;
> @@ -550,7 +555,7 @@ dco_multi_get_localaddr(struct multi_context *m, stru=
ct multi_instance *mi,
>          {
>              struct sockaddr_in *sock_in4 =3D (struct sockaddr_in *)local;
>  #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
> -            sock_in4->sin_addr =3D actual->pi.in4.ipi_addr;
> +            sock_in4->sin_addr =3D actual->pi.in4.ipi_spec_dst;
>  #elif defined(IP_RECVDSTADDR)
>              sock_in4->sin_addr =3D actual->pi.in4;

Well spotted.

>  #else
> @@ -616,10 +621,15 @@ dco_multi_add_new_peer(struct multi_context *m, str=
uct multi_instance *mi)
>          vpn_addr6 =3D &c->c2.push_ifconfig_ipv6_local;
>      }
>=20=20
> +    struct link_socket *ls =3D c->c2.link_sockets[0];
>      if (dco_multi_get_localaddr(m, mi, &local))
>      {
>          localaddr =3D (struct sockaddr *)&local;
>      }
> +    else if (ls->bind_local && ls->info.lsa->bind_local)
> +    {
> +        localaddr =3D ls->info.lsa->bind_local->ai_addr;
> +    }

Not sure about that.  If the socket is bound, the kernel knows about
the binding (because we pass the socket to the kernel).  You're sure this
is needed?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--9FhD9zER+AlqRpT/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnndM/AAoJEB2Cnv7KVigS0uQL/A+Gv7DENGlh5pxUObWQPNI0
61KfhlHmIjnWUNsD7pm4KQLm9JZTp3MTvghS+2VYt9Jl/97qEbdqnnL71brPiilU
VUYaAO/c5XlamxrgXTrV+oIJ0YqN53fR4Yhr7/DOZbkYvQ5Rs1HGYjtn/hOW8m1q
6gHATLx9t4/IyTqkIzx41QS7DurPP0g1HMyIh+r88gnWSmxUhYJ0fY7n/YGnIus4
r6CrQIoTkA/onM75bENT2OWKgB/K7ctaHx9uGnIdpYfNX7SoeJB40aqf0SXrdS9q
TSjMcrlEuhouGthIVArLrJgH7wdtnveuyXjtPVijs47S//EmPPNAN1sxwT+CUbb2
R5Lh0E6V+pEgPhXDIC/4E0A5cWA1/bbCDZx4zfOTo7xVLJRhSKBp129AaTL7XuV3
y+G4x522gOwXN6D93PXVpNMjBVJdVw+9HQSiuKl3fyGxUfEhVjW0Jjl7eOr+ijrD
TOvyMnq8600qXmoL79jTbp4dDKO/Ej/lJRmVVtgqIA==
=1SBR
-----END PGP SIGNATURE-----

--9FhD9zER+AlqRpT/--

