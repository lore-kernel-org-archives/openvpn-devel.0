From: Vladimir Kamarzin <vvk@...1868...>
In-Reply-To: <20140305122113.GT16637@...1296...>
References: <1393929449-423915-1-git-send-email-vvk@...1868...>
	<53163C6D.7050801@...1227...> <283911394015829@...1871...>
	<20140305122113.GT16637@...1296...>
MIME-Version: 1.0
Message-Id: <1296731394023471@...1872...>
Date: Wed, 05 Mar 2014 18:44:31 +0600
Subject: Re: [Openvpn-devel] [PATCH] Extract MAC addresses from ARP packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> Adding it would solve the issue at hand, but I'm not convinced that you'll
> be happy with the end - it might actually end up saturating VPN links and
> making users unhappy if you have "much flooded traffic" (which happens in
> some of the networks).

I've patched openvpn this way and testing this setup right now, it working well for now. I think it may be implemented as an option (config or ifdef). What do you think?

