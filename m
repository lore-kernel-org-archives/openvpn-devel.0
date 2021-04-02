References: <20210402134529.27866-1-gert@...1296...>
 <b92f02afa4d8156edd55c2126ae6352c.squirrel@...2260...>
 <20210402185720.GS976@...1296...>
 <c76250866ae96447a3ec712f04b4b346.squirrel@...2260...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <458e1fb5-a725-781b-c048-4f0e07440c7b@...1227...>
Date: Fri, 2 Apr 2021 22:40:36 +0200
MIME-Version: 1.0
In-Reply-To: <c76250866ae96447a3ec712f04b4b346.squirrel@...2260...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Fix 'compress migrate' for 2.2 clients.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Simon Matter <simon.matter@...2249...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


> 
> To me it seems like you can of course build a scenario where compression
> _could_ be a problem some how, but there are certainly many use cases
> where it can be considered almost impossible to have your security
> weakaned by compression. I mean, there is also the SSH VPN mode with c<n
> be used with compression and I've never heard someone saying it's less
> secure with compression.

That will be also affected by VORACLE style attacks. But SSH VPN and SSH
is also by no mean safe against these kind of attacks. They might be
harder to pull off but the underlying attacks still apply.

> In our case where we connect several subnets via OpenVPN and there goes a
> lot of different traffic from dozens of hosts in every location, I still
> fail to understand how our security would be impacted by compression?

The attacks are not that easy to understand. So not to patronise you but
if you if you don't understand it, then it might be better to err on the
safe side?

> In the end my only question is is it worth to remove compression from
> OpenVPN in the long run, or is this not planned?
> 

Attacks are becoming better and better if there is a vector to attack.
But Beast/Crime/VORACLE have shown that these attacks are possible, so
enabling compression by default is no longer safe.

The benefit of VPN compression are also dimished a lot in recent years.
Most traffic nowadays is already encrypted and even if the traffic is
still plain text, the VPN compression only works on a packet per time,
so the achievable gains are low.

I haven't seen any real life example of VPN compression doing anything
tangible in the recent years that wasn't a speedtest that send large
blocks of zeros.

Arne

