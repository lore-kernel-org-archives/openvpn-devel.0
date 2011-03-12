Message-ID: <20110312153620.8987.qmail@...1287...>
Date: Sat, 12 Mar 2011 16:36:20 +0100
From: Peter Stuge <peter@...1287...>
References: <20110308185252.301d0a1d@...1451...>
	<20110309084745.GN9835@...1296...>
	<20110309085656.18e0e796@...1451...> <20110311122309.1292c1dd@...1451...>
	<4D7A7455.4070805@...1114...>
	<20110312003517.3a86c508@...1451...>
MIME-Version: 1.0
In-Reply-To: <20110312003517.3a86c508@...1451...>
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
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

Federico Heinz wrote:
> The reason I looked into this in the first place was that, unlike
> those TCP-based protocols, I couldn't get OpenVPN to work on a
> firewall with two external IP addresses without running two deamons,
> each one bound to one interface only. It is then that I stumbled upon
> the difficulty of setting up the server that must listen on an
> interface that has a dynamically-assigned address.

If this is the problem you want to solve I have to say I think you're
doing it the wrong way.

There are components in your system which *will* know when your
address is reconfigured. Please just configure them to reconfigure
OpenVPN. This would seem to be a good use for the management
interface in OpenVPN.

I like to use udhcpd for systems like this. It is fast and
no-nonsense. It runs a script that you have to write.

It makes no sense trying to work around the requirement of knowing
your configuration. That is always neccessary, unless you are
prepared to listen on 0.0.0.0, which I would guess already works
without special OpenVPN options or code.


//Peter

