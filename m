MIME-Version: 1.0
In-Reply-To: <20141122115728.GB17158@...1296...>
References: <1416598835-5269-1-git-send-email-yegorslists@...1030...>
	<CAGm1_kucw-c5wgw3e_BjRros=CyaEUQ-=o2aLSvDr=31oFuKCg@...278...>
	<54705AA4.2010105@...1856...> <20141122102138.GA17158@...1296...>
	<547069A9.8020306@...1227...> <20141122115728.GB17158@...1296...>
From: Yegor Yefremov <yegorslists@...1030...>
Date: Sun, 23 Nov 2014 20:49:26 +0100
Message-ID: <CAGm1_ktj1i_DfuXwBYrKX1qk-sZHpxV8jR6Fbr4TnSJgGdFNvA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] configure.ac: fix default behavior
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Sat, Nov 22, 2014 at 12:57 PM, Gert Doering <gert@...1296...> wrote:
> Hiya,
>
> On Sat, Nov 22, 2014 at 11:47:05AM +0100, Arne Schwabe wrote:
>> Almost anybody always turns this feature on, at least all distribution
>> have it on.
>
> Which is indeed a strong argument for removing the conditional... maybe
> quickly discuss this ("anyone strongly opposed?") at the next meeting?

Btw another mismatch:

AC_ARG_ENABLE(
        [small],
        [AS_HELP_STRING([--enable-small], [enable smaller executable
size (disable OCC, usage message, and verb 4 parm list)
@<:@default=yes@:>@])],
        ,
        [enable_small="no"]
)

Yegor

