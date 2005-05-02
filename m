From: Alex Ongena <Alex.Ongena@...388...>
Message-Id: <1115022714.29941.47.camel@...389...>
Mime-Version: 1.0
Subject: [Openvpn-devel] client-connect script not always called ?
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
Date: Mon May  2 01:33:08 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I have a running openvpn 2.0 environment, in routed / server
mode (tun) and have noticed that:

- when the client is stopped (proper shutdown)
- and started again (with eventualy new config) _before_ ping-restart
  or inactivity are expired on the server.

the 'client-connect' script is _not_ called on the server side.

Is this the intension ?

If so, why ?

It's a proper shutdown on client side, so the client can inform
the server. The server should call IMHO 'client-disconnect' and
afterwards a 'client-connect', regardless if some timeouts are
expired or not.

Thanks
alex



--
aXs GUARD has completed security and anti-virus checks on this e-mail
(http://www.axsguard.com)
---------------------------------------------------

