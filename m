From: Stefan Monnier <monnier@...1282...>
Message-ID: <jwvfx4atsnq.fsf-monnier+inbox@...1269...>
References: <1268075941.2962.0@...1207...>
Date: Mon, 08 Mar 2010 16:26:11 -0500
In-Reply-To: <1268075941.2962.0@...1207...> (Karl O. Pinc's message of "Mon, 08 Mar
	2010 13:19:01 -0600")
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net, Peter Stuge <peter@...1287...>

> In either case we'd be looking at an openvpn configuration
> directive (or 2) that takes a command to run once
> the link comes up (and down).  If that was in place then
> any of A, B, C, or D, or your choice of using an ifup/ifdown
> script would all work.

BTW, there are generic tools to run/stop dhcp clients (and other
configuration steps) when the interface goes up/down.  I've used ifplugd
for it, but IIUC there are others.

I think if the user just starts the dhcp client on an interface
independently from the moment the interface goes up (or down), this is
simply a misconfiguration.

> Given that.  Why not just use -up and --down to do what's
> needed?  Avoid changing the code and write documentation.

Sounds about right,


        Stefan

