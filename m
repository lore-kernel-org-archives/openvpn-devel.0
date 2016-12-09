Date: Fri, 9 Dec 2016 09:15:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161209081535.GT78624@...1296...>
References: <1481251952-30704-1-git-send-email-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IGPMjTREWkoKVnU2"
Content-Disposition: inline
In-Reply-To: <1481251952-30704-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Improve ifconfig_sanity_check()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--IGPMjTREWkoKVnU2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 09, 2016 at 03:52:32AM +0100, David Sommerseth wrote:
> - Instead of checking the complete in_addr_t (which lacked proper htonl()=
),
>   just do a simple peek at the last byte which contains the first octet
>   of an IP address or subnet mask.

Have you *tested* this on a non-intel platform?

I know that I said on IRC that we might do it that way, but looking
at stuff like print_in_addr_t() I'm not sure our usage of in_addr_t is
consistant with "normal usage of it" (namely, always in network byte
order).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--IGPMjTREWkoKVnU2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYSmgnAAoJEB2Cnv7KVigSNwwL/0pq4r31wkBs1V39GO0G5RpC
M0s7aTJUGdENq5MvMtnWDhQXfuQlFBiWESdjUftbLvrQ6Is4idEs6PX/HVFbTtPe
gyLOj2whDvtwQhheRVUo5W0VMkecSHZNe7K/F6s2nw/ODYkqsHLcaoNzq+6qNTQ2
NWErPIhEFdKk0qS/f5Urv4EbzKjX2FiFFNzU84xUZy7ogzzU3ncWcpBpFvX5hasp
FQzK2yztMKrcb60ZHDj+W6Bc3hColLMRqx/koEemfT02z2ce0cKs64vuHa1Flunq
YmMuHfntAzlBb/e+Bg0Z0FKOJReoHaIJCG2Z23nNm0iuMqRahI8N+vKJfLKk5y2c
vAYDC+Bg3Z9+2qpMhGsksLj6X0ukaG/0h5A29L0+iHj87T3dTmghEWg7VzNAZBdX
zgp13SFhyxNam5/If8PWhSZJ6UCHkvmIS0x83sPA1g6EGNA1PvrU1wd8NhOSjHih
BFDepegiRJ1Hf6KLUV0o08LIrttePe8iSl/kNc0ngA==
=0vM2
-----END PGP SIGNATURE-----

--IGPMjTREWkoKVnU2--

