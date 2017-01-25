Date: Wed, 25 Jan 2017 08:46:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170125074619.GY940@...1296...>
References: <20170124232344.7825-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1XWsVB21DFCvn2e8"
Content-Disposition: inline
In-Reply-To: <20170124232344.7825-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Move the READY=1 signalling to
 an earlier point
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

--1XWsVB21DFCvn2e8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jan 25, 2017 at 12:23:44AM +0100, David Sommerseth wrote:
> The approach this patch takes is to consider OpenVPN ready once
> all the initial preparations and configurations have happened - but
> before a connection to a remote side have been attempted.  This
> also removes the need for specially handling the --chroot scenario.
[..]
> Trac: #827, #801
> Signed-off-by: David Sommerseth <davids@...515...>

I think this is a reasonable approach for the time being, until we have
worked out a more fine-grained notification mechanism.

So, ACK.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1XWsVB21DFCvn2e8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYiFfKAAoJEB2Cnv7KVigS368L/2nyt3tgJAwRg7fH/oZgC7kG
pXG+dOI+jfq2L9yhY7ClTtlGq5MF90cngmnVYS/hBspouu8KurbR0UVYk8bXheRd
UYt4cYqygUTNEwp23Abhidawecb8rAFCguBui+FXs+pfWkXPgvB85faMmFtuCK6t
xfFPBTjmDnM1rvVlv2EOZ5aH8PSXaQvKDwXPuJ9jXMUcUCbqPB0HKWXbmM/uyxdO
/P72fN0NOpYKqPJVvFDhOtzqm2expXZXWeZaJi6JQ7Ryo+odiQrTwUgVGatPy2EJ
CI6H7rYcPfS10QxkOtzU92Wt8Zq3nzfvFmEl8Rr5vT39hqvsXRdhIHFEi2aFAna8
0kqL04BLfpak77Qe4A8Q4/eycqYbCx3arPppK3g5duMUlQogQvKjkB/DqFxqHZzR
VTRUmp8eOc/CMG3uoXqAIxn1/Jlu+omtELqmCm27PSnrvlmUfEPkwvvwoYFYtZA3
qTHU9JtrMwGyPdB6MljF/IEBTHL/40Eifaj1RpqOrQ==
=m1PK
-----END PGP SIGNATURE-----

--1XWsVB21DFCvn2e8--

