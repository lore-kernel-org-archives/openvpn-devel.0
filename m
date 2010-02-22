Message-ID: <20100222165217.13658.qmail@...1287...>
Date: Mon, 22 Feb 2010 17:52:17 +0100
From: Peter Stuge <peter@...1287...>
References: <4B82366D.4080405@...1114...> <1266855859.19847.0@...1207...>
MIME-Version: 1.0
In-Reply-To: <1266855859.19847.0@...1207...>
Subject: Re: [Openvpn-devel] [PATCH v2] Do not randomize resolving of
	IP	addresses in getaddr()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Karl O. Pinc wrote:
> Someone may be relying on the behavior but, at the moment
> or depending on present dns circumstances, does not have
> multiple A records returned.  In this case no warning will
> be generated.

The flip side of that coin is also valid I think.

Consider independent configuration of VPN and DNS. Early errors would
restrict VPN setup and possibly shipment until after DNS has been set
up, while lazy evaluation allows DNS changes to happen later.

May be particularly important since DNS has a builtin propagation
delay of any changes.

I'm not saying I disagree, but that it may be a tradeoff.


//Peter

