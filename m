From: Jeremie Courreges-Anglas <jca@...2272...>
References: <8737brk7vm.fsf@...2274...>
	<20170526165606.GQ97029@...1296...>
Date: Sat, 10 Jun 2017 17:23:15 +0200
In-Reply-To: <20170526165606.GQ97029@...1296...> (Gert Doering's message
	of "Fri, 26 May 2017 18:56:06 +0200")
Message-ID: <87ink3vpcs.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] Alignement crash on sparc64
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, Stefan Sperling <stsp@...2273...>

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain

Gert Doering <gert@...1296...> writes:

> Hi,
>
> On Fri, May 26, 2017 at 04:30:53PM +0200, Jeremie Courreges-Anglas wrote:
>> I am the maintainer of openvpn in the OpenBSD ports tree.  Here's
>> a report from Stefan Sperling (Cc'ed).
>> 
>> > An openvpn server running on OpenBSD/sparc64 6.1 crashes when a client
>> > connects and starts doing traffic. Is anyone else seeing this?
>
> Thanks for the report.  I'll look into it.
>
> Copying around the IP header doesn't feel like the proper solution, 
> though - it's basically replacing an unaligned access somewhere with
> a larger (unaligned!) mem copy, where most likely changing a word
> access to 2x byte access (etc) might achieve the same thing without
> copying.

Agreed, there's probably a better way to handle this.  The best
workaround I can think of would be using openvpn_iphdr /
OPENVPN_IPH_GET_VER, like the NetBSD code does.  It accesses only the
first byte of the buffer and thus shouldn't be affected by alignement
constraints.

This patch has been successfully tested (v4 and v6 traffic) by Stefan
Sperling on OpenBSD/sparc64, on top of the openvpn-2.4.2 release.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
 filename=0001-Fix-an-unaligned-access-on-OpenBSD-sparc64.patch
Content-Transfer-Encoding: quoted-printable

From=203f5cf7fa574c3bb7495bfb43d09e96c368702445 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?J=3DC3=3DA9r=3DC3=3DA9mie=3D20Courr=3DC3=3DA8ges-Anglas?=
=3D <jca@...2272...>
Date: Sat, 10 Jun 2017 16:48:44 +0200
Subject: [PATCH] Fix an unaligned access on OpenBSD/sparc64

The pointer to the packet content doesn't seem to be word-aligned,
resulting in a SIGBUS when accessing it as a pointer to struct ip that
contains bit fields.

Replace with struct openvpn_iphdr and OPENVPN_IPH_GET_VER, which only
does a one byte access and thus isn't affected by alignement.
=2D--
 src/openvpn/tun.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3504fbf4..0ca0c19e 100644
=2D-- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1654,11 +1654,11 @@ write_tun_header(struct tuntap *tt, uint8_t *buf, i=
nt len)
     {
         u_int32_t type;
         struct iovec iv[2];
=2D        struct ip *iph;
+        struct openvpn_iphdr *iph;
=20
=2D        iph =3D (struct ip *) buf;
+        iph =3D (struct openvpn_iphdr *) buf;
=20
=2D        if (iph->ip_v =3D=3D 6)
+        if (OPENVPN_IPH_GET_VER(iph->version_len) =3D=3D 6)
         {
             type =3D htonl(AF_INET6);
         }
=2D-=20
2.13.0


--=-=-=
Content-Type: text/plain


>> To work around this, the patch below (also written by Stefan) was
>> committed in our ports tree.  TARGET_FREEBSD and TARGET_DRAGONFLY seem
>> to be affected too.
>
> FreeBSD/Sparc64 traps unaligned memory accesses and handles them 
> kernel-side.  So you'll see a slowdown, but no signal.

Sounds bad.  The proposed patch affects only OpenBSD and Mac OSX
(untested there, but looks safe); but FreeBSD and DragonflyBSD would
probably benefit from the same change.

> Linux/Sparc64 has the same restrictions (unaligned access causing a
> signal), but nobody has reported that yet, so maybe the underlying
> memory alignment of the allocated buffer happens to be good enough 
> there.

I don't know much about the memory allocator used in openvpn, but I'd
expect it to provide at least word-aligned pointers.

The code we're discussing is specific to BSD systems, another possible
reason why Linux looks unaffected.

-- 
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAlk8DuMACgkQDfp0rhUk
5+5nbA//YqwYHNE/PviRnZRHM7IWJ5c9177pc8hMWHQ4xKNKz3Qu9CwW8/ketfyI
F18DbMEfJ1MWDkXCto+irqmKr7drHJkXikkHR/0smibY1OLMHnHnqIdPgxCkZHCp
6mye/jCkeWhPsxyl0vmlOPoG4Y1aPR49lCK0QZhLTNxuCM0Tk0E3lBSX7KEyJQl2
KpFuV+om8ygroz0QCqsL8rK34Rwt6RF79BvILHz/q88ROvYv+/I433+13JJzWa4A
LDEzdgl/zNmAmPbpJfta0RdIXq9Fowwr9mWSrset7FttRe3VyGgyTCLb+dsaOeBM
UDesZ4RmjlbUxDjtECg41Ro0GYGUOFyf4P7QRHo3Sn+U1jaEoWuN5Y1tfegLh2pD
+QdzdGA5e16JRPNvHFUqSnHyrHy7jlO8r/BSEInwMGnxyzNOif3PqF+58ilZFLOw
0BQkdvNWMi3QBDgjSmh3EaKudmlEyEHbeZth0m8FnIH9MhSAqG27nc7wTogsUL8t
adQs23Jc+giLfxA197E4mS9vxpfblQIWP4B0C2j30QSRv/eDQ6HUI5sAQEDSSPFl
Q1ERaf9YIjALB6XGrrcRW6Vnf2ojrR4FZwA4EnQl0iVnieB3CJBDbLGTgNSRaHJb
SrGYEwREVsGXlii9jRdQ7+hkCIKJ97QuDktWRbqgZsRDCrPvK6Y=
=f1e7
-----END PGP SIGNATURE-----
--==-=-=--

