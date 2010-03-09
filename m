From: Stefan Monnier <monnier@...1268...>
Message-ID: <jwvhbopioq5.fsf-monnier+inbox@...1269...>
References: <1268097644.11342.2@...1207...>
Date: Tue, 09 Mar 2010 09:01:32 -0500
In-Reply-To: <1268097644.11342.2@...1207...> (Karl O. Pinc's message of "Mon, 08 Mar
	2010 19:20:44 -0600")
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

> bring the interfaces up
> start dhcp client (if not triggered directly from the interfaces)
> start openvpn

That is a misconfiguration in my book.  The only correct configuration
is when the dhcp client is triggered from the interface.  After all,
openvpn may take half an hour to get the connection and it may lose the
connection at some point and reconnect to another openvpn server (via
round-robin DNS, for example) which might require a reconfiguration on
the dhcp side.
Of course, the correct result can be obtained in various ways:
- let openvpn run scripts to start&stop the dhcp client.
- use ifplugd (assuming it works with openvpn, which I haven't checked).
- use a dhcp client which internally does what ifplugd does (don't know
  which ones that would be).


        Stefan

