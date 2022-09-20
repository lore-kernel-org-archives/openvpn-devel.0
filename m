Date: Tue, 20 Sep 2022 18:42:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YyntXHQMcmih8aLE@...1296...>
References: <20220818084825.187755-1-a@...2181...>
 <20220918220618.31112-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ThYXSmfXmQEtipR6"
Content-Disposition: inline
In-Reply-To: <20220918220618.31112-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v4] push-peer-info: rearrange function
 generating peer info
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--ThYXSmfXmQEtipR6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 19, 2022 at 12:06:18AM +0200, Antonio Quartulli wrote:
> +    switch (session->opt->push_peer_info_detail)
>      {
> -        /* push version */
> -        buf_printf(&out, "IV_VER=3D%s\n", PACKAGE_VERSION);
> +        case 3:
> +        {
...
> +        }
>=20=20
> +        /* fall through */

These {} brackets are not needed by C or our style guide.

Is this for uncrustify appeasement?  (I find them irritating)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ThYXSmfXmQEtipR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjKe1cAAoJEB2Cnv7KVigSW98MAKbyGdiETbGtwwMTB0E5CNvr
GkpTzjPDmGMt8roaSawpjC3sasL1rhcsh83bwWJ1U6VijrfzQ9owYmcAbXBvT5Iz
NUO5AdtbOtCJFqUzOta0ijqnWU28wLZdfhn1X1uEQYHj19hOD6eemNJthDdn5jim
KhW9QXHI2YKAzg/5pU8qBznjbaZY2NCeLb34YzzgpVoaYR+CWfrlO2M/d9AtH/pC
6epAOIdy27c7RXOlakqhscgViCumOrVhzhqgxonlYh2ldBtjZUp5V5xlFBSGRJLe
w6Q7LTiAKx8Hr303PZTRR/6RHysW5QQe+hUtmubk2qhAFJyJ19nCz3UaGMMlDGxo
7F/ubq1boRQ6lW5y91sgoI/BMZXREaZBQidlBf/Dh6ECs4llazEvs4aRfVxldi+G
Eof7ULoxaQxs8cod8Gy0bIw8K2SC5eGjWXhOwejZxKSfv4nHEG4YKrosioN9LrH6
eRl9tzvjoi2PuQmgC8AUiOgYG4SOpFNK0tuG11Braw==
=c2mr
-----END PGP SIGNATURE-----

--ThYXSmfXmQEtipR6--

