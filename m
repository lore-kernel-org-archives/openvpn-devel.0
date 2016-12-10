References: <20161209183724.5c11d987@...1799...>
	<20161209231907.16486-1-list@...1798...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ddf0e5be-0590-7da6-d0e2-5e21e3225bc1@...2080...>
Date: Sat, 10 Dec 2016 01:03:39 +0100
MIME-Version: 1.0
In-Reply-To: <20161209231907.16486-1-list@...1798...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="TsxHdQn1HE3QwW4N4T28bXDHIbKMptJPx"
Subject: Re: [Openvpn-devel] [PATCH 1/1] bind mount systemd notification
 socket into chroot
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>, David Sommerseth <davids@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TsxHdQn1HE3QwW4N4T28bXDHIbKMptJPx
Content-Type: multipart/mixed; boundary="2qKuuL8I8rJ69JhokB4XWn4oG76DqEPol";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>,
	OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>, David Sommerseth <davids@...515...>
Message-ID: <ddf0e5be-0590-7da6-d0e2-5e21e3225bc1@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] bind mount systemd notification
	socket into chroot
References: <20161209183724.5c11d987@...1799...>
	<20161209231907.16486-1-list@...1798...>
In-Reply-To: <20161209231907.16486-1-list@...1798...>

--2qKuuL8I8rJ69JhokB4XWn4oG76DqEPol
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 10/12/16 00:19, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
>=20
> sd_notify() uses a socket to communicate with systemd. Communication
> fails if the socket is not available within the chroot. So bind mount
> the socket into the chroot when startet from systemd.
>=20
> Unsharing namespace and mounting requires extra capability CAP_SYS_ADMIN.

I will pick up this one after 2.4.0 has been released.  This is a very
promising approach.  However, I'm not too happy about CAP_SYS_ADMIN
though, that grants quite some privileges.  Can we look at dropping this
capability once we know we won't need it any more?  Perhaps when we send
READY=3D1?

> +              char * chroot_notify =3D NULL;
> +
> +              if (sd_notify(0, "READY=3D0") > 0)
> +                {
> +                  asprintf(&chroot_notify, "%s/notify", c->options.chroo=
t_dir);

Here we should use the buffer/string functions, based on the gc_arena
implementation.  Unfortunately we do not have a direct equivalent to
asprintf().  A starting point would be to for example look at the string
handling in print_sockaddr_ex() [socket.c:2386] or x_msg_va()
[error.c:251] ... there might be better examples too, I'm just not able
to remember them now :)  .... buffer.[ch] keeps most of these functions.

The reason for this is basically to use the same well tested
infrastructure.  And with gc_arena, only a single gc_free() is required,
regardless of how many buffers you allocate to that arena.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--2qKuuL8I8rJ69JhokB4XWn4oG76DqEPol--

--TsxHdQn1HE3QwW4N4T28bXDHIbKMptJPx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYS0ZbAAoJEIbPlEyWcf3yntYQAKbvQfZ3+/0BXPSwiLuoBDGb
8j62wOVulGWrP1YXyUFD2W7QlzRT7DWvy0O7Xoxpb9ldnk0oN7bKnrXUPtBAgPxJ
ELi5/QWl44jJru42lmhkqUlETsNFCvxUvST0v2sCeDGn5uxpHHSAaKZDh5Oonhe0
7xXHvWQTmAZcIGmAl58h3iXlhBdM7SrSv+3Aw9LsvjtXS1WmBa2Q5ZVYxwMhtW69
l/lYlE+THDgjrAxI4X6ciw45PmZ/3wiF2Q3CZ8R4PpyplBngkDVy8ZwtR9oH2aHB
V6DKFa4+bEUTJDDaG6JJFNYd47H9I/zCi8oFl6gBtJISVpXqv8OGbDUVMNd7tacg
GK4b4Muky2nkEomXB9L3zAruxCnXQvUy5D61n7yoxi+W63liez5wgZ+V05elNxG9
GIx6LkKJio5aaxuwHdezGWmpqrs1nqOkDUcaETVLdcmdGhlM9cvC/4DJkkiGd0kq
0q+O1uL2xT7KEXenvyenoZ/AF1Y7CrjxUHLGpip9MMXdFtLKwYeJ4ZiadjPmRddG
6ocgxl6Jremxcbnr0SQe02jJoZnJe12tuXAtvkgxd/dMlCHRL6KVqkIDYNowMbe2
AENuouVewMZ7eyI5BCvLWqNRIGvGQnQoF/6tf9CBDJP1lQYZDvACJtHbFfQZF7F3
dM5TjaZJrprx6SmN17V/
=RUUl
-----END PGP SIGNATURE-----

--TsxHdQn1HE3QwW4N4T28bXDHIbKMptJPx--

