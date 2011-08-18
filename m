Date: Thu, 18 Aug 2011 20:25:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110818182536.GM8496@...1296...>
References: <1313662581-30181-1-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IFbVDofONQA6Jk4C"
Content-Disposition: inline
In-Reply-To: <1313662581-30181-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] remove function is_proto_tcp()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--IFbVDofONQA6Jk4C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 18, 2011 at 10:16:21AM +0000, Heiko Hund wrote:
> The implementation of is_proto_tcp() was invalid since the IPv6 stuff got
> merged into master. There's proto_is_tcp() that does the same job right.
>=20
> Remove is_proto_tcp() and make its only caller use proto_is_tcp() instead.

ACK.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--IFbVDofONQA6Jk4C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTk1ZH6kuBuNlUUl1AQLUmgQAw/6Ep+YQXgJA5ArZfOMvsS5OXHf7AYyy
drm4eafLdPg73/swxoYTpA8hba4mIQvUTf5W8r6dKStDolrUiFnWLl7neKGT3HHB
dc9xJHBUCLRhzriQxVRR870CEMKLoQQ0aUNh4P3CMqbk2Wyz9s7YlunX4MUexJWz
G1Ayeu8bdu4=
=hLE8
-----END PGP SIGNATURE-----

--IFbVDofONQA6Jk4C--

