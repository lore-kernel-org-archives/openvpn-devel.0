MIME-Version: 1.0
In-Reply-To: <20120329075012.GK1359@...1296...>
References: <20120328171611.GH1359@...1296...>
	<1332960258-25371-1-git-send-email-alon.barlev@...277...>
	<20120329075012.GK1359@...1296...>
Date: Thu, 29 Mar 2012 11:12:42 +0200
Message-ID: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid using ~0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: Openvpn-devel@lists.sourceforge.net

On Thu, Mar 29, 2012 at 9:50 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Wed, Mar 28, 2012 at 08:44:18PM +0200, Alon Bar-Lev wrote:
>> To avoid casting use two constants:
>> 1. IPV4_NETMASK_HOST
>
> Fine with that one.
>
>> 2. dwMINUS_ONE
>
> I think this is way over board. =C2=A0It should be possible to spell "-1"=
 as
> such - and it doesn't increase readability to introduce a MINUS_ONE
> define here. =C2=A0If at all, introduce a "NO_IF_INDEX_FOUND" #define for
> the "find tap ifindex" logic - but please make it a separate patch.
>
> These are unrelated issues and must be reviewed independently (especially
> "different people understand the respective bits of the code and can give
> their ACK").
>
>> @@ -1530,7 +1530,7 @@ print_in6_addr_netbits_only( struct in6_addr netwo=
rk_copy, int netbits,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if ( bits_to_clear >=3D 8 )
>> =C2=A0 =C2=A0 =C2=A0 { network_copy.s6_addr[byte--] =3D 0; bits_to_clear=
 -=3D 8; }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>> - =C2=A0 =C2=A0 { network_copy.s6_addr[byte--] &=3D (~0 << bits_to_clear=
); bits_to_clear =3D 0; }
>> + =C2=A0 =C2=A0 { network_copy.s6_addr[byte--] &=3D (IPV4_NETMASK_HOST <=
< bits_to_clear); bits_to_clear =3D 0; }
>> =C2=A0 =C2=A0 =C2=A0}
>
> This particular one should NOT get "IPV4_NETMASK_HOST", as it isn't IPv4.
>
> "0xff" would be fine, or just leave it at "~0".
>
>> - =C2=A0 =C2=A0 unsigned int lowest_metric =3D ~0;
>> + =C2=A0 =C2=A0 unsigned int lowest_metric =3D (unsigned int)-1;
>
> This bit is not looking good. =C2=A0If "-1" is a valid value for "lowest_=
metric"
> (to signal "not set" etc) we shouldn't cast "-1" to (unsigned int) but
> use a signed int here.
>
> This should NOT be "just patched because we're it" but better understood
> and properly fixed.

OK.
Fair enough, although I want to focus on the major cleanups right now.
If we focus on the minor ones we get progress but much slower.

Alon.

