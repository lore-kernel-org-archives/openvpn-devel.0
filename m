Date: Wed, 7 May 2025 13:30:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aBtEWDpucmll4HJJ@...1296...>
References: <20250430123250.8627-1-a@...2181...>
 <20250505225549.19492-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="D3G/nfHoZY1A87To"
Content-Disposition: inline
In-Reply-To: <20250505225549.19492-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next v2] ovpn: ensure sk is
 still valid during cleanup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--D3G/nfHoZY1A87To
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 06, 2025 at 12:55:49AM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> In case of UDP peer timeout, an openvpn client (userspace)
> performs the following actions:
> 1. receives the peer deletion notification (reason=3Dtimeout)
> 2. closes the socket
[..]
>=20
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
>  drivers/net/ovpn/socket.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
> index a83cbab72591..66a2ecbc483b 100644

On my ubuntu 20.04 ("backport of ovpn") running a few OpenVPN instances
for test purposes, opening and closing DCO interface frequently, I could
fairly reliably crash the system in ~1 hour.

With this patch, the machine survived the full test parcours.

I can not comment on the technical merits on the patch, just state "it
fixes my problem", so

Tested-By: Gert Doering <gert@...1296...>

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--D3G/nfHoZY1A87To
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJoG0RYAAoJEB2Cnv7KVigSFVcL/3Syf/G7sM+3/hGErx8x6965
Zuib5/GO31B2iuHN7nRrzTcK/haOTaF8ZcyuXaUdSIGEQ9ZRL/QxeyB04DB1cvNU
ItzmhYAGIoHIZY3DPvJU4ukqm3GvC9Lmydbmie6P8uwQ6iJORw7rUnAUHKgOj8I9
2pkdqKKvGpl5Qch/xia/fen0m3dFEiZJMgL/yTx1Wg5pKVJlR/oBc14ON6CM00Ze
ZRlsSmMyXXj/Gz4V8omCwsxYnhVceiDaV0WpsJXg9DpR1O/3US2MS1EL75HIVUTO
FBZ+u2wGcCy1eNQ5cl7ua/3b+7W58Ol0MVNaWbhUKFsEOw+jBzyHoM/Dq6WRsxJK
y6wgjiPvtPM3cwv/B/j0N1gT1folOqJSugGRPdGyMiBq6l3ONtj+KsszGbVQBxwA
4fzKia8lGvlhHYK6VuT3vI6whMdruc0MI7WCkQqjgW5UhZr5CG0Xoh0cmX9u571e
Y6ObxTGOgY03p811Mz9QU8JfYZQb7Joir9oEuXWWlg==
=JvcW
-----END PGP SIGNATURE-----

--D3G/nfHoZY1A87To--

