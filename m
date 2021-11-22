Date: Mon, 22 Nov 2021 11:43:34 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YZt0Vs6PZvPIsLoD@...1296...>
References: <20211117035321.249-1-lstipakov@...277...>
 <YZtTVZDWtTEecS/v@...1296...>
 <CAGyAFMXM9aTQqbz6K-vu5gguARscTHEOb2++ZRgNh1uGX6+yXQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="eP32BcMPmjIjPpGK"
Content-Disposition: inline
In-Reply-To: <CAGyAFMXM9aTQqbz6K-vu5gguARscTHEOb2++ZRgNh1uGX6+yXQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH master+release/2.5] Tune down verbosity
 for suspected retransmits
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--eP32BcMPmjIjPpGK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 22, 2021 at 12:20:08PM +0200, Lev Stipakov wrote:
> I've discussed this with James, in his opinion it is not needed to be
> fixed in openvpn3 server side, since those duplicated packets are
> dropped anyway in openvpn2/3 clients.=20

Well.  I'd say this is a matter of protocol correctness - if the=20
protocol requires something, and OpenVPN 3 Server does something
else, it needs to be fixed in 3.

No matter if "3 clients" will drop this without warning...

(And maybe if they would *not* drop it, it would be even better?)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--eP32BcMPmjIjPpGK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhm3RWAAoJEB2Cnv7KVigS1scL/3b4dlv6sOP8QjGffkNJpv+L
UApJP+rqPg7qPepHTRVxmB9KQ+rTyMvCtkcqSA21OrccPmNzLv7EpCJXpca1D4Zb
y7NG0AdMJeoGjU3Gzanfr3pMqjM6FkRJREkIiDKOscz3dRNQPUG5M1YRwF8s6ApU
FXE1qPUWP7tVU1FA4xPQS9O6IJSP1BX25ZptDWEZHBR9KvZ2sqJT1TX78+Fq+LFo
zAt8WkzK/NanxsaHUjn/Jr1Q99eFMQ50T/ZuQNne9sKTcoIWhHRe4CzfTn1pxpPv
29NZ4FphsHRyk7KZ+JPBITxGR5f3Pc0HiE/8eT2uuSdi5i3LaY23x0UvAk4Dhbya
nhrYq8EJWpMoSB99Fk9MfnvUQvtuUamnrGCnmoJEWDamA8WQQPsN755wFwuJgh2p
303VGYx5Irr7jG8/2uxsxDU7jhmPaKXTKtE9gkKSyR1Q3VdqDLZF9R0p3MBLwu6G
KGnn27TI8wlHY18qm34RGH+3puZW/l9oc1jjsIIs7w==
=YQl2
-----END PGP SIGNATURE-----

--eP32BcMPmjIjPpGK--

