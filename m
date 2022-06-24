Date: Fri, 24 Jun 2022 12:26:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YrWRSH5di07JxGmW@...1296...>
References: <20181206171033.61310-1-gert@...1296...>
 <06dfe01b-95dd-ae08-4b30-96f85ac2bd9d@...1856...>
 <80e6882a-dd00-eeff-151b-1b67d6e61103@...2181...>
 <a83d231f-2f4b-c51f-e71a-94f13b699ee2@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vya+/yf7nDi0WUnn"
Content-Disposition: inline
In-Reply-To: <a83d231f-2f4b-c51f-e71a-94f13b699ee2@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Rate-limit incoming
 P_CONTROL_HARD_RESET_* packets.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

--vya+/yf7nDi0WUnn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 24, 2022 at 11:13:40AM +0200, Antonio Quartulli wrote:
> do we still need this patch after having merged Arne's HMAC feature?

Yes and no.=20=20

*This* patch won't apply anymore, but Arne said "we're now much faster=20
in replying to packets than ever before" so we might indeed need a=20
per-source-ip rate-limiter, to something like "10 per 10 seconds" or=20
so (inventing arbitrary number that should be more than enough even=20
for "5 users behind the same NAT reconnect at the same time", while=20
at the same time too low to cause harm as a reflector) for the=20
initial reply.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--vya+/yf7nDi0WUnn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJitZFIAAoJEB2Cnv7KVigSVDgMAJBkTO0tDfMEgjr7mDeStXTM
gpKkbFpEI6sM6uJBDyJUXqZicvWI9shn79rjNWIbQuIgKsjTdyMjzir8PlYS1jBp
f1j9VcB4I9adCkbjhdIZLMUTcx6MIJreC/18HyUqYTTZwCNoOGqD9giSaj03MkGe
j0Om6/DhjjHRbJ+cErwZDBNPUXYo9bcXWlgzbT/5h7F8fZ1TkAWQm8rc0SNubf5H
JUJ6iquCGw6A2msZ21DVdMSI0gedXxCP+X8v/4WKF9P6a6eUNv90uWCo/7ZGjIkC
dt+Ms3nYeDGvYsw4OIh2drDe84FymdsCBjVy843Wxsf8Aq7gCKvY3TnaqgGq8snH
O8j8A0VJp1bI74hC8QO6PYD9oKfA/GFG5iI2Di4t/xY3NEkk5JrJLvGyDP6zgspS
/BwHiH7ZcNOH4SS6v3L4M+/gJH5bYLbkDn2NLe17Z2DODtKtdcfrdF5llgmMBD87
lOPEkM63mq15IfqD9oWvBWPgESujjK2bmQSzQl8/Bw==
=P78q
-----END PGP SIGNATURE-----

--vya+/yf7nDi0WUnn--

