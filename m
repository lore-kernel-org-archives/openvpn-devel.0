Date: Sat, 10 Dec 2016 13:08:37 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161210130837.49dd32b5@...1799...>
In-Reply-To: <ddf0e5be-0590-7da6-d0e2-5e21e3225bc1@...2080...>
References: <20161209183724.5c11d987@...1799...>
	<20161209231907.16486-1-list@...1798...>
	<ddf0e5be-0590-7da6-d0e2-5e21e3225bc1@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/xYHa5YRkuWaLIekkW4NP6Xd";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH 1/1] bind mount systemd notification
 socket into chroot
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Christian Hesse <mail@...1798...>, openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>

--Sig_/xYHa5YRkuWaLIekkW4NP6Xd
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

David Sommerseth <openvpn@...2080...> on Sat, 2016/12/10 01:03:
> On 10/12/16 00:19, Christian Hesse wrote:
> > From: Christian Hesse <mail@...1798...>
> >=20
> > sd_notify() uses a socket to communicate with systemd. Communication
> > fails if the socket is not available within the chroot. So bind mount
> > the socket into the chroot when startet from systemd.
> >=20
> > Unsharing namespace and mounting requires extra capability
> > CAP_SYS_ADMIN.=20=20
>=20
> I will pick up this one after 2.4.0 has been released.  This is a very
> promising approach.  However, I'm not too happy about CAP_SYS_ADMIN
> though, that grants quite some privileges.  Can we look at dropping this
> capability once we know we won't need it any more?  Perhaps when we send
> READY=3D1?

Never tried to drop capabilities... Have to look into that.
We do no longer need CAP_SYS_ADMIN after the bind mount. (Or not at all
without chrooting.)

> > +              char * chroot_notify =3D NULL;
> > +
> > +              if (sd_notify(0, "READY=3D0") > 0)
> > +                {
> > +                  asprintf(&chroot_notify, "%s/notify",
> > c->options.chroot_dir);=20=20
>=20
> Here we should use the buffer/string functions, based on the gc_arena
> implementation.  Unfortunately we do not have a direct equivalent to
> asprintf().  A starting point would be to for example look at the string
> handling in print_sockaddr_ex() [socket.c:2386] or x_msg_va()
> [error.c:251] ... there might be better examples too, I'm just not able
> to remember them now :)  .... buffer.[ch] keeps most of these functions.
>=20
> The reason for this is basically to use the same well tested
> infrastructure.  And with gc_arena, only a single gc_free() is required,
> regardless of how many buffers you allocate to that arena.

I do not like this myself. The patch is just a proof of concept... So this
should be polished before committing. ;)

Thanks for the hints, I will have a look.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/xYHa5YRkuWaLIekkW4NP6Xd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlhL8EUACgkQiUUh18yA
9HYRUggAzZydIuLv0XRfXOWCM8s+C0Q8HrSG7vCz76JP9QwW++bzp9NvSqrcLW9K
DwLDaF3hD3DsXncWR9yjgCMLD69CXss51YKkRY/2Si732uwdI/z7fY4+5CQODxSa
b9e3QzPw890P2kh8U6qwKSoXJ9TEru7E2ZvwOx9P33WQCb2ixAaPS+8RL/PuMGMU
IB/GxZ3E41CHYoo68a4wKW2v+VKyjBINTKI0vjE4Pwi6DUOtMKfuS4ZHJLeASAyH
iUvaiA6Y80/v26J4rK1QgwSADdAtYsB2cs5+QXuWed0ZDZ1pGIu1VGiWXb0z6RsW
sFK90E6rN/U+IYxaKrrm9mZGPt40wQ==
=UsvU
-----END PGP SIGNATURE-----

--Sig_/xYHa5YRkuWaLIekkW4NP6Xd--

