From: Jon Nelson <jnelson-openvpn@...135...>
Message-ID: <Pine.LNX.4.58.0311180916570.17332@...136...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Working with 2.6
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Nov 18 07:19:32 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Openvpn-devel@lists.sourceforge.net

Just so you all know, I'm using OpenVPN 1.5beta12 (soon to be beta14)
with Linux 2.6.0-test9 (vanilla, no patching).

The only problem I encountered is that I had to alter by devfs
configuration because the tun device has moved from /dev/net/tun to
/dev/misc/net/tun -- fortunately there are existing (commented out)
directives in the devfs configuration for this.

--
Democracy is two wolves and a sheep voting on what to have for dinner.
Liberty is two wolves attempting to have a sheep for dinner and
finding a well-informed, well-armed sheep.

Jon Nelson <jnelson-openvpn@...135...>

