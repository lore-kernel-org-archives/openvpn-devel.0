Date: Sun, 18 Sep 2022 22:31:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YyeADrx4yBHHHh9U@...1296...>
References: <20220917213154.29285-1-a@...2181...>
 <Yybu8YT8PGGUvDTx@...1296...>
 <abf165f5-ee06-71ec-bfd8-182e1294d5bf@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="w/mmg63KuyCLFxWL"
Content-Disposition: inline
In-Reply-To: <abf165f5-ee06-71ec-bfd8-182e1294d5bf@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] is_ipv_X: improve packet consistency
 checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--w/mmg63KuyCLFxWL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Sep 18, 2022 at 09:47:56PM +0200, Antonio Quartulli wrote:
> In the worst case I will only address the second point of the list above=
=20
> (as we may later access an IPv6 header that is not fully allocated).

I think everything that actually looks further down the header *does*
check if the size is big enough.  MSS definitely does.

Why do we care about ethernet types?  What is the problem this check=20
is supposed to address?  Does it work for 802.1q packets (different
ether type)?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--w/mmg63KuyCLFxWL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjJ4AOAAoJEB2Cnv7KVigSy7oMAKirB5fOonU1J/Os+p+9lK/7
yg9s4jopNA4R3Y7b0otjj0n7vXMJr2bl1nNxO7kzlOgUKDiA2Uov6tXybyvkpkqV
XImmFp6FgKi/xfp2xnorCvEkYtPQ6SsckUq17MIrx+k0Ix9YUWzDDZ/QzHMbkCgN
ad1Zp32VQuywKNqEL/fnpa5tbMYS8uESG5Lx880WTKfQnMvpjv5mJwSbZuVYT5z4
9b1LUyh7wdzF+A6axmHGgvzUw1+LveB948VsTei+VM9i5EJGsmJzMfojE3BHvO40
zJ0vOqD/cjrZTymZuVUPX2SnAkHeUrwu6ygVFqqUCU8LYvxLR6SnZSUVepeRr4PC
mr9qoIrKcBPECrftmAL4gdEhkrN8JIrR20GRYyfFFZohfL+RpwIjkICLqvwP2EAv
kmHlzSLlz193landdhE05E9OAaKshf5Q1zuH+5NelJmrLubon5h3+RZF62wTHIyX
NNWkKrw+mwn6BZKaVElinWGmlhh/8yItqIA8SZanIw==
=2jtV
-----END PGP SIGNATURE-----

--w/mmg63KuyCLFxWL--

