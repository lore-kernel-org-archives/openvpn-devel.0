From: Jeremie Courreges-Anglas <jca@...2272...>
References: <8737brk7vm.fsf@...2274...>
	<20170526165606.GQ97029@...1296...>
	<CADxRZqwYw0RLxCDB-u3NmrLUBONng5DyT-1e9q-37HDHPpnCrQ@...278...>
	<877f0jvmwi.fsf@...2274...>
	<20170610174642.GK97029@...1296...>
Date: Sat, 10 Jun 2017 19:58:13 +0200
In-Reply-To: <20170610174642.GK97029@...1296...> (Gert Doering's message
	of "Sat, 10 Jun 2017 19:46:42 +0200")
Message-ID: <8760g3u3m2.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
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
Cc: Anatoly Pugachev <matorola@...277...>, openvpn-devel@lists.sourceforge.net, Stefan Sperling <stsp@...2273...>

--=-=-=
Content-Type: text/plain

Gert Doering <gert@...1296...> writes:

> Hi,
>
> On Sat, Jun 10, 2017 at 06:16:13PM +0200, Jeremie Courreges-Anglas wrote:
>> Loaded symbols for /usr/libexec/ld.so
>> #0  write_tun_header (tt=0x1ddd4e1900, buf=0x1d336921c5 "E", len=84) at tun.c:1661
>> 1661            if (iph->ip_v == 6)
>> (gdb)
>> 
>> buf points to an odd address.
>
> That's a single-byte access...?  Nothing to be aligned here.
>
> On FreeBSD, ip_v is defined as such:
>
>  * Structure of an internet header, naked of options.
>  */
> struct ip {
> #if BYTE_ORDER == LITTLE_ENDIAN
>         u_char  ip_hl:4,                /* header length */
>                 ip_v:4;                 /* version */
> #endif
> #if BYTE_ORDER == BIG_ENDIAN
>         u_char  ip_v:4,                 /* version */
>                 ip_hl:4;                /* header length */
> #endif
> ...
>
> ... so whatever it is, it's part of a single uchar at the very 
> beginning of that header...  strange.

OpenBSD:

struct ip {
#if _BYTE_ORDER == _LITTLE_ENDIAN
	u_int     ip_hl:4,		/* header length */
		  ip_v:4;		/* version */
#endif
#if _BYTE_ORDER == _BIG_ENDIAN
	u_int     ip_v:4,		/* version */
		  ip_hl:4;		/* header length */
#endif
...

u_char -> u_int.  Dunno if it matters to the compiler, I can take a look
later.

> OTOH, the compiler might assume 16bit-alignment here and use a 16bit-
> access to get the first word, then bit-shift (someone who understands
> sparc64 assembly around to check?) - in this case, the following 
> change should help:
>
>
> old:
>     if (iph->ip_v == 6)
>
> new:
>     if (OPENVPN_IPH_GET_VER(*buf) == 6)
>
> this is an existing macro which takes an int argument, shifting and
> masking the right bits, and since *buf is "uint8_t *buf", this should
> both be correct and alignment-ignorant.  

See my proposed patch, also in this thread.  I merely copy/pasted the
NetBSD code.

> It might be less efficient than accessing the bit field - but then, it's 
> the same work to do, so hopefully the compiler is smart enough to compile 
> it to the same instructions.

master (32 bits access):
0x0000000000081844 <write_tun_header+100>:      ld  [ %i1 ], %g1
0x0000000000081848 <write_tun_header+104>:      sethi  %hi(0xf0000000), %g2
0x000000000008184c <write_tun_header+108>:      sethi  %hi(0x60000000), %g3
0x0000000000081850 <write_tun_header+112>:      and  %g1, %g2, %g1
0x0000000000081854 <write_tun_header+116>:      cmp  %g1, %g3

patched:
0x0000000000081844 <write_tun_header+100>:      ldub  [ %i1 ], %g1
0x0000000000081848 <write_tun_header+104>:      srl  %g1, 4, %g1
0x000000000008184c <write_tun_header+108>:      cmp  %g1, 6

-- 
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAlk8MzUACgkQDfp0rhUk
5+6RoQ/+J/XY2Qg8yesnQI89XpeZ7I1WDkE91hqh2TPryr44Mxk5a0zvkPyGkvhi
L5ZfLfdZiuZEZt1GqMdjB32zxw157tYwjRjVRhJys+kBitsJB64dWMlLECNtOSt4
ou3Y1pzj5TMyhdE9bUv5syk1+h9acsnM8iG6WaYLavuABk+RZusfFcEo5acuI7vq
eSDJOuvH+4cCgavZzUwIy4Rvq1U3PdFEz6ZM20+zU6ns5J1V1YdqhBt7ZliKXuKb
cuB502Bn+YJmYFLHcN46rkQBgWSNEiqRAyEEbzapOqNq8P8/zCpIOzaWMR5iuc0r
aIvvlmtReaRiWi98C3cPdwhKWous1ymmqhPLv1q9wuxRrvrbHVua9/naTSnXP/37
AKlodpwOTfmndMhFsELvtFNWZeccyaGuVELsVeQpyfxFh603QAclhnfKcLwHiyVs
vUq9/u14zZNglSlSVMO8QgZRhEb4wsYG8Tn+2OOAQVdigUvO7StWLqXVbqWGUYtK
Hx29QGhNXfGpj7zGfAKzqQC8DlPJXUdKpG2ZbKX21EL5iAvatkDDmXYgeqarY9Kr
G23FoHx2o59MEtom1DVrEbQIwil2sao4joTcnqg19XVQkmK1WQbczkfNAiUGk0iN
T1WaoJ4qEpoBecjSnDnlcdR3HntjckeSYAq0VmuiwBt+aeoHhpk=
=o+ML
-----END PGP SIGNATURE-----
--=-=-=--

