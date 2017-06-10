From: Jeremie Courreges-Anglas <jca@...2272...>
References: <8737brk7vm.fsf@...2274...>
	<20170526165606.GQ97029@...1296...>
	<CADxRZqwYw0RLxCDB-u3NmrLUBONng5DyT-1e9q-37HDHPpnCrQ@...278...>
	<877f0jvmwi.fsf@...2274...>
	<20170610174642.GK97029@...1296...>
	<8760g3u3m2.fsf@...2274...>
	<20170610181126.GN97029@...1296...>
Date: Sat, 10 Jun 2017 21:10:13 +0200
Message-ID: <87ink3slpm.fsf@...2274...>
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
Cc: openvpn-devel@lists.sourceforge.net

--=-=-=
Content-Type: text/plain

Gert Doering <gert@...1296...> writes:

> Hi,
>
> On Sat, Jun 10, 2017 at 07:58:13PM +0200, Jeremie Courreges-Anglas wrote:
>> OpenBSD:
>> 
>> struct ip {
>> #if _BYTE_ORDER == _LITTLE_ENDIAN
>> 	u_int     ip_hl:4,		/* header length */
>> 		  ip_v:4;		/* version */
>> #endif
>> #if _BYTE_ORDER == _BIG_ENDIAN
>> 	u_int     ip_v:4,		/* version */
>> 		  ip_hl:4;		/* header length */
>> #endif
>> ...
>> 
>> u_char -> u_int.  Dunno if it matters to the compiler, I can take a look
>> later.
>
> I'm fairly sure it does matter.  An int is likely to be at least 16 bit, 
> maybe 32 bit, so the compiler can assume "word aligned" - and *boom*.

It doesn't seem to matter that much.  Which aligns well with the
"bit fields are nasty" experience people seem to have.  From a quick
glance at the c99 standard, I couldn't find language about this.

  "A bit-field shall have a type that is a qualified or unqualified version
  of _Bool, signed int, unsigned int, or some other implementation-defined
  type."


Here's a snippet:

--8<--
#include <sys/types.h>

#include <netinet/in.h>

#include <endian.h>
#include <stdlib.h>

struct ip {
#if _BYTE_ORDER == _LITTLE_ENDIAN
        u_int     ip_hl:4,              /* header length */
                  ip_v:4;               /* version */
#endif
#if _BYTE_ORDER == _BIG_ENDIAN
        u_int     ip_v:4,               /* version */
                  ip_hl:4;              /* header length */
#endif
        u_int8_t  ip_tos;               /* type of service */
        u_int16_t ip_len;               /* total length */
        u_int16_t ip_id;                /* identification */
        u_int16_t ip_off;               /* fragment offset field */
#define IP_RF 0x8000                    /* reserved fragment flag */
#define IP_DF 0x4000                    /* dont fragment flag */
#define IP_MF 0x2000                    /* more fragments flag */

#define IP_MF 0x2000                    /* more fragments flag */
#define IP_OFFMASK 0x1fff               /* mask for fragmenting bits */
        u_int8_t  ip_ttl;               /* time to live */
        u_int8_t  ip_p;                 /* protocol */
        u_int16_t ip_sum;               /* checksum */
        struct    in_addr ip_src, ip_dst; /* source and dest address */
};

struct ip_freebsd {
#if _BYTE_ORDER == _LITTLE_ENDIAN
        u_char     ip_hl:4,             /* header length */
                  ip_v:4;               /* version */
#endif
#if _BYTE_ORDER == _BIG_ENDIAN
        u_char     ip_v:4,              /* version */
                  ip_hl:4;              /* header length */
#endif
        u_int8_t  ip_tos;               /* type of service */
        u_int16_t ip_len;               /* total length */
        u_int16_t ip_id;                /* identification */
        u_int16_t ip_off;               /* fragment offset field */
#define IP_RF 0x8000                    /* reserved fragment flag */
#define IP_DF 0x4000                    /* dont fragment flag */
#define IP_MF 0x2000                    /* more fragments flag */
#define IP_OFFMASK 0x1fff               /* mask for fragmenting bits */
        u_int8_t  ip_ttl;               /* time to live */
        u_int8_t  ip_p;                 /* protocol */
        u_int16_t ip_sum;               /* checksum */
        struct    in_addr ip_src, ip_dst; /* source and dest address */
};


void
f(void *p)
{
        struct ip *iph;

        iph = (struct ip *)p;

        if (iph->ip_v == 6)
                abort();
}

void
g(void *p)
{
        struct ip_freebsd *iph;

        iph = (struct ip_freebsd *)p;

        if (iph->ip_v == 6)
                abort();
}

--8<--

gcc-4.2.1 (system compiler on OpenBSD)

(gdb) disas f
Dump of assembler code for function f:
0x0000000000000040 <f+0>:       save  %sp, -208, %sp
0x0000000000000044 <f+4>:       ld  [ %i0 ], %g1
0x0000000000000048 <f+8>:       sethi  %hi(0xf0000000), %g2
0x000000000000004c <f+12>:      sethi  %hi(0x60000000), %g3
0x0000000000000050 <f+16>:      and  %g1, %g2, %g1
0x0000000000000054 <f+20>:      cmp  %g1, %g3
0x0000000000000058 <f+24>:      be,pn   %icc, 0x68 <f+40>
0x000000000000005c <f+28>:      nop
0x0000000000000060 <f+32>:      rett  %i7 + 8
0x0000000000000064 <f+36>:      nop
0x0000000000000068 <f+40>:      call  0x68 <f+40>
0x000000000000006c <f+44>:      nop
0x0000000000000070 <f+48>:      nop
End of assembler dump.
(gdb) disas g
Dump of assembler code for function g:
0x0000000000000000 <g+0>:       save  %sp, -208, %sp
0x0000000000000004 <g+4>:       ld  [ %i0 ], %g1
0x0000000000000008 <g+8>:       sethi  %hi(0xf0000000), %g2
0x000000000000000c <g+12>:      sethi  %hi(0x60000000), %g3
0x0000000000000010 <g+16>:      and  %g1, %g2, %g1
0x0000000000000014 <g+20>:      cmp  %g1, %g3
0x0000000000000018 <g+24>:      be,pn   %icc, 0x28 <g+40>
0x000000000000001c <g+28>:      nop
0x0000000000000020 <g+32>:      rett  %i7 + 8
0x0000000000000024 <g+36>:      nop
0x0000000000000028 <g+40>:      call  0x28 <g+40>
0x000000000000002c <g+44>:      nop
0x0000000000000030 <g+48>:      nop
End of assembler dump.

gcc 4.9.4:

(gdb) disas f
Dump of assembler code for function f:
0x0000000000000000 <f+0>:       save  %sp, -176, %sp
0x0000000000000004 <f+4>:       ld  [ %i0 ], %g2
0x0000000000000008 <f+8>:       sethi  %hi(0xf0000000), %g1
0x000000000000000c <f+12>:      and  %g2, %g1, %g1
0x0000000000000010 <f+16>:      sethi  %hi(0x60000000), %g2
0x0000000000000014 <f+20>:      cmp  %g1, %g2
0x0000000000000018 <f+24>:      be,pn   %icc, 0x28 <f+40>
0x000000000000001c <f+28>:      nop
0x0000000000000020 <f+32>:      rett  %i7 + 8
0x0000000000000024 <f+36>:      nop
0x0000000000000028 <f+40>:      call  0x28 <f+40>
0x000000000000002c <f+44>:      nop
0x0000000000000030 <f+48>:      nop
End of assembler dump.
(gdb) disas g
Dump of assembler code for function g:
0x0000000000000040 <g+0>:       save  %sp, -176, %sp
0x0000000000000044 <g+4>:       ld  [ %i0 ], %g2
0x0000000000000048 <g+8>:       sethi  %hi(0xf0000000), %g1
0x000000000000004c <g+12>:      and  %g2, %g1, %g1
0x0000000000000050 <g+16>:      sethi  %hi(0x60000000), %g2
0x0000000000000054 <g+20>:      cmp  %g1, %g2
0x0000000000000058 <g+24>:      be,pn   %icc, 0x68 <g+40>
0x000000000000005c <g+28>:      nop
0x0000000000000060 <g+32>:      rett  %i7 + 8
0x0000000000000064 <g+36>:      nop
0x0000000000000068 <g+40>:      call  0x68 <g+40>
0x000000000000006c <g+44>:      nop
0x0000000000000070 <g+48>:      nop
End of assembler dump.

So, no difference in the generated code between the OpenBSD and FreeBSD
structures.

-- 
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAlk8RBUACgkQDfp0rhUk
5+7UaA/7BVBk1lrfsS6vL15wmgu6bfHM+P+LswLmrge7Q7IR+EQH5niw6DEtafpG
Yx0bMKzXbSYwTxJC/6juxqlyAdOWcZ90dKaC3x9P8djXCWFKryZNk6YFdUHtSc5x
hIJ0kFIZP4JiXBpgiaskONjnD7xCc9y8AT+nxwWOyFfmKhHh9ZHmlC9SxBHgy0sy
RXNi5uFKvTtqy3BgPM++vgHuygHTkBsVHENRtrJpSWONToEkHZphVPp/Dw3khFQb
JP/asjrm69kcWkm950TA/JdAv91fnNORleC/+12R5G5TLqIxMF97BBcnbXeJ5OW8
LWtsvxi5QhHcfwOYFQgP4Yosfq40oPEPj7ck6a3HDHrn78WqYJpliOtoDwyIKVWc
cWNo4OuYsKrWMR7/fqrx0UQ1UiK3VXcxRaWA2im9edLx+1pJd2pwW383NvzmihVg
L3WYF7jLxxwfxnlQ2DmmfMbET3a0dETk5H4oiVl8zyIaFGmuMImV7F7v1amfC3Ge
ZkBrS8NlNi6r132wVhkp3FbDz/gWA7gbqU7ftDd0TTo4GOqIv3fQjC3Q/g3TC28Z
Vn+xhc9yXGbhorshNLwZpedCHMhdx5ymwoOjtjPR+hOepyl98CVeXoW8Ujrfduga
TvrikttFQAfZk+FhD3cG0k0RjcIeUMX2v40xMKhYqMPWzh5zcFE=
=bKmp
-----END PGP SIGNATURE-----
--=-=-=--

