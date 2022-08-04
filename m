Date: Thu, 4 Aug 2022 17:28:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YuvlnDuh0XfbhT4w@...1296...>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-26-a@...2181...>
 <YsQFFkxkn5BdEdTQ@...2678...>
 <a6ccb545-ebad-fe78-7691-80e694792b98@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vJbucYVaAB4jfpE2"
Content-Disposition: inline
In-Reply-To: <a6ccb545-ebad-fe78-7691-80e694792b98@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 25/25] dco-win: update GH Actions config
 file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Frank Lichtenheld <frank@...2641...>, Lev Stipakov <lev@...515...>, openvpn-devel@lists.sourceforge.net

--vJbucYVaAB4jfpE2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 05, 2022 at 11:36:37AM +0200, Antonio Quartulli wrote:
> On 05/07/2022 11:32, Frank Lichtenheld wrote:
> > I think this commit could use an additional sentence
> > in the commit message on why exactly you remove this?
> >=20
> > Doesn't immediately make sense to me.
>=20
> To be honest, I am not even sure why we have a build with DCO in the=20
> first place. There is no DCO code yet in master but somehow we have the=20
> GH action for that :-D

Now there *is* DCO code in master, so why removing the --enable-dco?

So this patch definitely needs some more thought :-)

(And I thought there is an easy one to apply)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--vJbucYVaAB4jfpE2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi6+WcAAoJEB2Cnv7KVigS5AEL/2wbJdPUz0YpDva6ebBAj5LZ
USQW4PzY/9uTA/e/rGckYM4HhTjT0z0VPo3UoENPfwSxvg3iiq+m2kpuBnaQKUks
2zRprDhtV4AmQG7LS4dzvSiqh9myAbU8UeMS4j4NEoe5J+fuGR8ubOKxiNVBjHnt
yU4GO2Kj4j2d+w3GeJo2npy4j556XKh9BnulocYcfFRQWChfDshAp6q1M4fBRBBX
RSmCV0I49Yr5ZGHKlBp8f/ItSOPp4sPHXEinDNW7+MVkxmwqKu5eG8U5icjiGShg
CO49sKgbZz2gwS92Bwn0k32quoPciIVaT2SmAZL4Hqf7RzQAp+dV6GLMwfaddJgL
KWrdh9vk+4mUZWrwq630uWMNZGSeiP93zr/b+QTVXeSSXzjWAX8SGnU3rKbTt5kW
SLSFDHecD/Kyw/DnNRY7wQjua8m8/0kjKQg8m/991zBj3nY/d64yWej4LbNOpLG4
XhfUoXLqA7MlGxmRihYSYp+gjChR5IPE9YusBinJsA==
=3TGf
-----END PGP SIGNATURE-----

--vJbucYVaAB4jfpE2--

