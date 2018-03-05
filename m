Date: Mon, 5 Mar 2018 10:18:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180305091826.GR69387@...1296...>
References: <CAFHpkQF6_DU+OX1h3oyBG811jPAXqFN4U63aC8rjUnMgAYevAQ@...278...>
 <CAFHpkQHsPHq+eqA3yU1UHFO8RPtakXRQ_UoenH1YoOeizQdX5Q@...278...>
 <CAFHpkQFr+LxcuMXWJ5xtU5v1J3mtbiVerJ-bAZ0WyFLgFAXQYA@...278...>
 <CAFHpkQGLwXM_pTss8QpQx14ODDpEt7mo0NkA_ZR0pw3_a=2usQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tiH+Y7KRmUKKY6DB"
Content-Disposition: inline
In-Reply-To: <CAFHpkQGLwXM_pTss8QpQx14ODDpEt7mo0NkA_ZR0pw3_a=2usQ@...278...>
Subject: Re: [Openvpn-devel] Getting rid of bundled lz4 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tiH+Y7KRmUKKY6DB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 05, 2018 at 09:48:17AM +0500, ???????? ?????????????? wrote:
> It was broadcasted several times that we will get rid of bundled lz4
> someday.

It was discussed whether we should do that, and there is no consensus
either way, at least for now.

> Currently, windows installer is built using that lib. Does it make sense =
to
> change windows installer?

Not sure if this is beneficial.  Since nobody else would be providing
the shared library, we would need to upgrade our builds if a lz4 security
issue is found - and in that case, it doesn't really matter if we upgrade
the windows build or the bundled lz4, since we have David's script to
do the latter easily...

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--tiH+Y7KRmUKKY6DB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJanQthAAoJEB2Cnv7KVigSUCwL/iFjC84spl9LPjJ9K2c5zFag
8rN8x57erLMkDSvjWc6qtXbkpHxk1FmdkjB3dij5gxy8sCpbDusBa4XI7H5Qq3Ec
ELnbgnbcTQ8EjJcqwJulPBIcMd6X0BUjWxAJtLf5dG3vJIG7EXyV6KV1pSUu7BRi
8OS0tYMyrqjnop9d/2KhGWLN8Sq4ThZ290ndcVTmTSD/RjNh8iQhNdQkGan9jBw1
iGsd+0MS/TgKKsUAgboEBlEowPpC76wJW7FATzikfZGX6h6mJpOo1Ot6x/fDHQez
g3nV3V/7asDlZirVKuuCANCsRAPuIEy0l38R7DekK5mQ+2k72Q1WVwXWCOOFuxlK
fzKOZr1vU8If53qf6koJaHI9fcJbKA7jDzH6tggM+mcPt8j+MPQY0khiygi0H/3b
3sKzU8Vi5mj2GwxDbaRDBZw2oEC/YG/TRfpWScggt8lRBM3yC64koHZY1UmR8BhD
11abVfsOZ2STIQ0dMT/EeLnQrBSgMjOlFmcakctZ4A==
=Y9Qt
-----END PGP SIGNATURE-----

--tiH+Y7KRmUKKY6DB--

