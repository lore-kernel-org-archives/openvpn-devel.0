Subject: Re: [Openvpn-devel] route from server?
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1079253737.85837@...41...>
In-Reply-To: <200403111500.i2BF0uFw018614@...179...>
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
Date: Sun Mar 14 00:43:45 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Marc Hassman <mhassman@...178...>
Cc: openvpn-devel@lists.sourceforge.net

Marc Hassman <mhassman@...178...> said:

> A question and a suggestion:
>  
> Q: This is probably an XP problem rather than a OpenVPN one. With Windows XP
> as a client, I can 
> add an arbitrary route using the 'route' statement and I observe it being
> added in the 'route print' listing.
> However, a few seconds later the route disappears from XP's routing table.
> Has anybody else 
> experienced this?

Make sure that the TAP-Win32 adapter is getting an IP address.  From a command
prompt window, "ipconfig /all" will show the currently assigned adapter
addresses.  If the TAP adapter loses its IP address, all routes connected with
the adapter will be dropped.

> S: It would be helpful when running in a 1 config file/tcp/tap/inetd setup
> if the server end of the connection
> could push static routes to the client thereby making a change a single
> server file change and not a 
> per client file change. I think this might be beneficial to other setups as
> well.

This is planned for 2.0.

James




