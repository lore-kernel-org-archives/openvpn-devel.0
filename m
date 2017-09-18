References: <20170828085620.23186-1-a@...2181...>
 <e22ea0fa-4e1b-980b-a1a2-dc4ba1352a6d@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <a187f8ca-afe6-5633-9d3b-be22aee9a3ec@...2181...>
Date: Mon, 18 Sep 2017 13:18:49 +0800
MIME-Version: 1.0
In-Reply-To: <e22ea0fa-4e1b-980b-a1a2-dc4ba1352a6d@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RqB0a8iA31g479xosmHSr680dUpwH6vKB"
Subject: Re: [Openvpn-devel] [PATCH 1/2] merge *-inline.h files with their
 main header
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RqB0a8iA31g479xosmHSr680dUpwH6vKB
Content-Type: multipart/mixed; boundary="sNQwSXQiSBP4scXt9KDBkBum16GTvVM3d";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <a187f8ca-afe6-5633-9d3b-be22aee9a3ec@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] merge *-inline.h files with their
 main header
References: <20170828085620.23186-1-a@...2181...>
 <e22ea0fa-4e1b-980b-a1a2-dc4ba1352a6d@...1856...>
In-Reply-To: <e22ea0fa-4e1b-980b-a1a2-dc4ba1352a6d@...1856...>

--sNQwSXQiSBP4scXt9KDBkBum16GTvVM3d
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 17/09/17 20:00, Steffan Karger wrote:

[CUT]

>> @@ -101,4 +104,16 @@ void pf_context_print(const struct pf_context *pfc,=
 const char *prefix, const in
>>=20=20
>>  #endif
>>=20=20
>> +bool pf_c2c_test(const struct context *src, const struct context *dest,
>> +                 const char *prefix);
>> +
>> +bool pf_addr_test(const struct context *src, const struct mroute_addr *=
dest,
>> +                  const char *prefix);
>=20
> Why are these no longer inline?  They seem to be simple wrappers to
> prevent a function call is pf is not enabled.
>=20

Oh, I needed sometime, but then I understood what you mean :)

You are saying that by keeping this function inline, we have a slight
performance gain because we won't invoke pf_cn_test() when pf is
disabled. And such decision can be made inline.


I agree. I will send a v2 of this patch.


>>
>=20
> Otherwise this patch looks good.

Thanks for reviewing!

Cheers,



--=20
Antonio Quartulli


--sNQwSXQiSBP4scXt9KDBkBum16GTvVM3d--

--RqB0a8iA31g479xosmHSr680dUpwH6vKB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlm/VzkACgkQ0+HICM1s
oFCHKA//YTH1i7BhnoXhsP+kTYT2T0U/cAm9nw7XZVZAc0g4SmEydhp/Srt9ED+t
71s5O3bYxMP0ckiXLguKik8BTLJ4dfV0Mnr6TnGQnRQnqAQNFSX9uZHM66PItOGR
kBMtwBYqUKO4s1oqzY3NvxGmr8ArqqJM8bw6bzAJQP4fef3IZrSNeaD38ptztHUa
TZpy6LHNKuy/zVwLAO/PFeD403jfilUNPDYBKfo5tqXMn360EuPCNJHlMteckyBL
cV8Uw2rSgD5tTpC2+BrV6b4SZCoZrukyQqb4CTuWZJAT5qXcYOxTPp45s7qeJVSu
w6xVKRthpcUMSAtPFx+45jzVU/NjFth9TtGxnHgPF6vQVkjFDbRlfF1oyQ5q8It3
TVaVVvXMjgaBh7hh79ds3bTNdVd7Sp2uwKQcJc2QUl5Xa0/KQPcQylQ/nP8n6y0Z
FZuYw1fakbLFk8NNLG2x1TMwEAL9z++ngBNhLQ9rQGO2ciX9HLBmrWDXmHE8nPH2
wZeV5KuX0YvWzlP3nwjLhOqyuHCgxqpTsrgKMycDoZ8sNXKGm90uY5aIxGexUIvU
6h0EnZGEjvWqLawE4YKEHlXLoQ+BbExS+oyqIg1yzi3bAVcTtwqU8tBMhzBq4V8h
ZCRkmtQqikNfQu4gFpqgJJ5sgySO1XV+5qbiuqhsVOf2TtDET1c=
=KEdz
-----END PGP SIGNATURE-----

--RqB0a8iA31g479xosmHSr680dUpwH6vKB--

