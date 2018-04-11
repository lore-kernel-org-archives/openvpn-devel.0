References: <20180401131615.12567-1-a@...2181...>
 <e3d48a12-7f25-1ec0-ad7a-52c1330f43c0@...2181...>
 <20180411091542.39c8c01d@...1799...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <5299586c-24cb-d2ff-c12d-404b4a139377@...2181...>
Date: Wed, 11 Apr 2018 15:43:11 +0800
MIME-Version: 1.0
In-Reply-To: <20180411091542.39c8c01d@...1799...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KycAsGrTGNZ4EcPRzWxDXZoM2hN4NkFIW"
Subject: Re: [Openvpn-devel] [RFC 0/4] add netlink support for Linux: update
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KycAsGrTGNZ4EcPRzWxDXZoM2hN4NkFIW
Content-Type: multipart/mixed; boundary="rET0nq3FO59Hsu55OWrKjdc3poafuRb5i";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Christian Hesse <list@...1798...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>
Message-ID: <5299586c-24cb-d2ff-c12d-404b4a139377@...2181...>
Subject: Re: [Openvpn-devel] [RFC 0/4] add netlink support for Linux: update
References: <20180401131615.12567-1-a@...2181...>
 <e3d48a12-7f25-1ec0-ad7a-52c1330f43c0@...2181...>
 <20180411091542.39c8c01d@...1799...>
In-Reply-To: <20180411091542.39c8c01d@...1799...>

--rET0nq3FO59Hsu55OWrKjdc3poafuRb5i
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On 11/04/18 15:15, Christian Hesse wrote:
> Antonio Quartulli <a@...2181...> on Fri, 2018/04/06 15:43:
>> Two new files, namely networking_sitnl.c and networking_ip.c, provides
>> two implementations for this API: one uses the new sitnl code (netlink)
>> and one uses iproute2.
>=20
> This complicates the situation for my followup code: Running the process =
with
> unprivileged user works with netlink interface only. If we want to support
> netlink and iproute2 we end up with creating the files from templates (or
> carry static files in at least two versions).

Keeping support for iproute2 is part of our agreement during the
discussion at the last hackathon. Some of the reasons might be
summarized in the hackathon page on the wiki. Therefore, we need to find
a way to deal with that.

>=20
> This kicks into the discussion we had about supporting newer systemd feat=
ures
> selectively... Shipping different static files for distributions and/or
> systemd versions duplicates the number of files.
>=20

I am not into systemd, therefore I am not able to comment on the
strategy we need to adopt.

However, what I imagine is that each distribution, when deciding what
library to use (sitnl vs iproute2), will also decide which of the
provided unit files to ship (if we have multiple precompiled files).
Or our Makefile should generate the right ones based on the
--enable-iproute2 switch (maybe this is what you meant with templates?).


Cheers,


--=20
Antonio Quartulli


--rET0nq3FO59Hsu55OWrKjdc3poafuRb5i--

--KycAsGrTGNZ4EcPRzWxDXZoM2hN4NkFIW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlrNvI8ACgkQB6U8WA7y
zXRqUg//YGvRcbulf4Y3Gpd5RvLOPjvyOkA18mG4GNP3+3ciG0hCofcMCmQWUY5Q
3cva0u1CVgcr8H3CmdWBZvHiGVrW43sXGWv+z5zRrtOXng0hRcOYwepmlhAMK1Pt
N6WOMJt9imF9cnfGJqVBBocnrY63KVyTgum8iuyRiDoysuib2vT5tsfKKGzO4qGp
008eNtbevqrSqu0R+pX6tkglP3/6FEPrn/5EcfK76AjuKZASaFzg0Ur3SuQHAe7C
hzTXRebswUJu8zApoip5jJ/Ga6J5har1usp7r9fJTY1XZnJwgoTeYQdBGJLixM8N
0JyrUA3T8n1DJK86/VgMp9oc5D6VhrGIeozEIOETt6hiryJCdXKb56aZo+ZtV06o
WLRCArUL8FAfwE6LLGg+hYfD1M+79hAaUFax7pkz7cl012IaMmkkqyaJcCc/v9br
qhLlwMyKxMldjC3fG4Wp1/Uxnk+a1XeMQyYtd03YH0mDxNiS25tX2sJpAFv0RZkD
wfI9xrX1C8L73f8o2Hzocc8wTpGmNkYY6GH5q7sDKZsZhnxA1KktGELSPhbCcn+4
ulZ9UQQNsXBRYHTqliD3z/hyejQ+TC4VYbXyfU/p9Q7SBNi/wG+Obj3VOTY+mHeZ
kgxRNSzq0WEKjkePqNXROQs2pn8uRx/pr2s8B6r6UlEqeEdeaFk=
=GjNr
-----END PGP SIGNATURE-----

--KycAsGrTGNZ4EcPRzWxDXZoM2hN4NkFIW--

