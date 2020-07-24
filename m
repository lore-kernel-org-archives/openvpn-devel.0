References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-8-arne@...1227...>
 <6fe3f761-ea6e-4b52-36b1-24d20a92a97b@...2080...>
 <145d42e9-1a92-2e60-b494-f49f381ce662@...1227...>
 <c8c30f1b-f378-f2ce-3b9f-390fb8f08582@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <fb8b822c-4cc5-54b5-59bc-1f9ababc0171@...1227...>
Date: Fri, 24 Jul 2020 12:45:10 +0200
MIME-Version: 1.0
In-Reply-To: <c8c30f1b-f378-f2ce-3b9f-390fb8f08582@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bXkrH3kcmWPZfkZaQK16H3Kl54OrUkgrx"
Subject: Re: [Openvpn-devel] [PATCH 8/9] Rename ncp-ciphers to data-ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bXkrH3kcmWPZfkZaQK16H3Kl54OrUkgrx
Content-Type: multipart/mixed; boundary="BvHGnASQXRuZyf1xHPqhP0ueMofhNHFP6"

--BvHGnASQXRuZyf1xHPqhP0ueMofhNHFP6
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

First of all I did not want to reply to this since we had a lengthy
discussion on IRC.

> Lets take a few steps back try to see a broader picture.
>=20
> * --ncp-ciphers was introduced in OpenVPN 2.4 as a brand new option.
>=20
> * Steffan has suggested to add --data-ciphers alias into the next v2.4
>   release; to which I agree(!).

Yes, this sounds like a simple idea but also has the danger of creating
more confusion.

I feel it better to have ncp-cipher and data-ciphers coexist. Then you
also have the understand that ncp-cipher is an older/less capable
version of data-ciphers.

OpenVPN 2.4 has a number of oddities in NCP support:

- the client always announces AES-GCM support even if disabled in
ncp-ciphers
- the server will always push the first cipher of its ncp-ciphers list
to the client.

--BvHGnASQXRuZyf1xHPqhP0ueMofhNHFP6--

--bXkrH3kcmWPZfkZaQK16H3Kl54OrUkgrx--
