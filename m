References: <1474208364-11251-1-git-send-email-chipitsine@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <2ea62e71-fe65-714b-2a2e-27bfa8f480eb@...2080...>
Date: Sun, 18 Sep 2016 18:14:09 +0300
MIME-Version: 1.0
In-Reply-To: <1474208364-11251-1-git-send-email-chipitsine@...277...>
Subject: Re: [Openvpn-devel] [PATCH] cppcheck finding: add "ASSERT(
 maxoutput > 0 || separator != NULL )" to prevent possible null pointer
 derefence
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Ilya Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/09/16 17:19, Ilya Shipitsin wrote:
> --- src/openvpn/buffer.c | 6 ++++-- 1 file changed, 4=20
> insertions(+), 2 deletions(-)
>=20
> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c index=20
> 52c6ab9..57bded9 100644 --- a/src/openvpn/buffer.c +++=20
> b/src/openvpn/buffer.c @@ -438,10 +438,12 @@ format_hex_ex (const=20
> uint8_t *data, int size, int maxoutput, unsigned int=20
> space_break_flags, const char* separator, struct gc_arena *gc) { -=20
> struct buffer out =3D alloc_buf_gc (maxoutput ? maxoutput : +  int i;
> +  struct buffer out; +  ASSERT( maxoutput > 0 || separator !=3D NULL
> ); +  out =3D alloc_buf_gc (maxoutput ? maxoutput : ((size * 2) +
> (size / (space_break_flags & FHE_SPACE_BREAK_MASK)) * (int) strlen
> (separator) + 2), gc); -  int i; for (i =3D 0; i < size; ++i) { if
> (separator && i && !(i % (space_break_flags &=20
> FHE_SPACE_BREAK_MASK)))
>=20

This looks dangerous and somewhat wrong.  This can actually stop a
server completely if the ASSERT() check fails.  I'm not sure we want
to do that.

The ASSERT() also expects maxoutput to be higher than 0, while the
alloc_buf_gc() supports/allows maxoutput to be 0, which again confirms
my bad feeling about this.  If maxoutput =3D=3D 0, alloc_buf_gc() will
actually allocate a reasonable buffer regardless.

I do see that there might be an issue if separator =3D=3D NULL
(strlen(NULL) will segfault), so this needs to be checked far more
carefully and compared against all the callers of format_hex_ex().

The question which pops up in my head is: Is this patch purely
targeted to silence a code analyser warning?  If so, this is most
likely not the right fix for the OpenVPN code base.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJX3q9BAAoJEIbPlEyWcf3yGkwQAKKZbI2idz6a7h5ZkbQJCHMk
JDNIpdR6XTFmG16jBrycYeew+9IRvfwpF4vh2/QPaRjDNLnKvPHP+9uEetqYmUQi
rWzJyg3nzXSEUhFRSbdJcOK7zEWoiUUsSTiBKIYP6D5qD+QBQOZaQseCCzafrt5b
IKrUesWMWPXAjQBYbUvcc801+JR5S/gSaSbk9TuO8Nemiry/GW/pSt0OVTggPdcm
LiUyutQ8HXeXS9uAL32FLqFH3qq7QTHjxdVoKGGx9w/lmznqp+EaKCuANsWnt/PW
ZTzVYM5YG5jI8XNM/wyCklu5n3yqJ37Noxd3ZRSD6ATTL/MExVgWINOOGA7f+Pj3
P6g4ZSc//zaWUCRpUKg4O8h6jaO+0stDS5eKDpyUCHYRHRdMI4IGLuwzIzKmxWq9
LpNGGY3Ikpf5IM+i2R04HctnNp+izEeW3vBCKnBBUHSyegRQGQ191Z5QC3SPk6VP
HwxkHCZiOsie8WsP0Sl2dur1GjV9uyslVTkmt1GBVuoOGxpmZLJRJRayO70goZ17
ToavpadDjt193g79j1/dpE7OCPcCitso/+egxVzDWPTtLj+7rS/gfdJBNdCHr7xK
Pf8KKbpD7yEbEln0K7wzsjVG749qZe103KmrhZulvu3H5+SrbT5ALhroaYidhRpg
lLcx4g4A+nZjM6kabBGy
=3DQvxV
-----END PGP SIGNATURE-----

