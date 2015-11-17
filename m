MIME-Version: 1.0
In-Reply-To: <20151117130353.GO24952@...1296...>
References: <CAN-X3HSXj9a1kiKGBJ1eHgoTeA97WmpqQJPCYf5esKYQa8fLjA@...278...>
	<20151117130353.GO24952@...1296...>
Date: Tue, 17 Nov 2015 13:43:50 +0000
Message-ID: <CAN-X3HQ4Rf7RaCY27cLkdPo1kLtAHmXtXeM1jh=j=mPgQGeR6A@...278...>
From: Christian Pellegrin <chripell@...410...>
Subject: Re: [Openvpn-devel] [PATCH] Fix info.af == AF_UNSPEC case after
 commit 2bed089d31a12c2d0277e36a64964ebab6640f75
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

On Tue, Nov 17, 2015 at 1:03 PM, Gert Doering <gert@...1296...> wrote:
> Why are you seeing AF_UNSPEC there?  This is actually more interesting
> to me right now than debating possible avenues to fix this :-)

I also see: "Could not determine IPv4/IPv6 protocol. Using AF_INET" in
the logs (which points in an quite explicative conditional in
socket.c). The configuration entries that might affect this and that
are present in my configuration are:

local [IPv4 address]
lport 443
mode server
proto udp
server [IPv4 subnet]
topology subnet

and this happens on a host where I configured just IPv4 (even if the
host itself is dual homed). Interestingly, if I configure full IPv6,
i.e. I add:

local [IPv6 address]
proto udp6
server [IPv6 netblock]

the problem (and of course above message) goes away. I mistakenly
assumed that seeing AF_UNSPEC is OK (from various comments when you
grep for AF_UNSPEC). If you think the root of all evil is this value,
I will dig further.

Thanks!

