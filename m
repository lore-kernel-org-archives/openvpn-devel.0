Date: Wed, 10 Feb 2016 08:36:22 +0100
From: Samuel Thibault <samuel.thibault@...1817...>
Message-ID: <20160210073622.GH2673@...2120...>
References: <20160208213929.GA20623@...2120...>
	<20160209092821.GH24952@...1296...>
	<20160209101533.GJ3102@...2121...>
	<20160209104625.GL24952@...1296...>
	<20160209105839.GP3102@...2121...>
	<20160209115825.GP24952@...1296...>
	<20160209124533.GQ3102@...2121...>
	<56BA8AD9.7060309@...2080...>
MIME-Version: 1.0
In-Reply-To: <56BA8AD9.7060309@...2080...>
Subject: Re: [Openvpn-devel] route / route-ipv6 can not be used in ccd
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

David Sommerseth, on Wed 10 Feb 2016 01:56:57 +0100, wrote:
> > 2 minutes after the client disconnected, which would probably be fine
> > enough for our use case.
> 
> If you use --proto udp, then it can take up to --ping-reset $SEC to trigger
> (IIRC).  You can use explicit-exit-notify to avoid this behaviour.

Apparently I forgot to uncomment the option, indeed.

Samuel

