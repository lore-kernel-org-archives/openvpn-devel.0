From: Moshe <makeit_quick@...109...>
Message-ID: <loom.20041125T155449-644@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] TAP-Win32 Link problem
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
Date: Thu Nov 25 07:13:01 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

(posted comment before but didn't see it - so I'm re sending)

It looks like the TAP Adapter gets its link up signal as soon as the socket is 
being connected.
Several problems with that:
- There is no actual logical connection between the parties.
  It could be another fake process, an intermediate proxy, or a bad version of 
OpenSSL, bad keys... etc.
  The user sees the adapter link brought up and down - and this is misleading 
as the user thinks that the far end was indeed connected but something 
happened.
- As soon as the TAP adapter link is up, Windows starts to send packets.
  Normally this is fine, but if the other end is not yet connected (using 
proxy), the socket buffer starts to fill for no good reason

Looks like there needs to be a logical handshake before link is brought up.

My 2 cents
Moshe



