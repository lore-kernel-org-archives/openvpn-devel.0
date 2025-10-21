Date: Tue, 21 Oct 2025 21:40:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aPfhwvsB8Sk27GME@...1296...>
References: <-MNw5Hu8h0rHV18x36ISt7V0UHchIO4i-JoAeV_wlxS1AmDIAe7YVYNput3_r2hiu3HhwxkhGyUhv4-iH_E7mf7nGjvocmGXlDq7Tjly5cE=@joshua.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="oGZ1A4GrMERB1SWF"
Content-Disposition: inline
In-Reply-To: <-MNw5Hu8h0rHV18x36ISt7V0UHchIO4i-JoAeV_wlxS1AmDIAe7YVYNput3_r2hiu3HhwxkhGyUhv4-iH_E7mf7nGjvocmGXlDq7Tjly5cE=@joshua.hu>
Subject: Re: [Openvpn-devel] [PATCH] tcp: apply CLOEXEC to accepted socket,
 not listener
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Joshua Rogers <contact@...2949...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--oGZ1A4GrMERB1SWF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 21, 2025 at 06:11:06PM +0000, Joshua Rogers via Openvpn-devel w=
rote:
> The accept path calls set_cloexec(sd) after accept(). That re-flags the
> listening socket, which is already CLOEXEC from create_socket_tcp(), and
> leaves new_sd inheritable. As a result, client-connect and auth scripts
> spawned after accept can inherit the connected socket and read or write
> the raw TCP stream. This defeats the stated intent to prevent scripts from
> accessing the client socket.

Impressive find.  I had to actually look at the code to see what
you are talking about :-)

So we do=20

        new_sd =3D accept(sd, &act->dest.addr.sa, &remote_len);

and then

        /* set socket file descriptor to not pass across execs, so that
         * scripts don't have access to it */
        set_cloexec(sd);

    return new_sd;

which very clearly is not intended behaviour.

So,

Acked-by: gert@...1296...

will deal with it "as soon as possible" which will take a few days.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--oGZ1A4GrMERB1SWF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJo9+HCAAoJEB2Cnv7KVigSpdsL/R5PJclfMFL1mmK2kZZgkk9P
q+RvNj1bn107aB0MY4LRdWYcNa+ufTT9a618p4qV6gZcsH2GuUcdsnNgvgtRJD7y
quePw7M8msP1ajlAj5EOyBMQ4Jp0RhVBhtQE1IbqaIPaW5cYUMNcMwv8MgkmFFzz
rneGiGPwWzl9Z5NcZH/4sOK90OPm8XPlJ0unF35ftU52/oHQvV5vvkFIBoctWwFm
WRHDU2clBYo2a/Da7rJQC7nUeRmOS+3ppYScvGCrNmM4NMlYGYmv/O/K6VwQPUmj
ffDTD7+CUoObBgG2CNILnEpVPrKTSIHlRgDXG/8wXvMQKJcsT7XAH0dR7WFGDDjQ
s5Y5buJXZLHCahgq7l+bztZJ2gJ2e3/PScXEz4c2TA6lpt5qrCXPJYqDrae5s9Es
Zb+m7rCYzNwDY7vx56YWweEsx1bxPhWWDf8jLHrBega5rpKoA2a54uRhC1BmMSWu
tl7Hw4syQNct5C7T8/jm94CZ3xRu0+uNJMgpxuVwbg==
=pGs9
-----END PGP SIGNATURE-----

--oGZ1A4GrMERB1SWF--

