Message-ID: <4B226083.2040601@...1270...>
Date: Fri, 11 Dec 2009 17:08:51 +0200
From: Yevgeny Kosarzhevsky <yevg@...1270...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Client <connection> blocks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Greetings,

I've setup the client to use two connection blocks, but wasn't able to
provide certain options in it.

I have one <connection> block in udp mode and the other one in tcp. I'd
like to customize udp-specific options, like fragment, mssfix,
replay-window, tun-mtu. If I put it in udp connection block, then I get 
error:

Options error: option 'fragment' cannot be used in this context

Otherwise, if I put them globally, I get:

Options error: --fragment can only be used with --proto udp

I think some other options which I haven't tested should be moved to
<connection> blocks, like comp-lzo, no-replay, no-iv, cipher, auth and
may be some more, so one configuration file may be able to connect to
different server configurations.

Am I missing something and workaround exists already?



