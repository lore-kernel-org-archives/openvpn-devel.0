References: <bd464d61-d16e-4a9b-de38-f96891e65368@...2525...>
 <7b72d228-e801-b490-86d5-6e763919d317@...1227...>
 <cb0d489a-b2e2-bab8-b774-bdfb6e20376d@...2525...>
 <54a17061-3fdd-5097-a59c-56a55d43c447@...1227...>
 <20190824194037.GA1349@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <088231be-2a32-cd4b-a758-01d03c04aeca@...1856...>
Date: Sat, 24 Aug 2019 23:14:41 +0200
MIME-Version: 1.0
In-Reply-To: <20190824194037.GA1349@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WowfejYgPuJ0EvBKJoC186RwXbkOMiFbh"
Subject: Re: [Openvpn-devel] [PATCH] Adding support for wolfSSL backend
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WowfejYgPuJ0EvBKJoC186RwXbkOMiFbh
Content-Type: multipart/mixed; boundary="aYzdaotPhOMIbtAxhn22oHpS7S0cpEjkP";
 protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <088231be-2a32-cd4b-a758-01d03c04aeca@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Adding support for wolfSSL backend
References: <bd464d61-d16e-4a9b-de38-f96891e65368@...2525...>
 <7b72d228-e801-b490-86d5-6e763919d317@...1227...>
 <cb0d489a-b2e2-bab8-b774-bdfb6e20376d@...2525...>
 <54a17061-3fdd-5097-a59c-56a55d43c447@...1227...>
 <20190824194037.GA1349@...1296...>
In-Reply-To: <20190824194037.GA1349@...1296...>

--aYzdaotPhOMIbtAxhn22oHpS7S0cpEjkP
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 24-08-19 21:40, Gert Doering wrote:
> On Sat, Aug 24, 2019 at 06:04:21PM +0200, Arne Schwabe wrote:
>> I want to give you an honest opionion of mine to merging WolfSSL in
>> OpenVPN. Please note, that this is my personal opinion and not to be
>> confused to be an official OpenVPN community project or OpenVPN Inc
>> position.
>=20
> Arne summarized things quite well.  New and large additions need to
> balance "what *our* users want/need", "what the core team finds=20
> interesting enough to spend time on" and "how expensive in terms of=20
> maintainer lifetime will it be to maintain that stuff".
>=20
> Since we're currently short on contributors that can review crypto
> related code changes, and we do not have anyone in the team today
> that can review WolfSSL interface code at all, this isn't likely=20
> going to happen in the near future.

Just like Arne and Gert, I believe we're currently not in the position
to take on the maintenance burden of adding another crypto backend. I'd
rather spend our time on fixing bugs and improving openvpn performance
(the crypto libs are not the bottleneck).

-Steffan


--aYzdaotPhOMIbtAxhn22oHpS7S0cpEjkP--

--WowfejYgPuJ0EvBKJoC186RwXbkOMiFbh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEED9EpzGW9WeE8Ifd8mALKPQB+0ogFAl1hqMsACgkQmALKPQB+
0og7kwf+ISMoLmLtrGkHTsBYyjNq+mbexzQyJAZlYEA0kS9jblDRQ9fLMxQz8K37
lohoHJmsmsgoR7yqX4r8DjelUhKufdfWp0jAL5ZrgmlPLDx7bSWzsjZdP7jmd+VV
jpyoERM+iP+ZWqXHddltTFmmIViPCXGqjpEdZgtQ1vEVTvUGFZGcGhWwx97sgkGO
abFkEDTtIgBQjgpjIyWz3TnGCb2lEiwDHV7sbRYHivuFzCHb0SjA+pC8sj/KsksL
tsvW5Dqo0+NtNEbB2XN/Mnx67ZNBw22NmhLLQ/cS9X2HJjJZHW+YiU+U2Rufrp5X
jA/zk/mqap5UDgZdrew8hr8BOncWHA==
=+A6L
-----END PGP SIGNATURE-----

--WowfejYgPuJ0EvBKJoC186RwXbkOMiFbh--

