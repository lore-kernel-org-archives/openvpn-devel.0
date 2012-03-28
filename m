MIME-Version: 1.0
In-Reply-To: <4F72D845.2060800@...1147...>
References: <20120326160546.GV1359@...1296...>
	<CAOazyz1W7ZcVEhDwq0DWCOjQ_DetcjP6yDg1MhOPiMYqu2Sr6w@...278...>
	<20120326175543.GX1359@...1296...> <4F72D60D.30405@...1147...>
	<CAOazyz0262BjtxkuHxeY8mJvNkwWoX4GQ5N__DLT1f3iGO0d5A@...278...>
	<4F72D845.2060800@...1147...>
Date: Wed, 28 Mar 2012 11:28:45 +0200
Message-ID: <CAOazyz2QxyY3CYFUrRxXC6i=agXN88eBzd+FkZ_BH0xq+p0vQA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [DISCUSS] much more complicated gcc invocations
	now
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
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Mar 28, 2012 at 11:22 AM, Jan Just Keijser <janjust@...1147...> wrote:
> ah OK, I normally don't care about dependencies because I build openvpn only
> once. why did automake decide to add these rules , whilst it didn't do so in
> the past?

Yes, it should had.

> and no, apart from the above I don't have a specific question, but I also
> don't like it when things are added to a (build) system that I don't see an
> immediate use for. For what it's worth, I'm very happy that the build system
> wasn't rewritten using 'cmake' - if that happens I'm forking the source code
> immediately :)

I will never go to cmake! These guys re-invented the wheel, I don't
understand their syntax nor their vision. And most importantly their
loooong bug list which only gets longer.

Alon.

