Reply-To: openvpn-devel@lists.sourceforge.net
References: <1520262951-1807-1-git-send-email-arne@...1227...>
 <1520265024-2129-1-git-send-email-arne@...1227...>
 <68b5e196-ee80-7975-4a29-161d71521ec4@...2080...>
 <CAKuzo_h8CnAZEm920WYw8_KUr76h1rzhj_c6FcxR=BYeQfj2wA@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <105ebedf-0cfd-b8db-d18a-35d67090f002@...2080...>
Date: Thu, 8 Mar 2018 00:52:35 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_h8CnAZEm920WYw8_KUr76h1rzhj_c6FcxR=BYeQfj2wA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0dbQsaYBFYVuDkUSx2cdnWkail0HJgeBp"
Subject: Re: [Openvpn-devel] [PATCH v2] Rework OpenVPN auth-token support
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
--0dbQsaYBFYVuDkUSx2cdnWkail0HJgeBp
Content-Type: multipart/mixed; boundary="vXMdlyvzEH1PxJZfsK3hsW5LkRpcNIgHo";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <105ebedf-0cfd-b8db-d18a-35d67090f002@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Rework OpenVPN auth-token support
References: <1520262951-1807-1-git-send-email-arne@...1227...>
 <1520265024-2129-1-git-send-email-arne@...1227...>
 <68b5e196-ee80-7975-4a29-161d71521ec4@...2080...>
 <CAKuzo_h8CnAZEm920WYw8_KUr76h1rzhj_c6FcxR=BYeQfj2wA@...278...>
In-Reply-To: <CAKuzo_h8CnAZEm920WYw8_KUr76h1rzhj_c6FcxR=BYeQfj2wA@...278...>

--vXMdlyvzEH1PxJZfsK3hsW5LkRpcNIgHo
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 08/03/18 00:22, Selva Nair wrote:
> Hi,
>=20
> ...some good stuff snipped...
>=20
>>
>> I'll admit I might see this with a bit too narrow perspective.  But how =
I have
>> understood this issue is that OpenVPN 2.x does not behave correctly as it
>> doesn't understand *why* the authentication failed.  If the client side =
would
>> understand why auth failed, then it can query the user for credentials a=
gain -
>> which I believe should resolve the current issues ... Or have I missed s=
omething?
>=20
> I hope we are slowly spiralling towards a solution; not going around
> in circles...
>=20
> Anyway, to reiterate: we currently have two issues. (i) client is not
> told when authentication fails during reneg
> and (ii) client doesn't know that auth-gen-token's token is not
> reusable across reconnects
> (SIGHUP and SIGUSR1).

Okay, (i) is handled with AUTH_FAILED,SESSION messages today in OpenVPN 3.
OpenVPN 2 should be taught to do the same - both server and client side.

In regards to (ii), that is an implementation detail which I would say is
incorrect with --auth-gen-token.  As I am the one who implemented that
feature, I would rather have this fixed so auth-gen-token works across rest=
arts.

Another new feature I can accept, is to enable rotating the auth-tokens.  T=
his
is currently not possible.  Not a need-to-have feature now, but more a
nice-to-have.

> Fixing (i) does not fix (ii). But (ii) easier to fix although we could
> keep arguing whether a forget-token-reconnect should be used or not
> etc..
> (i) is the trickier, though I'm not convinced it requires so much refacto=
ring.
>=20
> Anyway, if there is an immediate solution to (i) it may be better to
> fix (ii) along with it. Else just fixing (ii) along the lines Arne has
> proposed looks like the way to go.

Arne's approach with forget-token and IV_PROTO=3D3 diverges how OpenVPN 2 a=
nd
OpenVPN 3 behaves.  This is *not* an option for this issue.

The reason is that OpenVPN Access Server 2.5 is now shipping with an
unmodified (to my knowledge, at least) upstream OpenVPN 2.4.  This server
integrates well with the OpenVPN Connect clients, which we have for Android,
iOS, macOS and Windows (All OpenVPN 3 based).  It would be sad if the
community side fixes something which isn't really an issue (as part of the
solution is already there); we're just doing it wrong currently.  The curre=
nt
approach by Arne would also require support in OpenVPN 3 too; and I doubt t=
his
approach will get easily accepted there.

Also beware that more and more users will start deploying OpenVPN 3 based
clients too; it is already widespread on iOS.  And there are efforts on
getting OpenVPN Connect into even more appstores for different platforms.  =
On
top of that, in addition to the new open source openvpn3-linux client, there
will also be put some efforts to at least provide more mature reference
implementation clients for Windows and macOS too.  Plus Arne is also poking=
 at
using OpenVPN 3 in his Android client.  Many of them will definitely connect
against OpenVPN 2.x based servers; so OpenVPN 2 and OpenVPN 3 need to be we=
ll
aligned.

(With that said, I'm not saying OpenVPN 3 supports all OpenVPN 2 features 1=
00%
today, but the most important features are there - like authentication).


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--vXMdlyvzEH1PxJZfsK3hsW5LkRpcNIgHo--

--0dbQsaYBFYVuDkUSx2cdnWkail0HJgeBp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaoHtDAAoJEIbPlEyWcf3y6c0P/0SUksVOx1RsqXL0OX3d+Qa8
CPpB46OFRo8cfZggU+a92U5mEKcvjKzNP5cKCP5lagjybmtrBbu+1j6G5/aLJhxE
Qsr2LpQIT/rcQusrVg/UflnQlXqk1mmwqgLOduh0zGwnRTHsVWZ8h6j8T1kBifNF
W7Nlpnma6tQhh8/XjJGjbWnChtBIEom8+mxpAsOowNf6n/lbghqxVmVQCpQcw5XB
4cb/cymnnPoCwiJREXK7ENHnVvzdDPW33Ewmhf77vcn5nTIt+bKG6tX1TQthjAfj
0gC0uuYi/5RiLSSIHE9UJK2e86tHXL372qc56uxYbjz5DfnG92P4vpEBtRh1cAf4
uyFKNpU0m05iUtX74hCcCXhA7UFD6sLW2moOY8bdH6IxVcZ1Mk5ZvqPZhq640ao9
pfMYauo7BHO0rk91m/408ciUnZuBHUompryU6jV0Ojh0xR49o5wya2ZMo4qHyeXW
bECywotMzCeBRh6Nno7NHY1LhE1a06dDPG5WZemtsh6A8BYaL1LIzvVfZ/SLmX08
0QsDDgjCVQt8MlxYKKSsDLP5+ohRImGexswWmzimb3IpY4UP4aDg2CNxSvDX3AF1
P7MQdF3lBppY2dPOrjO1bciYsqQz7X/QSurg2tt2FxQaqT4vEj+nfXO98TSdjCak
zai3UcYKfmS/D9s8GnzS
=YO/y
-----END PGP SIGNATURE-----

--0dbQsaYBFYVuDkUSx2cdnWkail0HJgeBp--

