Date: Thu, 3 Sep 2015 17:23:16 +0200
From: "Lukasz K." <movrax-dev@...2061...>
Message-ID: <20150903172316.7fbadb2f.movrax-dev@...2061...>
In-Reply-To: <20150830203749.GW34798@...1296...>
References: <20150830002336.32791c7b.movrax-dev@...2061...>
	<20150830115444.GU34798@...1296...>
	<20150830162534.4ee0c9f2.movrax-dev@...2061...>
	<20150830203749.GW34798@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	boundary="Sig_/HnjaUJB5rvzNl.Ze=dkj+PB";
	protocol="application/pgp-signature"
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/HnjaUJB5rvzNl.Ze=dkj+PB
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

"context_0.uid_gid_set" has already been since 2.1.3 (and probably
earlier versions) serving as a dedicated way of guarding
"do_uid_gid_chroot()" from executing privilege dropping area twice (if
you take "context.first_time" out of the way first and put "first_time"
checks to calls [the ones outside of "no_delay" checks] that could be
executed more than once, before "uid_gid_set" is flipped to "true").
Unlike "context.first_time" it also only prevents entering entire
block *after* initialization is done (connection successful etc.) and
the process has already dropped privileges (if requested).

"uid_gid_set" name is actually causing a small confusion here since it
might indicate that it's related *only* to UID/GID dropping (maybe that
was the initial intention), but the way it is used (and has been) is
more "do_uid_gid_chroot()" oriented overall - this is not a bad thing,
because it allows us to fix the issue.

While the patch is designed to only fix the problem I was thinking if
it wouldn't be perhaps better to rename "context_0.uid_gid_set" to
something more function related like "context_0.uid_gid_chroot_set", to
make it more obvious for people who would look at the code in the
future that this member is actually meant for the function in general,
not only a certain part of it (UID/GID).

Lukasz K.

--Sig_/HnjaUJB5rvzNl.Ze=dkj+PB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJV6GXkAAoJENIr6TaVB1CUcBwQAJfNlhyxXacSPn/yll6i3KfT
8gZDnTt8Th0r9UN2oHsFIH+bfj3o/qFwEyyWL7DmXMAa1A8rqstJ2QEBEQqIIS9t
bw8BUfMUX0szSN9B9WRZOH1uQ7xPt6ri1VVBc9jviUnh6zJpO3v7Yog8Ql7C7xGb
k02KQZ0moApSldNtF2T8mpDukAtR6x9pAR229zNFdiu90nWX/8wzDnJm3H5Yosla
+X1Hgtkniko/rc8/PG2FWqZOdTykQb4ptg2bsQm/OXHJGzNlnhGZ7sMdGsHuKsJf
qpcWEDp6hiLdL/ttsa20PjZ170r3xfiQFs3wBk83t0d8DuwSxN50Ymm9M9taymIs
qOscBC9lhUmWeMNuqAOTYTY6BCf4kvkA06OsRkl/sNc0wyRmlCLUXIlaBgSlyB8F
D82i4ZFiywR+f7PZhN/XXv14DbT7J8uHWo0Fw9DMMgmdzyTm5AMjRO0HdBpI/WO0
To6lNb4nBFfh7BAUGkx3kpNOMhjwyxqKMJgrYDnaM1W4aKLLEmqRFFhABlETJDWi
doTQCBR6hKhDZKeP8G/4706ZPgwHVXT+kG1Mc/f/6N+80zApenzxCanSsb38E4Zl
3d6ob/jSou6kSSuNp0ukzo2s/5/g/NGtc8ohf7e2D5LZr9GV2Yvwj7EE2Op1WtdR
nkzIS9i3v6ZMnPz4RPRW
=Yji4
-----END PGP SIGNATURE-----

--Sig_/HnjaUJB5rvzNl.Ze=dkj+PB--

