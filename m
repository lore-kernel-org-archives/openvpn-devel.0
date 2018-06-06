References: <20180605090421.9746-5-a@...2181...>
 <20180605093628.4985-1-a@...2181...> <20180605145139.GN57262@...1296...>
 <3909b854-7b38-a8f8-945d-f30bc60a0a6f@...2181...>
 <20180605184325.GP57262@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <f80bf9fb-d3f7-470c-8fbe-285ec7890707@...2181...>
Date: Wed, 6 Jun 2018 09:35:35 +0800
MIME-Version: 1.0
In-Reply-To: <20180605184325.GP57262@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="e0XFhHbZ96kKNN2vMLuv8cTSVoiYot2W3"
Subject: Re: [Openvpn-devel] [PATCH v2 4/5] pool: allow to configure an
 IPv6-only ifconfig-pool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <antonio@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e0XFhHbZ96kKNN2vMLuv8cTSVoiYot2W3
Content-Type: multipart/mixed; boundary="HN0i22Itl9Gi2iGnkomterOFJZ7M4I1pf";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <antonio@...515...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f80bf9fb-d3f7-470c-8fbe-285ec7890707@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 4/5] pool: allow to configure an
 IPv6-only ifconfig-pool
References: <20180605090421.9746-5-a@...2181...>
 <20180605093628.4985-1-a@...2181...> <20180605145139.GN57262@...1296...>
 <3909b854-7b38-a8f8-945d-f30bc60a0a6f@...2181...>
 <20180605184325.GP57262@...1296...>
In-Reply-To: <20180605184325.GP57262@...1296...>

--HN0i22Itl9Gi2iGnkomterOFJZ7M4I1pf
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/06/18 02:43, Gert Doering wrote:
> Hi,
>=20
> On Wed, Jun 06, 2018 at 12:11:40AM +0800, Antonio Quartulli wrote:
>>> Without having done much review here, just one initial caveat: did you=
=20
>>> test this with --ifconfig-pool-persist?  What happens?
>>
>> It should just be ignored.
>> At the moment pool-persist works only for IPv4 and there is no support
>> for IPv6. This has not been changed by this patchset.
>=20
> Well, it does save the (calculated) v6 address into the save file...
>=20
> So, what happens if you run a server with --ifconfig-pool-persist and
> no IPv4?  Will it crash, not write anything to the file, write garbage?

It won't start. --ifconfig-pool-persist *requires* --ifconfig-pool that
is a v4 option and is not set (normally set by --server).

However, even if we were to remove this option check, it should write
the proper IPv6 into the file, but would not read them back as per the
check below.

>=20
>> I added a check about it in ifconfig_pool_read():
>>
>> 521     /* IPv6 logic not implemented yet, therefore bail out if no IPv4
>> pool was
>> 522      * configured
>> 523      */
>> 524     if (pool && !pool->ipv4.enabled)
>> 525     {
>> 526         return;
>> 527     }
>=20
> We should aim to make this work as well (but it could be patch 6 of the
> series :-)).
>=20

Definitely :) I just thought that "it is not there now, so it can't be a
regression if we don't have it after this patchset". :)

However, it is definitely something we can add as extra feature at the
end of the patchset. I'll see if I can squeeze that into v2.

Thanks for the comments!

Cheers,

--=20
Antonio Quartulli


--HN0i22Itl9Gi2iGnkomterOFJZ7M4I1pf--

--e0XFhHbZ96kKNN2vMLuv8cTSVoiYot2W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsXOmcACgkQB6U8WA7y
zXT0hg//Xc9kOR+HsH9VKueCAPMsOZ03m46ZRENWKl524Lwj6EJNMP0pjay4CFDO
H8v4THNVlxuFotBgETdnjvPmbZ4VTVXjkSMpF0fSzx5m8c6f3MBq/3VsujiZSoKf
EVHOKelLC7FKWi6ZmNsGV47cJGGItUl1EjTXda0Yn7O5vZsIU8+lTzrSApzJxQtU
bZlTadoIwFWxbPohDMjK9GEdThg3up25O8aJDGzmHsqmVCaUowz5+g05WVwSHPBl
WUdiDgvKKsXmXM8q2k52a4EBbj7T/fUPqE7uS9cIzKQXxQoOCmWbpzzie3E2mVO1
Tktys9B1QZpSbEh5sI2CtVKuOp46AfqDCKimzIP/EQMB7WGZ+KrQ9koHvltUHI71
4cCdE445x63uKG8MvlTG5+nrb2KHZJ8JxBshDsbf5h4NwjxTGKlNGzN8mnVeyjav
FLPqyOyoBfmTzvETp+8V14axDxYQs8ATLehR/qqlfo1QBaKa9Fk/3bwO+20ARqpD
A7jBFYYPhwDXs3TePiWGqigRRLF1318QD29XMdGpMt19T7es3Dk4LW7XMZaFOwEo
TyoPrOh6jLHe3ci+6t7ktKIHPgE01W2xjyJ1aUJ6LJLgP12HQaNMVfkXfAQavKVU
6ylSelrQL1cJ2EjD20rlY3JQ8Su0x+VisH6SJYLqUvPNS4xvJNs=
=owSn
-----END PGP SIGNATURE-----

--e0XFhHbZ96kKNN2vMLuv8cTSVoiYot2W3--

