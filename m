Message-ID: <51DFD7D9.6050503@...1388...>
Date: Fri, 12 Jul 2013 22:18:01 +1200
From: Michael Ludvig <mludvig@...1388...>
MIME-Version: 1.0
Subject: [Openvpn-devel] client-connect / client-disconnect scripts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi

I'm having troubles with client-connect and client-disconnect scripts in
OpenVPN 2.3.2.

1) client-connect script is called on the server only once (maybe once
for each user?) and on subsequent connects its previous output is
re-used but the script isn't called again. It looks like the config
produced by the script is cached - can I somehow disable that caching
and force calling the script for every client connect?

2) client-disconnect never seems to be called. If I successfully connect
(and and then kill the client the disconnect is never called. I tried to
wait for a timeout for openvpn to realise the other end has died but it
never happened.

Any idea how what's causing these problems and how to make openvpn do
what I want? That is call the scripts on all client connects and
disconnects?

Thanks!

Michael

