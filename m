Date: Wed, 14 Dec 2022 08:36:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y5l9DhJ/9GGYF0CH@...1296...>
References: <Y5jwnIHp5iTOLTiG@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WgUoWwAGDhjEDMzX"
Content-Disposition: inline
In-Reply-To: <Y5jwnIHp5iTOLTiG@...1296...>
Subject: Re: [Openvpn-devel] DCO p2p TLS ASSERT()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--WgUoWwAGDhjEDMzX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 13, 2022 at 10:37:32PM +0100, Gert Doering wrote:
> I've managed to break p2p TLS again...  not sure how I did this, but
> anyway.

I now have a better theory.  I was not able to make OpenVPN on Linux-DCO
ASSERT(), but it gets confused all the same.

So, the server side of this is
=20
  - tls-server, proto udp=20
  - ping 10, ping-restart 30
    (though this seems to do exactly nothing here(!))
  - server-poll-timeout 3600
  - reneg-sec 300

then:

  - connect client, ping works
  - client disconnects, no EEN
  - after 300 seconds, tls-server goes into "renegotiate! really!", which
    does not work (client is gone)
     - left alone, after "server poll timeout", tls-server SIGUSR1s itself,
       and after that, things work again
  - but if a client reconnects in this "renegotiate!" phase, the server
    gets really confused about key management - you have to reconnect multi=
ple
    times(!!) to make it really confused.
    I have not managed to crash the linux DCO tls-server, but have managed=
=20
    to get kernel messages like these:

Dec 14 08:34:21 ubuntu2004 kernel: [23402053.659404] ovpn_udp_encap_recv: r=
eceived data from unknown peer (id: 9537857)
Dec 14 08:34:21 ubuntu2004 kernel: [23402053.896938] ovpn_udp_encap_recv: r=
eceived data from unknown peer (id: 9537857)

and then

Dec 14 08:34:45 ubuntu2004 kernel: [23402077.345995] ovpn_encrypt_one: erro=
r while retrieving primary key slot
Dec 14 08:34:45 ubuntu2004 kernel: [23402077.356330] ovpn_encrypt_one: erro=
r while retrieving primary key slot

... I guess that in this state, FreeBSD returns something that makes
userland ASSERT(), but Linux isn't a happy camper either.

gert


PS: why is ping/ping-restart not working here...?   It should have
abandoned the session way before it entered the reneg-sec dance - ISTR
that Richard has an open bug on this.

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--WgUoWwAGDhjEDMzX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjmX0OAAoJEB2Cnv7KVigSVSAL/07B8J5uiffKpCTwnkHKCuKY
6RsTtk5gczhZsixfBJCPMqgRurMQ14vMakUr+8+qGrgs76iDG4QABdH5aRZ1dI/D
ag8eCCUX34TL1G71hbIT2AAWcV8ELE9wwhH6jUlzIot1z7hr+ObfLPCzTBRzfU3a
qpqG1vEAy0+6Ut+dFKB8RIQPohn0JF6grqEVBrMCKXm1jJfdRPL/d2vjYHAXmpJ4
3kPIczd3oCqv34PRJF8FrdfRhsYr+P8wteBhvkxfMxuKZ5eOeN6p2vmc61RhpzW4
ZXX5sZdG75vs40amOeUKlRxVck54D0ievNj6wb4v8rwUm7J3mDXVpuZYpzXtQGBd
WlQ3lfXYSVDdCRQqk+LkqG2n+TZI/sD3UogtbvA4jI/dMG03swThfxKWU93FCX3H
WVlSY+IfHvjm+E3Kfz2mo317aLcZUAAMwK3Ov0D1orxa9+qHSfVE9rH2tfruC+NR
Xk9yCrG8Wua3vXFtpbXjp62b3km0fSH0Bmla6DWVsw==
=caJS
-----END PGP SIGNATURE-----

--WgUoWwAGDhjEDMzX--

