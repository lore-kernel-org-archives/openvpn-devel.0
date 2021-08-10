Date: Tue, 10 Aug 2021 11:00:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YRJAQl5rqgwjS99F@...1296...>
References: <20210806110114.21722-1-gert@...1296...>
 <33deb46b-e71f-f5de-6616-7ff4496bc49f@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KtdsNC7zQaSoRVhb"
Content-Disposition: inline
In-Reply-To: <33deb46b-e71f-f5de-6616-7ff4496bc49f@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Make 2nd parameter to --ifconfig-ipv6
 no longer mandatory.
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

--KtdsNC7zQaSoRVhb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 09, 2021 at 11:24:44AM +0200, Antonio Quartulli wrote:
> On 06/08/2021 13:01, Gert Doering wrote:
> > --ifconfig-ipv6 takes two parameters, "local ipv6 address / netbits"
> > and "remote ipv6 address".
> >=20
> > We only *need* a remote ipv6 address if we are in TAP mode, want to
> > install --route-ipv6 routes, and neither --route-ipv6-gateway is set
> > nor a gateway is included in the --route-ipv6 statement.

So that it's not lost:  more review of route.c uncovered that the
FreeBSD, OpenBSD, NetBSD and AIX code paths always need a gateway,
but this is not checked properly.

#elif defined(TARGET_NETBSD)
=20=20=20=20=20
    argv_printf(&argv, "%s add -inet6 %s/%d %s",
                ROUTE_PATH,
                network, r6->netbits, gateway );

(etc)

v2 coming...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--KtdsNC7zQaSoRVhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhEkBCAAoJEB2Cnv7KVigSA6EL/jsQBeUAlOp3u2rKTu60Wl4/
MzXsjP4vV70wGPtPCCVkAklYRIbbAS6/n44apGW/2kExSL9EZ5fQGfFHn75RhZR4
SAMtyeTJ+3/VgvH9K18cyuQn0WmAo+Hs3DFO/22y9oNnShMRV3R0amw3gCqdhkZY
9Jg5DHHfv1SENW9HxHqVUhld0veikieXmPJ02+OB9u0X6MeW7Y5zmk/erOXKCqFU
x6MUs1HSgF2sZCIswS4yaVV3BlszK/zk+Isy2N/etyaqPWQjfLGY225xFogeFTST
JzrGrAJxCXQXioQZWUn8jXY4GW+xU/59qpu7zkUUInDg8gjUizk6eh3IZGycGGBq
pQ5X98FMn5PslrQSw6ImVbtTeOL00+GwhT9YBfFBcAnv7CB3K0J5Dimcki/j02ai
BY5f0ELcVIH1LQKW3n1zVWJisab55jz7+2RWvOFXq/S+QzUUD8fqNy2bh77E+Flv
MwP8Q7hhT3g8KcQ4kDhgHCKglIeFM6oFcpk1iojqjA==
=Nb5F
-----END PGP SIGNATURE-----

--KtdsNC7zQaSoRVhb--

