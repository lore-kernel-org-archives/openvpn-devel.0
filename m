References: <9a1a18c6-67ff-73ad-69aa-bbb75df45490@...515...>
 <07d3e88f-6f34-79b3-7244-a057b0820443@...515...>
 <4b142edb-34f0-2b53-8012-8b8d553de323@...1147...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <f5ade374-b6bf-9571-bac0-7dd6fafb1fa2@...2181...>
Date: Thu, 20 Dec 2018 10:26:33 +1000
MIME-Version: 1.0
In-Reply-To: <4b142edb-34f0-2b53-8012-8b8d553de323@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gv3jt0MIqFpMa6d9Mpd6fJw6hUbWYqvWe"
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 19th Dec 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gv3jt0MIqFpMa6d9Mpd6fJw6hUbWYqvWe
Content-Type: multipart/mixed; boundary="5XrBfZy14oVkYgf9y1IOke59GWz0sPFO8";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <f5ade374-b6bf-9571-bac0-7dd6fafb1fa2@...2181...>
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed, 19th Dec
 2018)
References: <9a1a18c6-67ff-73ad-69aa-bbb75df45490@...515...>
 <07d3e88f-6f34-79b3-7244-a057b0820443@...515...>
 <4b142edb-34f0-2b53-8012-8b8d553de323@...1147...>
In-Reply-To: <4b142edb-34f0-2b53-8012-8b8d553de323@...1147...>

--5XrBfZy14oVkYgf9y1IOke59GWz0sPFO8
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 20/12/2018 02:00, Jan Just Keijser wrote:
> No, it is NOT possible to specify a new "auth" parameter, e.g. "auth
> sha512" as this would break many things, including tls-crypt.

Little note here: tls-auth would "break" because it learns the algorithm
to use from the "auth" parameter, but tls-crypt(-v2) statically uses
AES-256-CTR/SHA256, so that can't be changed.

Cheers,


--=20
Antonio Quartulli


--5XrBfZy14oVkYgf9y1IOke59GWz0sPFO8--

--gv3jt0MIqFpMa6d9Mpd6fJw6hUbWYqvWe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlwa4bkACgkQ9FVsWUWD
Dm0H3A/9Gd31T4cMHWA8uAIugQDj4hhv+UXX8u6AiIcptvr75oWS5oaelfei2Q6W
Kp3nEKh2MrLg1Nzshh3lnpG++p8JGjGCL5WTrqTKdQnqzQIW0nnzqwXfZm+BYlyQ
XfTygWUgD2gUQCMoUuEZBKY9lRJawgOI/ZgiezKOKoYBtYsyVm9SyYK7c37AXlCx
TpSo9MVaRiMCgnktKihSbPh3t5VQqy58qxkwAk9BLXvoFB3ridS7152alWPEv6Qg
aE9e+yHyZuW4Mm+8raT1itkNGFVR8ObXHHUowfoKZuQT0sltpnWLmZvQX/JytIhM
CAS8C3N9wyMYmeW4gOQ1jCdLXZhjB2PlOQ+OVwyXnoMq9lFTx7na2A6mQsoJo+ir
mkzoIKtLkH+DkLNa9H7jGYbRe5g+8Dt/rKfXtckgg00I/ZZkbweQzTMwJ20eJ2ks
mnVb45884pC1pNUtuQ5f5inWqeH+9FojmNV6P4ddg2ukQuk2FqGdrPDY1k2SLe83
PxwiNJG/slUU5DKpZ03KQT5mmVGheAagDlPd0Iu5OnUMh5o4Bl+GT4hnwj4BLQJ7
mPsunvMOMxZecxN9RPvfGvCkSat5GvdzOfkn2uI4gL4rRrFzSDkaA4rgOhlWKm/w
HufpHX8F6tOc6zWpNBZajJd6ZTQKUcuPzeQ5Dd/KT8UE/Sz1alQ=
=4K3b
-----END PGP SIGNATURE-----

--gv3jt0MIqFpMa6d9Mpd6fJw6hUbWYqvWe--

