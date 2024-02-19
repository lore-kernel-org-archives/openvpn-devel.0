Date: Mon, 19 Feb 2024 14:12:55 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZdNT18oVbBxUGDoU@...1296...>
References: <gerrit.1708012740000.I4b5e8357d872c920efdb64632e9bce72cebee202@...2715...>
 <a91d834e2d9f284b0278cf9940f50dd0a539f057-HTML@...2715...>
 <Zc45NJAyJyLoTRee@...1296...>
 <8021c4ad-fca6-443c-9ce6-37c7e85bca81@...2181...>
 <6d8657f9-738f-44be-acbb-7e044d89e0f3@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="K+2dsY0V3DukTaOf"
Content-Disposition: inline
In-Reply-To: <6d8657f9-738f-44be-acbb-7e044d89e0f3@...2181...>
Subject: Re: [Openvpn-devel] [S] Change in openvpn[master]: Minor fix to
 process_ip_header
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, gianmarco@...2726..., frank@...2641..., openvpn-devel@lists.sourceforge.net, arne-openvpn@...1227...

--K+2dsY0V3DukTaOf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 19, 2024 at 02:08:56PM +0100, Antonio Quartulli wrote:
> This said, I do believe this patch fixes these issues in one go as the new
> PIP_OPT_MASK will match all the flags mentioned above.

Yes, but then we do not need that if() anymore at all - if we go in
there, no matter if we have anything to do (like, we have v6 bits set,
and enter the v4 branch).

Maybe that would be a more reasonable approach here... get rid of the
umbrella if(), and check individual bits inside.  It seems to be a
micro-optimization "skip this branch if we have no single feature active",
while at least MSSFIX is active by default.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--K+2dsY0V3DukTaOf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJl01PXAAoJEB2Cnv7KVigSFwIMAKMu71IOnTN33T25Opu8y7yV
mBZbFQLmrehpqQ5NSpkaGTl+JkdLw0QP62d6DsFCofvnl6C36hs4JNaRgpTLg5Xo
I6EUK6XbBaQmt94priqlcvkVl9pgqVWwlD/7G48yf+QhOX0RmQkcMlQRTsoTIPO/
j5Ho0HtYn4/bSJ6zIyJmIZtdV1kxEBtC1f/2CK2SxfXNS12rp86EEpmnK75bY2eX
IDaQXxJdkeiTmLInlA247sNBsxmoZm7W37seuUKSB/6n0KY5gb9UGwqxD8OSLHMs
ruv04diKQwvl3jckZdCjQPbkE1VkN4KM3EP0HZfglgkjmirfvTBpfpcXzcmOQItq
h1oNrXn3R0HAFoy7j3XnfS9nQmdukH/uqevcjCtNyABkYE70S1qw4qaVQhDVLfhd
IHP/S8pPkTuYZGuf8rc4XBvkhEdfXchVpLdaspaKlSi3g7b+C/1qL9x+n8BK2FW+
zA700ik2iHIZClRveV7xAOW3n0/jO1p0eu13Yi69Vg==
=2DJT
-----END PGP SIGNATURE-----

--K+2dsY0V3DukTaOf--

