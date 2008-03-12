Message-ID: <9e0cf0bf0803120802x53ed773ev38f25064069909e9@...278...>
Date: Wed, 12 Mar 2008 17:02:16 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <47D7CBC2.6020606@...1068...>
MIME-Version: 1.0
References: <478C94C4.1050409@...1068...>
	<9e0cf0bf0801150345i749f5ca6na1f8343b6da390fc@...278...>
	<9e0cf0bf0801150345p4639a831ub8f85fd56bda48db@...278...>
	<478CAD6A.3010808@...1068...>
	<9e0cf0bf0801150522x72621b20pc36373986f2ad8a1@...278...>
	<47D7CBC2.6020606@...1068...>
Subject: Re: [Openvpn-devel] NTLMv2 patch corrected
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Mirek Zajic <zajic@...1068...>
Cc: openvpn-devel@lists.sourceforge.net

On 3/12/08, Mirek Zajic <zajic@...1068...> wrote:
> Hello,
>  I have finally made some changes to the NTLMv2 patch according to Alon's
>  comments. Now it should also be architecture independent.
>
>  Miroslav Zajic
>  NextSoft s.r.o.

Hi!
Great!
Some more comments... :)

>  +    timestamp_ull = openvpn_time(NULL);
>  +    timestamp_ull = (timestamp_ull + UINT64(11644473600)) *
>  UINT64(10000000);

Just noticed that openvpn has: openvpn_gettimeofday() which works also
for WIN32... Maybe use this one?

>  +    msg_buf[sb_offset + 5] = (unsigned char)((*msg_bufpos & 0xff00) >> 8);

always & such with 0xff.

> diff -Naur openvpn-2.1/ntlm.h openvpn-NTLMv2-predelane-2.1/ntlm.h
>  --- openvpn-2.1/ntlm.h    2008-01-13 21:25:52.935292800 +0100
>  +++ openvpn-NTLMv2-predelane-2.1/ntlm.h    2008-03-12 11:35:36.296875000
>  +0100
>  @@ -3,6 +3,18 @@
>
>   #if NTLM
>
>  +/* 64bit datatype macros */
>  +#ifdef _MSC_VER
>  +    /* MS compilers */
>  +#define UINTEGER64 __int64
>  +#define UINT64(c) c ## Ui64
>  +#else
>  +    /* Non MS compilers */
>  +#define UINTEGER64 unsigned long long
>  +#define UINT64(c) c ## LL
>  +#endif
>  +
>

Why not use long long for both platforms, it is already used in common.h...
Also you can use ull suffix for both platforms.

Anyway... this belongs to the .c file, it is not used by any other files.
But I don't think it is required at all.

Alon.

