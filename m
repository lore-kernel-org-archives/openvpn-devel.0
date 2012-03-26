MIME-Version: 1.0
In-Reply-To: <20120326161943.GW1359@...1296...>
References: <20120326161943.GW1359@...1296...>
Date: Mon, 26 Mar 2012 19:58:02 +0200
Message-ID: <CAOazyz0Tbdn8+W9g1UmtLzGmbHbGNagRsN6KVZnVvqr_c2Hm6g@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] build failure on OpenBSD
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
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Mar 26, 2012 at 6:19 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> we currently fail on OpenBSD (4.9) with this error message:
>
> if gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../include =C2=A0-I../../src/=
compat =C2=A0 =C2=A0 =C2=A0-I/usr/include -I/usr/include =C2=A0 =C2=A0 -g -=
O2 -MT tun.o -MD -MP -MF ".deps/tun.Tpo" -c -o tun.o tun.c; =C2=A0then mv -=
f ".deps/tun.Tpo" ".deps/tun.Po"; else rm -f ".deps/tun.Tpo"; exit 1; fi
> tun.c: In function 'write_tun':
> tun.c:2070: error: dereferencing pointer to incomplete type
> *** Error code 1
>
> which looks like
>
> ------------------------------------------
> =C2=A0 =C2=A0 =C2=A0struct ip *iph;
>
> =C2=A0 =C2=A0 =C2=A0iph =3D (struct ip *) buf;
>
> =C2=A0 =C2=A0 =C2=A0if (tt->ipv6 && iph->ip_v =3D=3D 6) =C2=A0 <<< here
> ------------------------------------------
>
> "struct ip" is defined in <netinet/ip.h>, which "syshead.h" includes
> in weird ways - "syshead.h" has 5 different
>
> #ifdef HAVE_NETINET_IP_H
> #include <netinet/ip.h>
> #endif
>
> stanzas, always inside #ifdef TARGET_SOMETHING blocks. =C2=A0It does have=
 such
> a block for TARGET_OPENBSD, but configure doesn't find it:
>
> checking for net/if.h... yes
> checking for netinet/ip.h... no
> checking for netinet/if_ether.h... no
>
> The relevant section from config.log is here:
>
> ---------------------------- snip ---------------------------------
> configure:21681: checking for netinet/ip.h
> configure:21681: gcc -c -g -O2 =C2=A0conftest.c >&5
> In file included from conftest.c:170:
> /usr//include/netinet/ip.h:178: error: expected specifier-qualifier-list =
before
> 'n_time'
> configure:21681: $? =3D 1
> configure: failed program was:
> ---------------------------- snip ---------------------------------
>
> which is defined in <netinet/in_systm.h> - which syshead.h already includ=
es.
>
> the full config log can be found on
> =C2=A0http://public.greenie.net/gert/openvpn/config-obsd49-20120326.log
>
>
> I'd promise instead of trying to fix configure here, and since these
> are inside well-understood #ifdef TARGET_<foo> things already, just
> assume that "if it's *BSD, it will always have <netinet/ip.h>" and
> don't bother running fragile tests from configure.
>
> So that would turn syshead.h
>
> #ifdef TARGET_OPENBSD
>
> #ifdef HAVE_SYS_UIO_H
> #include <sys/uio.h>
> #endif
>
> #ifdef HAVE_NETINET_IN_SYSTM_H
> #include <netinet/in_systm.h>
> #endif
>
> #ifdef HAVE_NETINET_IP_H
> #include <netinet/ip.h>
> #endif
>
> #ifdef HAVE_NET_IF_TUN_H
> #include <net/if_tun.h>
> #endif
>
> #endif /* TARGET_OPENBSD */
>
>
> into
>
> #ifdef TARGET_OPENBSD
>
> #include <sys/uio.h>
> #include <netinet/in_systm.h>
> #include <netinet/ip.h>
> #include <net/if_tun.h>
>
> #endif /* TARGET_OPENBSD */
>
> ... which is to the point, and works.
>
> gert

Thanks!

The problem is the use of the TARGET_XXXX not the use of HAVE.
As I wrote before next stage is to get rid of the syshead.h and its complex=
ity.
There is no sense to check for platform, just if header exists.

In the mean time please try the following[1] patch.

Alon

[1] https://github.com/alonbl/openvpn/commit/b0f45ae19909b33723faebe7f8fb00=
3f82900ff4

