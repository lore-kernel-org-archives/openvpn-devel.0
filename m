Date: Sun, 2 Sep 2012 20:42:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120902184240.GI18296@...1296...>
References: <20120807093930.GK2535@...1296...>
	<1344333837-22076-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7fwXp2o0gOrkU5lS"
Content-Disposition: inline
In-Reply-To: <1344333837-22076-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [Version 4] Merge getaddr_multi and getaddr6
	into one function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--7fwXp2o0gOrkU5lS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 07, 2012 at 12:03:57PM +0200, Arne Schwabe wrote:
> the getaddr6 and getaddr_mutli functions are duplicates of each other. Si=
nce we always require getaddrinfo to be present both function are merge int=
o one openvpn_getaddrinfo.
>=20
> This functions also returns a standard struct addrinfo* so our resolve in=
terface is closer to the standard unix interface. The getaddr function is a=
 wrapper which provides backward compatibility for IPv4 addresses. Ipv6 cal=
ls and calls to getaddr_multi are replaced with the new interface.

So.  I tested this already when you posted it (and it passes all my
t_client tests, connecting to IPv4 and IPv6 hosts, and inserting lots of
IPv4 routes - none of them to-be-resolved, though, but given the problems
with route duplication in v3, I assume it will do).

Today I went there and reviewed all of the code, and tried in earnest to=20
understand what happens where :-)

I ACK this, but please remember to tell your editor to use 8-character tabs,
as that is "what the rest of the code uses" - some of the new code looks
quite weird with ":set ts=3D8", and there's more diffs in there due to=20
whitespace changes (4 spaces getting converted into a single tab, like
before 'hostname =3D "::"').  We do not need a v5 re-spin, as David said
he'll take care of these.

(Samuli: we need a style guide in the wiki...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--7fwXp2o0gOrkU5lS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUEOooKkuBuNlUUl1AQJ17AQAg36dfPIt2rNNhZQpwYGwDYNWxSJ65Vqb
RJ5CRYxPs5Ycx/QUeyXTgkq4ZG6ZuLm6w4FWKBhBrc+SK2JjENVzUNXhvr8T0wEy
uQNQzYx4QFqLi2pqZRXXgC+RUg/kEQuFNkiUShcFK+2COHk3RXNVpP3uSb/ZiJlm
CjIA34GjlvI=
=ueWQ
-----END PGP SIGNATURE-----

--7fwXp2o0gOrkU5lS--

