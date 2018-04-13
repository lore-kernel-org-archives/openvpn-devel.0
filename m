Date: Fri, 13 Apr 2018 19:29:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180413172940.GR69387@...1296...>
References: <CAAF3xa-+k10J4URGr+6zfua-p2KmoGUniejfBWDB7nNJ6p03kA@...278...>
 <20180413171009.GQ69387@...1296...>
 <CAAF3xa8wuk=+Mssvs1PuGvhPgBBPbe1W+dgLJxeO7GwYekQOdg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dQfkJaMeTXB/ayZA"
Content-Disposition: inline
In-Reply-To: <CAAF3xa8wuk=+Mssvs1PuGvhPgBBPbe1W+dgLJxeO7GwYekQOdg@...278...>
Subject: Re: [Openvpn-devel] Viscosity patch to TAP driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marvin <volleynbike@...277...>
Cc: Gert Doering <gert@...1296...>, "<openvpn-devel@lists.sourceforge.net>" <openvpn-devel@lists.sourceforge.net>

--dQfkJaMeTXB/ayZA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 13, 2018 at 10:24:18AM -0700, Marvin wrote:
> Only that here we need to run Gava's patches for active-ftp and client-nat
> (submitted to openvpn-dev several years ago but not accepted).  He has not
> had time to port those patches to 2.4.x yet.  So for now we are stuck at
> 2.3.18.

If you run your own build anyway, just package with the new driver as
soon as it's released - as today, there will be a signed .exe for the
tap driver, which gets embedded into whatever installer you build,
2.3.x or 2.4.x

(Note: active-ftp NAT will never be merged - that is way too intrusive.
The other NAT patch got lost somewhere but still has chances)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--dQfkJaMeTXB/ayZA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJa0OkDAAoJEB2Cnv7KVigSFaUL/RQdUEzqAsdw+By/rr+3Tys0
iqbHr7tC8H8+dzolqdL0kE36eW31MpOab1fft4K1h6Ea2oWr//20HZi2stqhxst1
iY+4ASr62gnmmyjTulxYMU+OVqCh1TpZF8yZuVFbiAtfPpV65H3xyAcJw37l73CF
1zGtatTlHR4wzruLJsJAta8IHa7x2K5lSTZd2VI490Qr0vzH01y75N6BpfA50rrk
Cq2Zl0DpMSdOLBrP6YetaQzjy9Z1W58tf33FybDRpG1j90BJv6xIf/7sUnL59jHJ
wzMfmuQyokxeQ6XUuw3SWxztSF1zfjiwPDzlrm4JLGKvriELqYmWYIUJHRhMZp0b
dYs0acuP4Ml+2yOSUAFisqpUtun0XI4CACBkHNcW9791v4vXgNgrNhRgfSgRT6nq
d7vRU6mFl6r1fLfPL3hvjn63a/+coj2TLgTn0+1/30JnbLski03EH0LtcuKWGIwg
UCUE08Qf28EDg8ULI5tyfQfl5KQrWiWeusN5M5EjRQ==
=qYW9
-----END PGP SIGNATURE-----

--dQfkJaMeTXB/ayZA--

