Subject: Re: [Openvpn-devel] TUN Server: Suggested IP allocation change
From: Torge Szczepanek <openvpn-devel@...239...>
In-Reply-To: <BAY19-F4e8tlMazUSxv0000c938@...160...>
References: <BAY19-F4e8tlMazUSxv0000c938@...160...>
Message-Id: <1100448888.3997.14.camel@...299...>
Mime-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Nov 14 08:16:02 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi!

> Currently for IP routing using the tun device, each client is assigned a /30 
> subnet.  This does not make sence as the server has only a single IP.  
> (Could work if individual interface created on server with unique IP for 
> each)

I also suggested this, but there are drawbacks as James wrote in some
mails on this list. 
The Windows TAP/TUN driver is a TAP driver, which cannot do real Point-
to-Point operation. TUN under Windows is just a emulation on a TAP
device.

> I suggest we simplify it into a point to multipoint setup with /32 mask per 
> client.
> This will reduce IP usage by 400% and simplify setup.

And locks out all Windows-Clients until someone implements a real TUN-
Driver for Windows.

If you do not have Windows Clients take a look at ifconfig-pool-linear
Option.
-- 
Torge Szczepanek <openvpn-devel@...239...>


