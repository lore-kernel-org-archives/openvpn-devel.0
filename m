References: <1498913642-32459-1-git-send-email-steffan.karger@...1435...>
 <1498913642-32459-4-git-send-email-steffan.karger@...1435...>
 <e063898a-6b6c-d716-824f-8e10b859d692@...2181...>
 <6c1bc6fc-4c09-2d9d-56fb-130c7aca2055@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <a50ec7d2-3a45-f247-26c9-9b45dafdbed7@...2181...>
Date: Fri, 29 Dec 2017 17:27:43 +0800
MIME-Version: 1.0
In-Reply-To: <6c1bc6fc-4c09-2d9d-56fb-130c7aca2055@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zt0jr6ZTJcV1TCuLanqcyQuaEAC45TIC7"
Subject: Re: [Openvpn-devel] [PATCH 4/5] buffer_list_aggregate_separator():
 prevent 0-byte malloc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zt0jr6ZTJcV1TCuLanqcyQuaEAC45TIC7
Content-Type: multipart/mixed; boundary="ipA5tluLAckGT5gHVvhlRwvWLBnQgkcOu";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <a50ec7d2-3a45-f247-26c9-9b45dafdbed7@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 4/5] buffer_list_aggregate_separator():
 prevent 0-byte malloc
References: <1498913642-32459-1-git-send-email-steffan.karger@...1435...>
 <1498913642-32459-4-git-send-email-steffan.karger@...1435...>
 <e063898a-6b6c-d716-824f-8e10b859d692@...2181...>
 <6c1bc6fc-4c09-2d9d-56fb-130c7aca2055@...1435...>
In-Reply-To: <6c1bc6fc-4c09-2d9d-56fb-130c7aca2055@...1435...>

--ipA5tluLAckGT5gHVvhlRwvWLBnQgkcOu
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 29/12/17 17:26, Steffan Karger wrote:
> Hi,
>=20
> On 28-12-17 23:51, Antonio Quartulli wrote:
>> On 01/07/17 20:54, Steffan Karger wrote:
>>> As pointed out in finding OVPN-05 of the cryptograpy engineering
>>> audit (funded by Private Internet Access),
>>> buffer_list_aggregate_separator() could perform a 0-byte malloc
>>> when called with a list of 0-length buffers and a "" separator.
>>> If other could would later try to access that buffer memory, this
>>> would result in undefined behaviour.  To prevent this, always=20
>>> malloc() 1 byte.
>>>
>>> To simplify as we go, use alloc_buf() to allocate the buffer.
>>> This has the additional benefit that the actual buffer data (not
>>> the contents) is zero-terminated, because alloc_buf() calls
>>> calloc() and we have 1 extra byte of data.
>>>
>>> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
>=20
>=20
>> Does it really make sense to continue the execution if we receive a
>> list of empty buffers? Shouldn't we report this as an error?
>=20
> Data is pushed to buffer lists from e.g. tls_send_payload(), where I'm
> not sure that 'sending' 0-byte payload is an invalid operation.  So
> instead of trying to figure out if that's possible, I prefer to just
> make this function deal with it.

Yeah, makes sense: better let the external layer deal with the logic.

>=20
> (Consider e.g. 0/n record splitting, which might want to 'send'
> 0-length data.)
>=20
> I'll send follow-up patches to take care of your other remarks.
>=20

Thanks!

Cheers,



--=20
Antonio Quartulli


--ipA5tluLAckGT5gHVvhlRwvWLBnQgkcOu--

--zt0jr6ZTJcV1TCuLanqcyQuaEAC45TIC7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlpGCo8ACgkQB6U8WA7y
zXSWfg/+NuknuJBkGiDMuE35Hk5/F0mYpzTn7sKo7/ADGxDVEzEyc49DwCmT/79x
0yhViUcz4/OtzEzJoTlr6A6eXLkdGiRyiiTpN7SLKC3a/sk42n4YwWN+F0x0Xe8B
A1EZT0YIGDcOMzljckXbiD4dFUGxzY0G+8AzQp5j+7I/Kpw6vUQ56wSn3wJGs6mx
SbdKATdxpQ5A0AMWadmFGNb0QoMAsNHkGcmxju4aitCSG8mwSsbik0EVyC9flxoR
fHc1r4AMOHKIgx/JHZ4RDakYdnZ2IMffi32BcacCuRSwE0k/93cgv4A0Vt00K5Jz
AUJ4jIOHGWEhDxAHOqnfsWZT6+EckYuudg2Ox+RBVJAgtZDwm/8cmvN+RGCRKxnu
+P9f4T/bXQshYVg4tnKwieWkwtQ+dpmLHBm/3syt9Z9c+hsXH/W6/MC+x1BiQgUV
lSUJT4gPioskvYcGj38Ypo3ATDhYVcb1dkTgjuFbnVcY6Vs+cZaZvvHaWhu9/fsx
hZdRbe9w80lS83i6VAwk54DejY7Rgl5CwRcuiFTx+0XvuEjRdzsIIDRJx23VwLzE
+9peaG81sLRo60LYC6h2CPIwcNidozXifc9dqDUDHgfeqR60FIC2If8crxDWRnXR
qKLOBk3vQ8UJEoOhBd4rjRhBRys1OQtYpqG9p4RenlYyssFRfjU=
=O6U5
-----END PGP SIGNATURE-----

--zt0jr6ZTJcV1TCuLanqcyQuaEAC45TIC7--

