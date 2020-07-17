Date: Fri, 17 Jul 2020 21:14:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200717191451.GY1431@...1296...>
References: <20200717190801.17780-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="A8aU907vivKaQy23"
Content-Disposition: inline
In-Reply-To: <20200717190801.17780-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Add demo plugin that excercises
 "CLIENT_CONNECT" and "CLIENT_CONNECT_V2" paths
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--A8aU907vivKaQy23
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 17, 2020 at 09:08:01PM +0200, Gert Doering wrote:
> This is a new "samples" plugin which does not do many useful things,
> besides
>  - show how a plugin is programmed
>  - how the various messages get dispatched
>  - how to pass back information from a client-connect/v2 plugin
>  - how to do async-cc plugins  [not yet implemented]
>=20
> the operation of the plugin is controlled by UV_WANT_* environment variab=
les
> controlled by the client ("--setenv UV_WANT_CC_FAIL 1 --push-peer-info"),
> to "fail CLIENT_CONNECT" or "use async-cc for CLIENT_CONNECT_V2" or
> "send 'disable' back from ...") - which is useful for automated testing
> of server success/defer/fail code paths for the CLIENT_CONNECT_* function=
s.

This is not yet finished - all the async/deferred versions are not there
yet, and I think it wants a "Makefile" to be built properly :-)

It is working nicely though and has already uncovered bugs in current
master.  So, out there for people that want to play with it.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--A8aU907vivKaQy23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfEfiqAAoJEB2Cnv7KVigS5KcMALFxoWaka5mH1BKnPTsQOnSn
QWu/dpKcCh0eztpsr81BTIm7gR+OzUdgBbjDyM7pdgzS+p/SaG5rjbnJDy6XDW0Q
p1aYoXMPZYR1ZNH8c6R8evIjrvmOsiKHQFz3nn8qoWfZu8pWYUAtlH8V7ZdKotQw
yYMtYi7jZ3TdpZqHsToSne0xDhQv6pnXh1jVOcNOrFkfn69GvyVkBMmGHuY4q2Dk
DFj7i8KFaY6jT01azC6UlhDa/BDMRD+GouCoxolWZfUTQk35OLCOQmcjCAF3n9Bx
z9ZyIz/VLz5JCgmye7ZkYOBLXBDFqBMPsMURYm2xXhp6A04J+TG0liM3pLuueApy
qbfVgvKfGDRZB3SOlakHg9hVS0ODmBn2yM81T5Y5MGXiTe23aMPqSuui5fOPrzAV
O8Ius82UzXMhP4Q0mkBrmta1ByPHI8WA8I8y7oftLz4uDBxwGNy1ZPQVkhEukLsW
N7nnp/n3bNRf928s9DHiYH8fBClQ/jeN4UZHelP9fQ==
=IhqD
-----END PGP SIGNATURE-----

--A8aU907vivKaQy23--

