Date: Wed, 20 Mar 2024 18:06:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZfsXglouFPyXApqf@...1296...>
References: <20230830130502.1029-1-sandro.trianni@...277...>
 <20240315162011.1661139-1-frank@...2641...>
 <ZfR54tXN8gxWr4A0@...2685...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nlgg6g/6YtDB5LnY"
Content-Disposition: inline
In-Reply-To: <ZfR54tXN8gxWr4A0@...2685...>
Subject: Re: [Openvpn-devel] [PATCH v2] Implement server_poll_timeout for
 socks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--nlgg6g/6YtDB5LnY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 15, 2024 at 05:40:02PM +0100, Frank Lichtenheld wrote:
> Code looks good and I tested build and default t_client tests.
> However, not sure how exactly to verify that it actually works.
> The SOCKS proxy I have doesn't exhibit any problems even with
> --connect-timeout 1.
>=20
> Any ideas for testing welcome.

As far as I understand this fix, it's replacing the 5s hard coded timeout
for "handshake with the SOCKS proxy" with --connect-timeout.

So to exhibit any change in behaviour, you need a slow SOCKs proxy...

I have a few ideas how to test this, like

 - --socks-proxy <non-answering-ip>:10080
   (should fail after 5 seconds without the patch, after --connect-timeout
   with the patch)

 - hack "something that can speak SOCKS" (like, ssh) to be really slow
   in answering - like, "add a sleep(15) in the socks handshake path",
   and point OpenVPN to that.  Without the patch, this should fail, with
   the patch, it should succeeds.

   (Note: 'ssh -D nnnn' will do SOCKS, but not UDP -> TCP server needed)

I have no time just now to go hacking on this, so just putting out the
ideas...

For our regular testbed, testing all these timeouts is complicated
(and even if you succeed, it's sllloowww if you want reproduceable
results, so not "milliseconds timers").

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--nlgg6g/6YtDB5LnY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJl+xeCAAoJEB2Cnv7KVigSso8MAKrF74m4nnZM7AjXI2tpvAm6
/YO2mR2bMeG7vc3fc3mnhfRNQFnJcgKt6b9cZRcZC+02lk4OLmcz5HRNgwE93nml
2rQEEvlBH0GYzgPED6NUloPqe3iA2BX2zBHpO2V7HSgixgfSqj/NxUuELj7HhbEN
dRFqLLQmHM5ssDu7Gr4jSVKw7L/3Wm51UV0HoFmgqHr5Nf5sMlQDZA5LHRW4rAvd
faGZVepfYlgFEJ2a+8jEokewE8Q5qe4qqt5aGExJnBZG1vnh6lvjYXv97oCgHqjY
KelGuwzGner9G0L3ptOlUmXz090rejBTNbeSmwEUMPvEnkA2m+uqfaNlNorE7Ejf
4aPqN8+tHquCNrje32IFNWC99sU1RKLyZJzA458mSc381I9EKmNyS1BRgU0yaRq2
tsKPmicPQqMOp/5P3hnx5MpkRw0Jnn/BwnrkngWv8pjoAJtgH9bNsvfdvorSSWwc
GZIoKsFWsykYZ8QCyou2czoVHDTBd8MwEoPaGW1HQw==
=L4wm
-----END PGP SIGNATURE-----

--nlgg6g/6YtDB5LnY--

