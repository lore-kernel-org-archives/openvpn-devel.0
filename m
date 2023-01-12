Date: Thu, 12 Jan 2023 15:51:30 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y8AecpxMv/Xdp+ls@...1296...>
References: <20230112000435.14119-1-a@...2181...>
 <2106db01-4d13-073d-2693-880f693da525@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tQgg8/0NlUKdFVff"
Content-Disposition: inline
In-Reply-To: <2106db01-4d13-073d-2693-880f693da525@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] dco: send SIGUSR1 upon ping timeout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

--tQgg8/0NlUKdFVff
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jan 12, 2023 at 02:52:33AM +0100, Arne Schwabe wrote:
> Am 12.01.23 um 01:04 schrieb Antonio Quartulli:
> > Arne, I am not 100% sure why but it seems for ping-restart we always use
> > SIGUSR1, right? but the DCO handling code was apparently using SIGTERM.
> >=20
> > What do you think?
>=20
> This makes no difference in p2mp mode.

This is how I remember the code, from the "incoming explicit-exit-notify
vs. p2p/p2mp server" testing.  Logging is different for SIGUSR1 vs. SIGTERM
instances ("restarting / terminating client instance" or something like
that) but *then* the same thing happens.

You can't "restart" an incoming session ;-)

-> putting this to "Rejected" in patchwork.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--tQgg8/0NlUKdFVff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjwB5yAAoJEB2Cnv7KVigSqPkL/3GTwRf1WwhbDC3mJBpSGczf
+9Ca2PMirtQFamwPueMHm0YI7HaidLwlYxlVf6Na1/NDcRvNEqVrvjZ+e3bZihJI
VFEGGrRKmJbY56msLfj7gzwxoH6TF5Q1uvp8a8CbG5PEvCihX2pgJ1nFJhJydCef
xuEPHoYIGUqCe+qOB3pQh0niXaU11phaZihLRgqLWCi2EhtRruoy0F1AukeWX00g
XZ+PM1m/TG7hkgkGYw2iO5YkifdK3YxiA4342IiAjursnIg2Rkr1TyxC13SCI1/O
QYGwNmYrp8xSghnl7IhPDix2nwzhvnSNJhUaSNjgtY0O9VtylNRTpvQNisGQ4mGe
tdFf6FU65Il3WJLeCNWg7pKCYC0oKeO/rrsFET/ppFHo2ywxx5/cQfGr8jYhRIPj
C7NO2BQpC3E6yy9Cuhbmiv88A31Qm8XoQfohKqM4KzNKGN40dH47JruREIjxngac
5rEheXP1CyrOZXXv3bMc5aM4/o7CsIyMxXrUS7gp7A==
=ltfn
-----END PGP SIGNATURE-----

--tQgg8/0NlUKdFVff--

