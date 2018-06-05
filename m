References: <20180605090421.9746-5-a@...2181...>
 <20180605093628.4985-1-a@...2181...> <20180605145139.GN57262@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <3909b854-7b38-a8f8-945d-f30bc60a0a6f@...2181...>
Date: Wed, 6 Jun 2018 00:11:40 +0800
MIME-Version: 1.0
In-Reply-To: <20180605145139.GN57262@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="83agifIbN5FnGqFrUD8BXnLH0lIIRSFHd"
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
--83agifIbN5FnGqFrUD8BXnLH0lIIRSFHd
Content-Type: multipart/mixed; boundary="dUqXp553EA6cFqyfwY1KWKqcPl7o6H1p3";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <antonio@...515...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3909b854-7b38-a8f8-945d-f30bc60a0a6f@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 4/5] pool: allow to configure an
 IPv6-only ifconfig-pool
References: <20180605090421.9746-5-a@...2181...>
 <20180605093628.4985-1-a@...2181...> <20180605145139.GN57262@...1296...>
In-Reply-To: <20180605145139.GN57262@...1296...>

--dUqXp553EA6cFqyfwY1KWKqcPl7o6H1p3
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/06/18 22:51, Gert Doering wrote:
> HI,
>=20
> On Tue, Jun 05, 2018 at 05:36:28PM +0800, Antonio Quartulli wrote:
>> From: Antonio Quartulli <antonio@...515...>
>>
>> With this change a server is allowed to allocate an
>> IPv6-only pool. This is required to make it capable
>> of managing an IPv6-only tunnel.
>=20
> Without having done much review here, just one initial caveat: did you=20
> test this with --ifconfig-pool-persist?  What happens?

It should just be ignored.
At the moment pool-persist works only for IPv4 and there is no support
for IPv6. This has not been changed by this patchset.

I added a check about it in ifconfig_pool_read():

521     /* IPv6 logic not implemented yet, therefore bail out if no IPv4
pool was
522      * configured
523      */
524     if (pool && !pool->ipv4.enabled)
525     {
526         return;
527     }


However, I will test to see it if works as expected.

Cheers,



--=20
Antonio Quartulli


--dUqXp553EA6cFqyfwY1KWKqcPl7o6H1p3--

--83agifIbN5FnGqFrUD8BXnLH0lIIRSFHd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsWtjwACgkQB6U8WA7y
zXT2CQ/+MHs18LFR9kA62/Fk6Ey5BFyN8SSToJitIK49gMk0aveRVJFlHQgM8kGW
M6i/3SVpMgHJauKSmVCsk/Ci6mIqTBGRoyaapZZN6nyHSud4SoCHvY00omveiht2
eEYF0IzLRuQLALP7TigFr557j/Yt3VaiqJZduKjjfB0enbxSFA4CHU4pEYMFergO
CfIILpjs1l/TVUC29mrW+5WcK5Wj21CPiDIx4LdyzT9QXx1407Fn4kRHwrlOcESJ
ebrxMJxkvn8yumrqZtNbQmwRZkenIw/rdC/j37iHtSZWaB0DFrwJ1DqpeJnwzXAq
DsFehhAuWmF95I59Qa8mwBCrNUoUBcJGUjsz6oT1eXSYvJ97dg7G4fy2rd/qygDl
FKQ7KQao1YTzaIO6yif7Y1v6ZsiYFErIjYTP11VMGION6jTukV8li4te9mucA2MZ
SoYqaNWgK5Afnf1oukLXNs7qeTCJjiTZu0XAN2vl06kxpFilJhZET7g68OX5/pno
T88etGGrTLPT6R2chW8AucTBKACNKyRvq+QhVihZStLW65mX8VuBlDNEBC14zJlK
3u5FG2k+7ScmWFrUGSDz+NzS8R+ifHCTtoTFEvVkJE8q6MNHkrtHY7fTf8AlhrgJ
9L0ucDPyQpyhjAFEyNKunGuqhNaBzhi2crCgFLDX7qnPCnBuLFk=
=Fb98
-----END PGP SIGNATURE-----

--83agifIbN5FnGqFrUD8BXnLH0lIIRSFHd--

