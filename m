Message-ID: <53380F28.9020406@...1227...>
Date: Sun, 30 Mar 2014 14:33:44 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1396181376-32022-1-git-send-email-gert@...1296...>
In-Reply-To: <1396181376-32022-1-git-send-email-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="6Rr995OrjoFsBO0PxbxAKk1IBoeNc1p0U"
Subject: Re: [Openvpn-devel] [PATCH] Fix crash when using --inetd.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6Rr995OrjoFsBO0PxbxAKk1IBoeNc1p0U
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 30.03.14 14:09, schrieb Gert Doering:
> Change "local" argument to socket_do_listen() to avoid calling
> "local->ai_addr" in the caller for the "do_listen =3D=3D FALSE" case,
> in which case it could be NULL.
>
> Also, ensure "ai" is always initialized in socket_listen_accept() for
> the "!remote_dynamic" case - otherwise it will sometimes(!) crash in
> addrlist_match() later on.
>
> Get rid of spurious operator precedence warning concerning GETADDR_CACHE_=
MASK.
>
>
ACK.

Arne


--6Rr995OrjoFsBO0PxbxAKk1IBoeNc1p0U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlM4DygACgkQe8+cMNS4zRfXhwCgwWQKvij/2dWzApcsnUQsNzh6
zNcAoOZgIEW/+mhKZWwqyxvD/ctNUQIn
=DkYg
-----END PGP SIGNATURE-----

--6Rr995OrjoFsBO0PxbxAKk1IBoeNc1p0U--

