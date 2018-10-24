Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAKuzo_ji71-1Td7XO38MUB3YhdPDYrHcy21XBiSj8L1YZsa2NA@...278...>
 <1540306288-23847-1-git-send-email-lstipakov@...277...>
 <ec38d493-7b31-4f29-6877-bf0af7712e0c@...2181...>
 <CAKuzo_iyq0d-WbaXsVks7E9YL1=0_dN_JkBiyWKCs6fyUd9wOQ@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <6fb8c277-3819-e266-f125-7bf35d2b3f7a@...2080...>
Date: Wed, 24 Oct 2018 15:00:24 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iyq0d-WbaXsVks7E9YL1=0_dN_JkBiyWKCs6fyUd9wOQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ZkjF8hOeFaG8XF7ARCtYt9NEYK7s4Kj49"
Subject: Re: [Openvpn-devel] [PATCH] Wrap openvpn_swprintf into Windows
 define
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZkjF8hOeFaG8XF7ARCtYt9NEYK7s4Kj49
Content-Type: multipart/mixed; boundary="LnCc9a2bIMDVjeFDqPkNzcmgVwlrHV2BG";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <6fb8c277-3819-e266-f125-7bf35d2b3f7a@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Wrap openvpn_swprintf into Windows define
References: <CAKuzo_ji71-1Td7XO38MUB3YhdPDYrHcy21XBiSj8L1YZsa2NA@...278...>
 <1540306288-23847-1-git-send-email-lstipakov@...277...>
 <ec38d493-7b31-4f29-6877-bf0af7712e0c@...2181...>
 <CAKuzo_iyq0d-WbaXsVks7E9YL1=0_dN_JkBiyWKCs6fyUd9wOQ@...278...>
In-Reply-To: <CAKuzo_iyq0d-WbaXsVks7E9YL1=0_dN_JkBiyWKCs6fyUd9wOQ@...278...>

--LnCc9a2bIMDVjeFDqPkNzcmgVwlrHV2BG
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 24/10/18 14:39, Selva Nair wrote:
> On Wed, Oct 24, 2018 at 6:23 AM Antonio Quartulli <a@...2181...> wrote:
>>
>> Hi,
>>
>> On 23/10/18 22:51, Lev Stipakov wrote:
>>> From: Lev Stipakov <lev@...515...>
>>>
>>> Commit 43a5a4f3b4e411419639c195fee8a76495fdc88e added
>>> vswprintf() call which turned to me missing in OpenBSD 4.9.
>>>
>>> Since that call is inside openvpn_swprintf() function which
>>> is only used by Windows, wrap that function info #ifdef _WIN32.
>>>
>>> Signed-off-by: Lev Stipakov <lev@...515...>
>>
>> This patch introduces another ifdef, but it is enclosing a whole
>> function to prevent it from being compiled on non-windows platforms,
>> therefore I consider it "acceptable" for the time being.
>>
>> This patch fixes building openvpn on OpenBSD <=3D 4.9 (maybe this info
>> should be added to the commit message).
>=20
> Also there is a misplaced and mismatched comment added to
> buffer.c that says
>=20
> +        /* vswprintf is missing in OpenBSD 4.2 */
>          len =3D vswprintf(str, size, format, arglist);
>=20
> Makes little sense in that context and why 4.2..
> That one could be removed.
I'd say we should have such a reference in right below the #ifdef _WIN32 a =
few
lines higher up.  And it could be slightly more informative (and should
reference OpenBSD 4.9, which is the distro exploding without this patch.

Primary reason for this message is to explain why we do not provide this
function to "everyone", if someone has a use case for it later on in a
non-Windows code path.  If this is needed elsewhere, we at least know
instantly what might break and we can evaluate if it's worth keeping OpenBSD
4.9 support.

I suggest the comment below the #ifdef _WIN32 to be something like:

/*
 * openvpn_swprintf() is currently only used by Windows code paths
 * and when enabled for all platforms it will currently break
 * OpenBSD 4.9 which lacks vswprintf(3) support in its libc.
 */


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--LnCc9a2bIMDVjeFDqPkNzcmgVwlrHV2BG--

--ZkjF8hOeFaG8XF7ARCtYt9NEYK7s4Kj49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJb0GzpAAoJEIbPlEyWcf3yZI8P/1YqqC74XdEvJlsiEz+0Tt30
DJvhpPrtQgz1RVud91FTZJIJAsN0+A1hql7IFbEPMrYLMSbGobdTiBUKR3dnd5F2
YDSWE0p88j+D+bjiPbTcipEQvL+Z1brIpPBpGsBmQqJZ3nlci8TlcVjfd/MZdI5z
omz1koY2HbbLMCRFUS7+o7Dj3fvH1BzElZ8JL0jQll8Aywp8kKoAVVkCqhupjQP9
mDQrFTD3dIwM/nXduiVhxsF3hEICWC1HW58fntfcxnoL4rQo34DVwjEiCJoggD3j
j0AqDdFTUdEUVomuuM/BcHxLvMO4rNa+cJZO+hoz0qNd9jE2xuoJnZYRS4zEKcL2
nP5XNEc9MgHwgJqlRwAodWUvJx1NZgCyS7YbCgLd1YKngu6hRwMTMQJj36p915cU
Q1LLvS92NeVlrfhag/J9fNS0GrweSczdJkKOmVx6JMDMEaRjBYWi9zIwZJeBrMUg
NLMpZZWiPXl4cRBHGEe42iCOnBSGakBz3jGR5nhSbluWfDmsGr0MeFbRqNb+gUaL
fgwa6N8V5FaaWqaBT8kfCWBJr6x951Ym6S5d1krPteYrH80cWG8vZk1rQTsU9hvt
6m++lUCxrygXvCnrlL86HKxduLBuIxnDdigcKi4oLnR2dNYsmYWQWuCKmVNY1wgg
xrRMMat2Loi8VkA5ylw5
=KRzq
-----END PGP SIGNATURE-----

--ZkjF8hOeFaG8XF7ARCtYt9NEYK7s4Kj49--

