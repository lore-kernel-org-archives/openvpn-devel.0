From: Stefan Monnier <monnier@...1268...>
Message-ID: <jwvsk87dlhk.fsf-monnier+inbox@...1269...>
References: <4B9515FF.6000704@...41...>
	<20100308174321.GA25238@...1296...> <4B966A98.4000206@...41...>
Date: Thu, 11 Mar 2010 08:51:59 -0500
In-Reply-To: <4B966A98.4000206@...41...> (James Yonan's message of "Tue, 09
	Mar 2010 08:34:48 -0700")
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
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
To: James Yonan <jim@...41...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> Implementing a DHCP client within OpenVPN tends to make this a more
> self-contained problem.

I don't think OpenVPN should get into the DHCP business.
Especially because this is not a problem specific to OpenVPN: the same
problem of refreshing DHCP info happens with ethernet and with wifi when
you disconnect and reconnect.

Various solutions to this problem already exist: a tool (e.g. ifplugd)
can monitor the interface's status, or OpenVPN can be instructed (via
its script hooks) to run commands upon (re|dis)connection.

These existing solutions are better because they profit from the general
infrastructure and will hence blend in much better.  E.g. they will
automatically adopt the global DHCP customizations.


        Stefan

