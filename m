From: Jeremie Courreges-Anglas <jca@...2272...>
References: <8737brk7vm.fsf@...2274...>
	<20170526165606.GQ97029@...1296...>
	<CADxRZqwYw0RLxCDB-u3NmrLUBONng5DyT-1e9q-37HDHPpnCrQ@...278...>
	<877f0jvmwi.fsf@...2274...>
	<20170610174642.GK97029@...1296...>
	<8760g3u3m2.fsf@...2274...>
	<20170610181126.GN97029@...1296...>
Date: Sat, 10 Jun 2017 20:28:23 +0200
In-Reply-To: <20170610181126.GN97029@...1296...> (Gert Doering's message
	of "Sat, 10 Jun 2017 20:11:26 +0200")
Message-ID: <87y3szsnnc.fsf@...2274...>
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
>
> (Wonder why it doesn't crash for Mator, as our buffer alignment in memory
> should be fairly consistent - it might depend on crypto and compression
> options, though)
>
>
>> > old:
>> >     if (iph->ip_v == 6)
>> >
>> > new:
>> >     if (OPENVPN_IPH_GET_VER(*buf) == 6)
>> >
>> > this is an existing macro which takes an int argument, shifting and
>> > masking the right bits, and since *buf is "uint8_t *buf", this should
>> > both be correct and alignment-ignorant.  
>> 
>> See my proposed patch, also in this thread.  
>
> "Copying around 20 bytes to ensure a single-byte access is really a
> single-byte access" is definitely *not* the right way here.  So NAK on
> that patch.
>
> It will stop the crashes, of course, but since no other parts of 
> struct ip are ever needed, it's just waste of CPU cycles.
>
>
>> I merely copy/pasted the NetBSD code.
>
> Uh?  Is this from the NetBSD ports tree?  Because our tun.c does not
> have a single memcpy() today... :-)
>
> Actually, my tun.c's TARGET_NETBSD version of write_tun() has something
> similar to what I suggested:
>
>         struct openvpn_iphdr *iph;
>
>         iph = (struct openvpn_iphdr *) buf;
>
>         if (OPENVPN_IPH_GET_VER(iph->version_len) == 6)
>
> ... slightly more speaking, and since "openvpn_iphdr" is a locally 
> defined structure with "uchar version_len" at the very beginning, this
> amounts to the same thing.

This is exactly the NetBSD code I was mentioning.  Here's the mail:

https://sourceforge.net/p/openvpn/mailman/message/35887533/

(weird, the mail content appears to be truncated on the web interface,
but at least you can get the patch in "Attachments").

>> > It might be less efficient than accessing the bit field - but then, it's 
>> > the same work to do, so hopefully the compiler is smart enough to compile 
>> > it to the same instructions.
>> 
>> master (32 bits access):
>> 0x0000000000081844 <write_tun_header+100>:      ld  [ %i1 ], %g1
>> 0x0000000000081848 <write_tun_header+104>:      sethi  %hi(0xf0000000), %g2
>> 0x000000000008184c <write_tun_header+108>:      sethi  %hi(0x60000000), %g3
>> 0x0000000000081850 <write_tun_header+112>:      and  %g1, %g2, %g1
>> 0x0000000000081854 <write_tun_header+116>:      cmp  %g1, %g3
>> 
>> patched:
>> 0x0000000000081844 <write_tun_header+100>:      ldub  [ %i1 ], %g1
>> 0x0000000000081848 <write_tun_header+104>:      srl  %g1, 4, %g1
>> 0x000000000008184c <write_tun_header+108>:      cmp  %g1, 6
>
> Sounds like an improvement, at least in code size :-)  (but I have no 
> idea how the performance of these operations compares)

Neither do I, I'm no sparcv9 hacker.

> ... and I can see that the "master" version is going to fail on
> unaligned packets...  so, needs fixing.

-- 
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAlk8OkcACgkQDfp0rhUk
5+7GMg//bez3zVI6Pui7cY4NYpgMj6pFG3CdCcoStjkSdtAZLpBwvXobwxpBYLJQ
AQMw8u+79HR79PPr5SUz5Jss/cyhJaYqYTzZ3GrzAdm4zB5eHg23B53IWPbKLgLn
hMn1Jy+DGwOtK+2UkR76mv9xUNZPpN4EqkeH4zaZn7kh0ICfsn2t3oLwYn1ssfP3
O5vjiLV7FAHVMGEElikPke16QiZhpx/7eotfkD53oNE6UiYtMlDBvl83ESZK21fH
CWFbmXkiR9DMSW6QQsf8vyLS8UAxT67nY6kb4caWvozoU3tDZZYk5Xk7r+NLR9WY
a3SX3ltsaoz6+kzX1++jQaga00vxFknNqMohaSG0F+nyBDhfVd9iM49rLygySXn1
AyMvMfkmeZom4ZksVotVWiIu0qHGw67KKV86RZRiYTyyY2ciLLkVISNm/qkK4gye
mT4JuwVqzE/GvKrw1fOz0DzroRz495v6ux4yCpb66WlAusxpJbsNwWhzErI6OkSs
cqI2vs7k5ie49itEJHOLAqrgMdy16jnvwtxlxvhgtYaNXclaw1TQCL2GTddcyQ0/
LI6bqliqhM1bp6/bUwth14mZFL05AXMmWl3md+4x02Y7AQZgQT2ToP69/NCUHOuO
4EPwAlAiviapGAeZXebyyUSzkdsTdxgLdyTiTjiA9IbFJKM6cDM=
=EFic
-----END PGP SIGNATURE-----
--=-=-=--

