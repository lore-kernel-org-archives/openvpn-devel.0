References: <20170816010105.21777-1-a@...2181...>
 <20170816121806.26471-1-a@...2181...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <11fa3a5e-5d71-c447-4939-0c6317ad5260@...1435...>
Date: Wed, 16 Aug 2017 14:51:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170816121806.26471-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v4] ntlm: avoid breaking anti-aliasing
 rules
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

On 16-08-17 14:18, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> The problem is visible when compiling with -O2:
>=20
> ntlm.c: In function =E2=80=98ntlm_phase_3=E2=80=99:
> ntlm.c:305:9: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules [-Wstrict-aliasing]
>          if ((*((long *)&buf2[0x14]) & 0x00800000) =3D=3D 0x00800000)
>=20
> The spec suggests to interpret those 4 bytes as a long, but
> this needs to be done carefully.
>=20
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
>=20
> v2: remove htonl/ntohl conversion as there is none in the original code
> v3: correct author's email
> v4: code used in v3 was not really alias-safe (thanks Steffan), fix it
>=20
>=20
>  src/openvpn/ntlm.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
> index 167c10b8..077fa3e2 100644
> --- a/src/openvpn/ntlm.c
> +++ b/src/openvpn/ntlm.c
> @@ -302,7 +302,21 @@ ntlm_phase_3(const struct http_proxy_info *p, const =
char *phase_2,
>          /* Add target information block to the blob */
>=20=20
>          /* Check for Target Information block */
> -        if ((*((long *)&buf2[0x14]) & 0x00800000) =3D=3D 0x00800000)
> +        /* The NTLM spec instructs to interpret these 4 consecutive byte=
s as a
> +         * 32bit long integer. However, no endianness is specified.
> +         * The code here and that found in other NTLM implementations po=
int
> +         * towards the assumption that the byte order on the wire has to
> +         * match the order on the sending and receiving hosts. Probably =
NTLM has
> +         * been thought to be always running on x86_64/i386 machine thus
> +         * implying Little-Endian everywhere.
> +         *
> +         * This said, in case of future changes, we should keep in mind =
that the
> +         * byte order on the wire for the NTLM header is LE.
> +         */
> +        const size_t hoff =3D 0x14;
> +        unsigned long flags =3D buf2[hoff] | (buf2[hoff + 1] << 8) |
> +                              (buf2[hoff + 2] << 16) | (buf2[hoff + 3] <=
< 24);
> +        if ((flags & 0x00800000) =3D=3D 0x00800000)
>          {
>              tib_len =3D buf2[0x28];            /* Get Target Information=
 block size */
>              if (tib_len > 96)
>=20

This fixes the strict aliasing, makes the LE assumption explicit, and
doesn't change the behaviour on LE machines.  Good enough for me, ACK.

-Steffan

