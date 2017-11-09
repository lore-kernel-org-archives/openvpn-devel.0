References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <20171101220342.14648-1-steffan@...1856...>
 <20171101220342.14648-3-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4757dde2-54d0-0661-9b2c-43f3b9f6f3b2@...2181...>
Date: Thu, 9 Nov 2017 11:17:21 +0800
MIME-Version: 1.0
In-Reply-To: <20171101220342.14648-3-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Vv00JQowonpS60tXBdrKJbO4O8ox0C3wv"
Subject: Re: [Openvpn-devel] [PATCH 2/4 v2] pf: reject client if PF plugin
 is configured, but init fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vv00JQowonpS60tXBdrKJbO4O8ox0C3wv
Content-Type: multipart/mixed; boundary="wjJuIcQcL8tg9FvaljnJMJnijtP4pHiBI";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <4757dde2-54d0-0661-9b2c-43f3b9f6f3b2@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 2/4 v2] pf: reject client if PF plugin is
 configured, but init fails
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <20171101220342.14648-1-steffan@...1856...>
 <20171101220342.14648-3-steffan@...1856...>
In-Reply-To: <20171101220342.14648-3-steffan@...1856...>

--wjJuIcQcL8tg9FvaljnJMJnijtP4pHiBI
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 02/11/17 06:03, Steffan Karger wrote:
> This changes the behavior for pf plugins: instead of just not initializing
> the firewall rules and happily continuing, this now rejects the client in
> the case of an (unlikely) failure to initialize the pf.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>

Acked-by: Antonio Quartulli <a@...2181...>


--=20
Antonio Quartulli


--wjJuIcQcL8tg9FvaljnJMJnijtP4pHiBI--

--Vv00JQowonpS60tXBdrKJbO4O8ox0C3wv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAloDyMEACgkQB6U8WA7y
zXQSDA/9Gctwg/NlxYeENlSKNb3QW6r1f0tihz5P/+q6ubxIt052oEvBENa1VqHL
o4g6HLr6K67uHhQKeCgixfGl6BO+8n++w9mxBbkyZNAaG9UK2FE63LckQZDrMt4/
1X29Iy1GKeGyuskaUyG9nGqF7/FJ0IbFzYRYnRPAUWL2k8r7Xo5hdO29Bh2Uligy
mv+ve7ik/A2EPvjg8kRYl4v7fdyuV68uQBW2AkfKeC2fhrACV4P7K3YLWsaxcloc
GCajMogy6zNS9VYo+P7IJh2DhGorKtG19B1Ahsj5tITzM2x7fU0KNMqYZQw6sIxM
T4h9gFLhV6RXFJM2HCWiKuM7yoeWDqfWtDskiGKISfff+B6IT1RHTfIqd6zaHgK/
PTGJgf7Ke8pi6L4d5xLosS7I9LGPYhmM80EzhEUjXjWMTLDovPDNF8l5bxvSA/Lm
JOLlRQul8RcO0Qupe9rhd1gSJphFfb9ipgD92S0x5XHNRQssYbY0PWxti6sLvwkr
pmA242Hq/1vepgzX36Q2zErP20Zl0LEX5FfhUoGIiVdxq3z8ieoqGwN78+n+raww
OysduocT0tzIAJ8NavQUl2Q9kdI8056dZj6ONOl0/xn4DPJwslqh7EQjX45pCr/C
ap99Mtom7o6opUFTgRr2mp6W7Gyb/xdMY2mP4LKhTdhR6aHj6fk=
=k0Sd
-----END PGP SIGNATURE-----

--Vv00JQowonpS60tXBdrKJbO4O8ox0C3wv--

