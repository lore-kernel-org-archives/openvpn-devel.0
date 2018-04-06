References: <20180401131615.12567-1-a@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e3d48a12-7f25-1ec0-ad7a-52c1330f43c0@...2181...>
Date: Fri, 6 Apr 2018 15:43:55 +0800
MIME-Version: 1.0
In-Reply-To: <20180401131615.12567-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8cUe3oxaaBdbx5uEyuiPFglskPsyp48L2"
Subject: Re: [Openvpn-devel] [RFC 0/4] add netlink support for Linux: update
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8cUe3oxaaBdbx5uEyuiPFglskPsyp48L2
Content-Type: multipart/mixed; boundary="5617ZDvyZXZLFWkVeTLmIVV7Z9nDlCRF1";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <e3d48a12-7f25-1ec0-ad7a-52c1330f43c0@...2181...>
Subject: Re: [Openvpn-devel] [RFC 0/4] add netlink support for Linux: update
References: <20180401131615.12567-1-a@...2181...>
In-Reply-To: <20180401131615.12567-1-a@...2181...>

--5617ZDvyZXZLFWkVeTLmIVV7Z9nDlCRF1
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

in case anybody cares, I have updated my patchset on GitHub[1] (I didn't
want to create more noise on the mailing list since it is still RFC).


This new version is quite different as I implemented a major
architectural change: instead of creating a standalone sitnl module, I
introduced a generic "networking API" (this is a concept that has been
discussed with Gert and other devs in the past, but that never came into
being).

This "networking API" is the glue code between tun.c/route.c and the
Linux specific code.

Two new files, namely networking_sitnl.c and networking_ip.c, provides
two implementations for this API: one uses the new sitnl code (netlink)
and one uses iproute2.

This new architecture could be re-used in the future to move other
platforms specific code (i.e. for drawin, openbsd, etc..) to their own
files and hide all the details behind the new API.


If you try to compile my branch, openvpn will use sitnl by default
unless you specify --enable-iproute2 at configure time.


Comments are review are welcome!


Cheers,

[1] https://github.com/ordex/openvpn/tree/sitnl


--=20
Antonio Quartulli


--5617ZDvyZXZLFWkVeTLmIVV7Z9nDlCRF1--

--8cUe3oxaaBdbx5uEyuiPFglskPsyp48L2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlrHJTsACgkQB6U8WA7y
zXSkSg//cNig6mz+sP+Ua1zR/3dkK4JWuhfngvYJo+GZNc8bYaDERzvQsHkZIdA4
k6QXGCpMvPJfIq9Vf9X3f15mO/28aCdD3O9Z9RChyn8wM0FB8BHwRHx6JHwn8l2q
EjiM68MgdzM9oKrBHY6V/3A4pWTc6EvzuW1PG8Om37ErK0SgfnxEuFPWg0RRRGae
VFqN9HhZgBgVdyVUNlBTzHSroUqveQyCpCLA0NdLdwKz7P/IiAEAi2ScFMMPnlek
AnRmOfUHGfActkjKL3yxpmX/waH1hVL2VUQYlymXLOYj75eSaroXt8XIlUTT5McZ
KOvZT5ofLhwnd4AhR+yNEAWK7TuWvFlfeLS4PGroKENB384IcE4C/FjyGIfU1yqN
v5vZ/i7txfzAJ2ve3VFGFdSMhfX8h8qXa8u3PPn36DOXNMlEdqEhAw/jxElZSBgA
wc0b9jm9+AkKIglsEq2xd9jtpuOZthhIK4WWBfq+PK9ScYxJVZSTS8PZXVzJJmr2
6PQ+QI3bCH18o+G5GngNRJhrmZa/+ekmGiC0GIkfizbihKJToGhIrDHn6v0bhWvR
K8P/lzO8UgnkMb+2i7Uf8M4HRn5L8rz37naTZVv0prHWXHzpMrWMfrJT6htryxyM
dphQc4JVMji7nQKK+4re+xfgIFLMB9tO5IFA3WkmKfg4EnWc+5E=
=0RP1
-----END PGP SIGNATURE-----

--8cUe3oxaaBdbx5uEyuiPFglskPsyp48L2--

