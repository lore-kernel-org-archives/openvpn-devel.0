From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] TCP-over-TCP (was: Multi-channel VPN)
Message-ID: <20030424215352.GA17849@...33...>
References: <Pine.LNX.4.50.0304231914210.2917-100000@...48...> <200304241742.h3OHg1131300@...41...>
Mime-Version: 1.0
In-Reply-To: <200304241742.h3OHg1131300@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Apr 24 14:54:10 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thu, 24 Apr 2003, James Yonan wrote:

> Actually, I was thinking more about the situation where people are forced to
> tunnel IP over TCP, for whatever reason, when UDP is not an option.  Since IP
> is designed to transit over an unreliable physical layer, when you tunnel it
> over TCP (a la vpnd or IP over ssh) you end up with this problem:
> 
> http://sites.inka.de/sites/bigred/devel/tcp-tcp.html (see Stacking TCPs)
> 
> The key issue here is that when you tunnel IP over TCP, that will usually mean
> TCP over TCP.  And this tends to break TCP's retransmission algorithm.  As the
> article above states: "The upper layer will queue up more retransmissions
> faster than the lower layer can process them".
> 
> So my idea is why not filter out the upper layer TCP retransmissions, and
> synthesize the return ACKs so that the upper TCP layer doesn't begin the
> exponential backing off of the retransmit timer that eventually will stall the
> connection?  This process would essentially strip the upper layer TCP of its

I think data volume (in flight or lost) is the issue, not stalls. Once
an ACK of the outer layer is returned, the inner layer will implicitly
also see an ACK (payload) which will then kick the data flow alive
again.

> reliability function, since now the lower TCP layer will provide that
> function.  This is not difficult to implement, since to OpenVPN, the upper
> layer protocols are all simply byte streams flowing over the TUN pipe.  They
> can be filtered without resorting to raw sockets or any other such potentially
> unportable constructs.

Only that OpenVPN would have to parse the TCP protocol for IPv4 and
IPv6.

-- 
Matthias Andree

