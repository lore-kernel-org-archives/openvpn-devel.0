References: <20181011184200.22175-1-a@...2181...>
 <20181011184200.22175-4-a@...2181...>
 <efb55a38-71f8-4044-d05d-dbac50de8a6c@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ae0a22e0-9ea4-07fd-2682-a5504b1686dd@...2181...>
Date: Tue, 27 Nov 2018 11:06:28 +1000
MIME-Version: 1.0
In-Reply-To: <efb55a38-71f8-4044-d05d-dbac50de8a6c@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kbQzLiUndJu6fwxjpJdw2e3ZfnYN10RZy"
Subject: Re: [Openvpn-devel] [PATCH v2 3/7] introduce sitnl: Simplified
 Interface To NetLink
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kbQzLiUndJu6fwxjpJdw2e3ZfnYN10RZy
Content-Type: multipart/mixed; boundary="zjzCgr5nLT9z5V0S6tAsvG38RJDYZaJMX";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <ae0a22e0-9ea4-07fd-2682-a5504b1686dd@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/7] introduce sitnl: Simplified
 Interface To NetLink
References: <20181011184200.22175-1-a@...2181...>
 <20181011184200.22175-4-a@...2181...>
 <efb55a38-71f8-4044-d05d-dbac50de8a6c@...1227...>
In-Reply-To: <efb55a38-71f8-4044-d05d-dbac50de8a6c@...1227...>

--zjzCgr5nLT9z5V0S6tAsvG38RJDYZaJMX
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 26/11/2018 23:14, Arne Schwabe wrote:
> Am 11.10.18 um 20:41 schrieb Antonio Quartulli:
>> This patch introduces a tiny netlink interface, optimized
>> for the openvpn use case.
>>
>> It basically exposes all those operations that are currently
>> handled by directly calling the /sbin/ip command (or even
>> ifconfig/route, if configured).
>>
>> By using netlink, openvpn won't need to spawn new processes
>> when configuring the tun interface or routes.
>> This new approach will also allow openvpn to be granted
>> CAP_NET_ADMIN and be able to properly work even though it
>> dropped the root privileges (currently handled via workarounds).
>>
>> By moving this logic into the sitnl module, tun.c and route.c
>> also benefit from some code simplification
>=20
> Just FYI for the rest. The current code still has a bug handling ipv6
> and I am waiting for V3 that does not have this bug.
>=20
> So this is not a full review
>=20
>> +typedef union {
>> +    in_addr_t ipv4;
>> +    struct in6_addr ipv6;
>> +} inet_address_t;
>> +
>=20
>=20
>=20
>> +/**
>> + * Link state request message
>> + */
>> +struct sitnl_link_req {
>> +    struct nlmsghdr n;
>=20
> I think one two sentences that netlink requires messages in a certain
> format but has no standard header that defines them so we need to define
> the message ourselves would be good here.

Ok, I can add some comments - doc is always good :)

>=20
>> +
>> +/*            if (((int)nladdr.nl_pid !=3D peer) || (h->nlmsg_pid !=3D =
nladdr.nl_pid)
>> +                || (h->nlmsg_seq !=3D seq))
>> +            {
>> +                rcv_len -=3D NLMSG_ALIGN(len);
>> +                h =3D (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
>> +                msg(M_DEBUG, "%s: skipping unrelated message. nl_pid:%d=
 (peer:%d) nl_msg_pid:%d nl_seq:%d seq:%d",
>> +                    __func__, (int)nladdr.nl_pid, peer, h->nlmsg_pid,
>> +                    h->nlmsg_seq, seq);
>> +                continue;
>> +            }
>> +*/
>=20
> The "normal" style for these debug commented out parts is using #ifdef
> instead of comments.

Right. I'll check if this is really useful - if not, I will just remove it.

>=20
>=20
>> +typedef struct {
>> +    int addr_size;
>> +    inet_address_t gw;
>> +    char iface[IFNAMSIZ];
>> +} route_res_t;
>> +
>=20
> This struct is in the middle of the file and I think it should either go
> along with the other struct definition in the top of the file or all
> structs should be defined before the function that they are used in first.
>=20

Right! Consistency is a good thing :) I'll move it to the top.

>=20
>> +/* used by iproute2 implementation too */
>=20
> I would not add that comment. Where a function is used can be inferred
> pretty easily and we don't have such comments elsewhere. And I fear this
> comment might be overlooked when iproute2 is remove in 2.6/2.7 and then
> more confusing than helpful.

Agreed. Will remove the comment.


Thanks!


Regards,

--=20
Antonio Quartulli


--zjzCgr5nLT9z5V0S6tAsvG38RJDYZaJMX--

--kbQzLiUndJu6fwxjpJdw2e3ZfnYN10RZy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlv8mJQACgkQ9FVsWUWD
Dm1Nhw/9EPWqrNXCKJGtn+4DWumL5EFNua7U47zPQ9IL8NgGN95FQpGW1lTVYwJz
5O0mRDBkiNv5bIkOqnx8uaACvNIzrmYHb5ad1Ly+zrEuWi97B2IpBZwWHST0SyEU
Z6t7Tz4q5PT8ZtK1sN8eYu1jez+KRz70iXoT6zT3ej+oVciqOhbSJJRML2Bdiz4x
x+HG/zd/yzGR4vZpbLddlm0BmicRhpOQryosg/PkUfsXzUTzOkiP2BdMCpPeTnEF
3ndQL7P8iytey+WGr0VT7rLsQT0tHMASU8edLbBsWvogk+FpZgyPTW2fpd/MYAz+
34GttB+NsUIHLJFAC2gqkNdRe/EWbx6yeo60jbiFl7xc7iJ0EbBI9W2+uh40J+nk
0u+eNFso2/3VdMqffYjlwbKINAHnppgwnDH7dc7HKNcCHSyIvm6IBuhX9C7pOpVT
UfZmdUyqbuX2l9GQSh2ToYQbBy1iJADBeG6iBqWmCXXi4n4XBhSb1wLJWOgAOABk
OyS/9OGTbg1H7R5MsUEXBdktOKEuiDjtwS0R/ArCMECIx4k+xnyS1xZB9CfK7bX1
6wolv6ghmhUdZccqTMYOfVc29tAE8cXRifz5ccWJOiiWAYUQ1uvO5UpPM3483ilD
xVoQ2c5G3MJ8qI4fPQYAQVUXIRov+StvNowkfCm0zzmpKWPmIvo=
=Dz19
-----END PGP SIGNATURE-----

--kbQzLiUndJu6fwxjpJdw2e3ZfnYN10RZy--

