MIME-Version: 1.0
In-Reply-To: <20120626135004.GM22125@...1296...>
References: <1340715726-14670-1-git-send-email-alon.barlev@...277...>
	<20120626133532.GK22125@...1296...>
	<CAOazyz1A5mo9hKXi-KXUsoAUeNp1ELtA784xgYOzGT+e7BFu=Q@...278...>
	<20120626135004.GM22125@...1296...>
Date: Tue, 26 Jun 2012 16:56:54 +0300
Message-ID: <CAOazyz1PEDLF6ADscuGHRJ_XeAg--nSfiZHcffsyPzkvz_HmGA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: plugins: set default to no in
	Windows
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

On Tue, Jun 26, 2012 at 4:50 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Tue, Jun 26, 2012 at 04:41:49PM +0300, Alon Bar-Lev wrote:
>> This is exactly the reason why *ALL* plugins should be disabled by default.
>> We are left with only Linux enabled... and distro maintainer can take
>> care of that anyway.
>> But again... my opinion is not matter, right... sending a new patch.
>
> FreeBSD, NetBSD and OpenSolaris have PAM and build just fine, it's just
> OpenBSD that does not.
>
> (*My* opinion wasn't taken into account either - I proposed to auto-build
> if possible, and if libraries are not found, just don't make a fuzz and
> do not build the corresponding plugin, instead of erroring out - but I'm
> not feeling strongly about this, so I'll accept what's there, and not
> enter a lengthy discussion)
>

You are more than welcome to maintain the build system and do whatever you like.

Alon.

