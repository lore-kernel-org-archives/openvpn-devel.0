Date: Wed, 15 Apr 2020 20:27:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200415182738.GL1431@...1296...>
References: <20190401204032.GH31008@...1296...>
 <20190404111656.14916-1-cschenk@...2502...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QEYjvzRGikGG1/g3"
Content-Disposition: inline
In-Reply-To: <20190404111656.14916-1-cschenk@...2502...>
Subject: Re: [Openvpn-devel] [PATCH] Set the correct mtu on windows based
 systems
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christopher Schenk <cschenk@...2502...>
Cc: openvpn-devel@lists.sourceforge.net

--QEYjvzRGikGG1/g3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 04, 2019 at 01:16:56PM +0200, Christopher Schenk wrote:
> Signed-off-by: Christopher Schenk <cschenk@...2502...>
> ---
>  include/openvpn-msg.h         |  8 ++++
>  src/openvpn/tun.c             | 89 +++++++++++++++++++++++++++++++++++
>  src/openvpnserv/interactive.c | 31 ++++++++++++
>  3 files changed, 128 insertions(+)

So, we have this nice patch, and I got a very pointed reminder today
that I messed merging it up.

The patch has an ACK, so everything is good, but Lev and Simon whacked
tun.c a lot in between, and someone else added message types, so it does
not apply anymore.

Applying: Set the correct mtu on windows based systems
error: patch failed: include/openvpn-msg.h:39
error: include/openvpn-msg.h: patch does not apply
error: patch failed: src/openvpn/tun.c:984
error: src/openvpn/tun.c: patch does not apply
error: patch failed: src/openvpnserv/interactive.c:1198
error: src/openvpnserv/interactive.c: patch does not apply
Patch failed at 0001 Set the correct mtu on windows based systems


Would you accept an apology for me dragging my feet on this for so long,
and send a rebased v3 to current master?

(And if that does not get traction, feel free to send Max my way on
a weekly basis)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--QEYjvzRGikGG1/g3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJel1IaAAoJEB2Cnv7KVigSXDcMAJegCERLCUsahPPFV19pXLbm
tdYiSgX1MYXEAJaEZKP3b8B5I4drdBgYz53R8z1H62vJyO4vOLSoAuKrZYuAi00P
SMEVrfp9ok1k78Krr/UGfkKDnfbApjlHpCoNvyPy5K+4T2oekU1rVw6LlLqDOS0c
+vG9OnKSVLvBGPWPhcjmzocaCk0jJfKIGpjcq8KbR0yvCS4t4Zck5Uu4Kca7WEhY
6HKpMgXd2s3WEE5H9x4VTjlJMlPhpY3XrQkZnn+/K/sAMUc6kHsoOI52OwbyGw7H
wnZAoIOYuzXq+jnqrPCoVZGkbbMA3xvXaJYplfviwuZ4SE8J8z1aiuyipjzWsnmI
iDAUc9wfRZwTX4JQ3VFjiWVY/G39ACxG82YnRxjBBLFzUNbL7r2E92nx5Dlsjmok
fn8jJRzVh8CT0SKp1wRY9D1g93kvd/N2r4nZIzayRx6N1BGAxdKHuDwjBjmEEMv/
g64CemEVwlFJQGVY3EgE0wOKUJDsmBukBKJnWcGeRg==
=TIBO
-----END PGP SIGNATURE-----

--QEYjvzRGikGG1/g3--

