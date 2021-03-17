Date: Wed, 17 Mar 2021 08:01:18 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210317070118.GE976@...1296...>
References: <b6276be3-faa4-ab16-2793-9c9a4757d582@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="DcxkfgwhrcTyPGaE"
Content-Disposition: inline
In-Reply-To: <b6276be3-faa4-ab16-2793-9c9a4757d582@...277...>
Subject: Re: [Openvpn-devel] Indicate correct PUSH status in log
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincanteksup <tincanteksup@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--DcxkfgwhrcTyPGaE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 16, 2021 at 11:26:18PM +0000, tincanteksup wrote:
> Or the server indicate an initial unrequested PUSH, technically
> this is not a PUSH_REPLY.

Since the message is called "PUSH_REPLY", this is what it is, technically
or otherwise.  This is the same message and same code path that would be
used on an old client.

The difference is that 2.5+ clients send their "PUSH_REQUEST" as part=20
of the initial IV_PROTO flag set (and re-send them as "real" requests
in case an older server doesn't handle that).

Confusing?  Maybe.

But not factually incorrect.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--DcxkfgwhrcTyPGaE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgUak9AAoJEB2Cnv7KVigSRf4L/RH3i1BpWhN7HgAA9VVMpIDm
z+T7EXP7bF72cOuDNX43EmIJP5ja8zCv6jGZ9KR7wAWYRQWQjev+9DNwp6lalshG
bk/RUTvQOBfiR7GeEtqzvtfaFYkAdEDwLgPw3P9qqu9wNBjjSbHFyyXPQLIVl9L0
zkJi15UV2mlVqzNS+nn5GS4LKmNGpVeLNCv1rGLyPZrHHyP83jmRBllCgokQ9d+o
F8dfN2EaxEhRUWFSGsj//azldGDKCa3Qw6J1dWyg3AWZIUa1p1GPNvloJVtZfNzC
GyiiD8w3vfA/TCfanZYUpX8/dQMcJpTcmaOUPkJ/V6PCdLe6GQlyDt1FZBbD8+1R
iRXVBVmQnbPJBllOFEKga4k9NsZ3dYHYBx6l2RZoaUwk1WIjuJ3f1ayjThcxf+4s
qstD8XQ+lLcm7GcEyt2F/4xBJSad7yswU28uFguTx1l7GDJtZ+OHZ77ChJq+yanU
nfd+Xs81/u2h437LFTUhJceIGl7EYyfPmTxuC30Liw==
=EEhV
-----END PGP SIGNATURE-----

--DcxkfgwhrcTyPGaE--

