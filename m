Date: Tue, 11 May 2021 08:02:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210511060213.GT976@...1296...>
References: <20210429171504.1081888-1-tincantech@...2282...>
 <0a188829-5a2c-362c-eb6f-61ffe657042d@...1227...>
 <_HUflzeIntsfJCr8BbPWvJqUE4YsZ4mnoeBBWWAWz5wXnrnJDSOgFNA8jXs4BX8W8rVR0-mttPOc8wCQ1Ou96EEB2a-ytMFQs33l9yGgwIU=@protonmail.com>
 <635b6cff-1742-e69d-fe91-fc33a5495a7f@...1227...>
 <tu-jUfrw68jHsNHY4mkYfTk6lbF5HjbdUUgJihX0J0-32Lq2yks9rUPrsX7v4fEA5TTb4-fj6mfZXe_ERsXLiLBBiwBQpkA0_ozsihQxIKc=@protonmail.com>
 <20210510172920.GP976@...1296...>
 <y2lmaEJRnB6BjT22cIwFGYiqA1Qq1Ipbqkl4m9N4EaxQvx75mCaX8p53HPHFkoNMmDBX7s4szU1E2pGbIFwgJrbolUA6Yh5SYv4E2e-mGs0=@protonmail.com>
 <CAKuzo_g59fe97KOzuAfzuGKGR0_eLCyrULupw-u-irBebS2L1Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pDaxhG5XNnZXekRS"
Content-Disposition: inline
In-Reply-To: <CAKuzo_g59fe97KOzuAfzuGKGR0_eLCyrULupw-u-irBebS2L1Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add daemon_pid to --tls-crypt-v2-verify
 environment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: tincantech <tincantech@...2282...>, Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--pDaxhG5XNnZXekRS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 10, 2021 at 06:10:33PM -0400, Selva Nair wrote:
> > > So, there is an ACK-and-merge pending :-)
[..]
> I think it's a good thing to pass daemon_pid to all scripts uniformly.
> Can't think of any downside. And, on Windows it's a pain to get the
> parent pid from a batch file. Personally, I do not have a use case
> though.

This was about the thoughts Arne and I had - if we have daemon_pid in
some places, we should have it in all places.  And, on Windows it's not
as trivial as on Unix...

(Out of interest: is there a way at all to get the ppid from a batch file?)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--pDaxhG5XNnZXekRS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgmh3kAAoJEB2Cnv7KVigSiIIL/3bSoqrKH5j6AVkWYAOEmDJV
Gz3aqKn31oNqQW3dC3UsEgXoh2deWzLSyi9cIPRcQIieCEIozR5DN1gIU5Y6zXES
gtER7ewuLKjof6s87WbVJlFNX02LvLXHbGoZ27i+62ojaSNwY0bDHK+tHVg0luyP
AbRjdq5vaB7QJp45raSIa4KnmnrkHd0l7Vnd2TlpN/IxcEkgHQqb44MBIfPSc3G4
9Ej1lspYGKU1mJrpb9HnbbNbad/Ru02V1iI4QtLetnVALaY54yXafN7uxFwe5kuN
EZK8L9ATpsmkoD6Yjjn/Pi72m2cq2nkx/fttMt06xAyUgiNrAVGS9KlG+zcSAdKq
In+TW5U/QfEKYLCGPC7w8yfA6NWhUk+bogiJJ83nc1lomx+Qx1W7y6PW9hvMRCoR
eocArzICLSKaEGGhsYlmvSKM4newFskg5z1rs4w3hDfuQbU3qVkrpB6HSFdVp5cb
UaWxpu1QBpvYrlj3cQxtWXXif7suVMzKNEufI3ekXg==
=Q8QY
-----END PGP SIGNATURE-----

--pDaxhG5XNnZXekRS--

