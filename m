References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...> <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
 <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
 <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
 <CAKuzo_gp9jcVocxgf79TNQpgP-ScioC1pM_3oTq9+SHHAhEonw@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <665fcdae-dad7-b6c8-14ee-512ff7992963@...2181...>
Date: Thu, 7 Jun 2018 13:51:19 +0800
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gp9jcVocxgf79TNQpgP-ScioC1pM_3oTq9+SHHAhEonw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9lZWvZPlGtRzfop2Tzbchn7F9eRWxT1PT"
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9lZWvZPlGtRzfop2Tzbchn7F9eRWxT1PT
Content-Type: multipart/mixed; boundary="1Z2wa8YC3vz4lk5lBQKxuUDUYAjxJN415";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <665fcdae-dad7-b6c8-14ee-512ff7992963@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...> <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
 <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
 <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
 <CAKuzo_gp9jcVocxgf79TNQpgP-ScioC1pM_3oTq9+SHHAhEonw@...278...>
In-Reply-To: <CAKuzo_gp9jcVocxgf79TNQpgP-ScioC1pM_3oTq9+SHHAhEonw@...278...>

--1Z2wa8YC3vz4lk5lBQKxuUDUYAjxJN415
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Selva,

I have tried to account most of your comments, but something might still
be off. Building openvpn for Windows might need some time here as I
don't have the entire environment ready yet.

Would you mind giving my latest branch a try and let me know how it goes
with regards to your previous observations?

Find it on gitlab: https://gitlab.com/ordex986/openvpn/tree/ipv6-only
(git: git@...2407...:ordex986/openvpn.git)


Thanks!

Cheers,

On 07/06/18 04:28, Selva Nair wrote:
> Hi
>=20
> On Wed, Jun 6, 2018 at 11:40 AM, Selva Nair <selva.nair@...277...> wrote:
>> Hi,
>>
>> On Wed, Jun 6, 2018 at 7:33 AM, Antonio Quartulli <a@...2181...> wrote:
>>> Hi,
>>>
>>> On 06/06/18 04:30, Selva Nair wrote:
> ..
>=20
>>>
>>> I am not sure why you get those 2 routes. Do you have a more extensive
>>> log to show? It may help clearing up some doubts.
>>
>> Don't have access to those logs right now -- will post later.
>=20
> The logs are here:
> https://gist.github.com/selvanair/fc8c74ce83bfa0c93aca8bec97dd091b
> (sanitized). --redirect-gateway !ipv4 is in client config
> (not pushed), no other routes in config or PUSH. ifconfig is rejected usi=
ng
> pull filter as seen in the logs.
>=20
> Actually despite the "errors" the connection has succeeded, appearances to
> the contrary.
>=20
> It doesn't say anything more than what we already discussed, but may still
> help.
>=20
> Selva
>=20

--=20
Antonio Quartulli


--1Z2wa8YC3vz4lk5lBQKxuUDUYAjxJN415--

--9lZWvZPlGtRzfop2Tzbchn7F9eRWxT1PT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsYx9cACgkQB6U8WA7y
zXSlgQ/+P3JiKtCxZ5ewrGu3b3C7Ugjd1i19XUPrTZJZK7S7gFedVHdzNC48iKoi
pReAo1jt0xjawELfUd4AQeYb5rLmh9Q0w11uY1+13fRG8R+GFUNTevcjCPCkTKAS
F1HzwVtsyUvzIfMhKvXI3ZTVLDa8WSoAB/l+n35AS/pnz8/IHFYjV1V9MJeOqtq7
eo76J/sKzoDFvmxau8Bf6mSj+Bjx2EbeLv9nJrppGtK6yAJ53N4Y/vmc9I54Q9pp
c7qZvj66iEMV2CT7KwH/+yhDDGMdC0CRuV55VTC1L4P3Nt6Q2gxK8m13wowEFqXy
nCVBT+v1ED9Hj2g7ga8VVL0X+u1K00UVanjVqEUGy7ivi9hxAu6mcVlgKbLOx4jJ
RS1qLG66wHJSBgAAM5eiocpRQq//WdHQ1yq3ryrzcZisxVlTzOCVCczcS1dYnHeI
NcRC+HsGp3ITWuIyeOIHkYzteUoPEyO44dWTeJreXJsK67r2i5xHMqSa59H82T2R
NN4tH+SbahJB61igTi/2kfFwuG3clPyKIkzDPH5l3UgVVgDCNdKf69TG9iRJ7Dwq
ZqUe4adbJ4sdCKnP5qbySahV01eVSaQvTRqOVrHKAUZvKzACzAl9zLwtqbtHvcSf
Qkkvm1x0QQLvBJhv8U9IaAC/yAkXVAKCITqGLtm353NEou8rITg=
=mF8/
-----END PGP SIGNATURE-----

--9lZWvZPlGtRzfop2Tzbchn7F9eRWxT1PT--

