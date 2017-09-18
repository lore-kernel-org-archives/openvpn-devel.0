References: <20170828085620.23186-1-a@...2181...>
 <20170828085620.23186-2-a@...2181...>
 <20170918083116.w67qmug4imxyjmns@...2161...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <45d3c70d-6847-f22d-4173-297ecb2338a2@...2181...>
Date: Mon, 18 Sep 2017 18:42:12 +0800
MIME-Version: 1.0
In-Reply-To: <20170918083116.w67qmug4imxyjmns@...2161...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MvtX0Bee9EReuab2vxSfoLIufBx1Jwb9w"
Subject: Re: [Openvpn-devel] [PATCHv3 2/2] ensure function declarations are
 compiled with their definitions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Ruderich <simon@...2161...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MvtX0Bee9EReuab2vxSfoLIufBx1Jwb9w
Content-Type: multipart/mixed; boundary="B48BTcoKkXQcFL1p6OW6TRgLLL23r5hWW";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Simon Ruderich <simon@...2161...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <45d3c70d-6847-f22d-4173-297ecb2338a2@...2181...>
Subject: Re: [Openvpn-devel] [PATCHv3 2/2] ensure function declarations are
 compiled with their definitions
References: <20170828085620.23186-1-a@...2181...>
 <20170828085620.23186-2-a@...2181...>
 <20170918083116.w67qmug4imxyjmns@...2161...>
In-Reply-To: <20170918083116.w67qmug4imxyjmns@...2161...>

--B48BTcoKkXQcFL1p6OW6TRgLLL23r5hWW
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for noticing this. I think something went wrong during my last
rebase. After working on this branch this morning I also got complaints
from travis-ci, but I hadn't noticed that before.

will fix and resend both patches.

Cheers,

On 18/09/17 16:31, Simon Ruderich wrote:
> Hello,
>=20
> The patch contains conflict markers.
>=20
> On Mon, Aug 28, 2017 at 04:56:20PM +0800, Antonio Quartulli wrote:
>> [snip]
>>
>> diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
>> index 369ebac4..f81e68d7 100644
>> --- a/src/openvpn/occ.h
>> +++ b/src/openvpn/occ.h
>> @@ -90,6 +90,19 @@ is_occ_msg(const struct buffer *buf)
>>
>>  void process_received_occ_msg(struct context *c);
>>
>> +<<<<<<< HEAD
>> +=3D=3D=3D=3D=3D=3D=3D
>> +void check_send_occ_req_dowork(struct context *c);
>> +
>> +void check_send_occ_load_test_dowork(struct context *c);
>> +
>> +void check_send_occ_msg_dowork(struct context *c);
>> +
>> +/*
>> + * Inline functions
>> + */
>> +
>> +>>>>>>> 5222207d... ensure function declarations are compiled with thei=
r definitions
>=20
> Here.
>=20
>> [snip]
>>
>> diff --git a/src/openvpn/pf.h b/src/openvpn/pf.h
>> index 480d5b7b..e588f0e0 100644
>> --- a/src/openvpn/pf.h
>> +++ b/src/openvpn/pf.h
>> @@ -104,6 +104,21 @@ void pf_context_print(const struct pf_context *pfc,=
 const char *prefix, const in
>>
>>  #endif
>>
>> +<<<<<<< HEAD
>> +=3D=3D=3D=3D=3D=3D=3D
>> +bool pf_cn_test(struct pf_set *pfs, const struct tls_multi *tm, const i=
nt type,
>> +                const char *prefix);
>> +
>> +bool pf_addr_test_dowork(const struct context *src,
>> +                         const struct mroute_addr *dest, const char *pr=
efix);
>> +
>> +/*
>> + * Inline functions
>> + */
>> +
>> +#define PCT_SRC  1
>> +#define PCT_DEST 2
>> +>>>>>>> 5222207d... ensure function declarations are compiled with thei=
r definitions
>=20
> And here.
>=20
> Regards
> Simon
>=20

--=20
Antonio Quartulli


--B48BTcoKkXQcFL1p6OW6TRgLLL23r5hWW--

--MvtX0Bee9EReuab2vxSfoLIufBx1Jwb9w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlm/owQACgkQ0+HICM1s
oFBrDg/+LF8m5oTGC2FglKUGmbeNONLG7eYk19OHrm06Q/J6oPeAHDQUv8OofOdM
4INax+B/oae3XJFZlDuVjVa/k2h7iYfxS8L68UK9HP8ztKSfjzrNuJXEAJI9frCQ
P40HL0furGC5/4qW7lbotVliz/AwNhCBuqri0GXsAFCUqpYy/BtvKv42GG5aNSUd
KNvH4+JZ/kjUtl7DrXtOY1auf3ms7yPBAaFZkw2QP/990ST7kC3xhU7HtBOJXrRg
/kAmx1AHu6PsCtJJ2FfFYmzvAwAwCxRiQENXdOfuj0OjJa4exvWj6QFegaif5UiD
zInxLD29TBXbn1+PUz+XQUVLja/6V/5y7BxkTvfG1n04iCanIaftqFk7To3BnHhp
x6DE4E9IY2fn+90LrfCcZaqUBGmHZi0ps9SuIK5WGFbbh4KB+P77LOD36y+unVi+
2jP9OqHyDN6dC2huPeQhV1UUvpX/eHNiZNU+G5b0Djd6Zk2JI2JwRb/qnLUfpwV/
bYKnkJa1yTpm04lKDfOo6jVyVlfxzX3nPsj1+YKOrpEeJt0yVSb/Ds0gMzs4lhy7
FmNu7SL9k7b8sT+mFcWRyyFghb3m6Zv2h3elHCHCOLB9A4EUvQVyAfRLWSy6GKIC
7R/S++T9BNn2RnLUV9VZWAtSUWrE4EgjfDyRnsyvg790JN+hFAQ=
=Ryov
-----END PGP SIGNATURE-----

--MvtX0Bee9EReuab2vxSfoLIufBx1Jwb9w--

