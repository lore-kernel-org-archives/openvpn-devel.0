Message-Id: <200302161913.h1GJDuf19905@...41...>
From: "James Yonan" <jim@...41...>
Subject: [Openvpn-devel] Pre-1.3.3 beta available for testing
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
Date: Sun Feb 16 11:15:04 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Hello OpenVPN Users & Developers,

I thought it would be a good time to wrap up the minor fixes that have gone
into the codebase over the last couple months.

So here's a beta which I would encourage you to test as much as possible. 
While the changes are mostly minor, some of the fixes such as --tun-mtu-extra
resulted in major changes to the MTU sizing algorithm.  As well, I have only
built for RH Linux in my testing, so please test on other OSes, distros,
processor architectures, etc.

Beta is available on CVS as well as here:

http://openvpn.sourceforge.net/beta/openvpn-1.3.2.9.tar.gz

Change Log:

2003.02.16 -- Version 1.3.2.9

* Added --replay-persist feature to allow replay
  protection across sessions.
* Fixed bug where --ifconfig could not be used
  with --tun-mtu.
* Added --tun-mtu-extra parameter to deal with
  the situation where a read on a TUN/TAP device
  returns more data than the device's MTU size.
* Fixed bug where some IPv6 support code for
  Linux was not being properly ifdefed out for
  Linux 2.2, causing compile errors.
* Added OPENVPN_EXIT_STATUS_x codes to
  openvpn.h to control which status value
  openvpn returns to its caller (such as
  a shell or inetd/xinetd) for various conditions.
* Added OPENVPN_DEBUG_COMMAND_LINE flag to
  openvpn.h to allow debugging in situations
  where stdout, stderr, and syslog cannot be used
  for message output, such as when OpenVPN is
  instantiated by inetd/xinetd.
* Removed owner-execute permission from file
  created by static key generator (Herbert Xu
  and Alberto Gonzalez Iniesta).
* Added --passtos option to allow IPv4 TOS bits
  to be passed from TUN/TAP input packets to
  the outgoing UDP socket (Craig Knox).
* Added code to prevent open socket file descriptors
  from being accessible to called scripts.

James


