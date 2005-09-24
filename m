From: James Yonan <jim@...41...>
Message-ID: <Pine.LNX.4.58.0509240210210.25922@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.0.2-TO4 released -- major progress on allowing non-admin
 access
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
Date: Sat Sep 24 03:31:41 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

This release is the latest in the topology branch which was first 
discussed here:

http://openvpn.net/archive/openvpn-users/2005-09/msg00079.html

Included in the Windows version of this release is a long-sought-after 
feature:  The ability for OpenVPN to open the TAP-Win32 adapter from 
accounts other than administrator.

Two methods of setting non-admin access are provided.  The first method is 
implemented in the TAP-Win32 driver itself.  By default, non-admin access 
is now allowed, however this can be turned off in the adapter advanced
properties dialog, or in the OemWin2k.inf file.

The second method configures non-admin access from userspace, using the 
new --allow-nonadmin standalone flag to the openvpn command.  This method
was more of a proof-of-concept, before I ported the code to the TAP-Win32
driver.

I need people to test this new TAP-Win32 driver on as many Windows
versions as possible (it is included in the pre-built Windows installer
for this release).  Of course, you should treat it as an early beta
release, and not use it in production yet.  I've tested the driver on XP
SP2 only, and more testing is needed on Win2K and Server 2003.

One of the interesting ramifications of this feature, is that it sets the 
stage for non-admin accounts to be able to run OpenVPN directly, without 
using the service wrapper.

With OpenVPN 2.0, this couldn't happen for two reasons: (a) opening the 
TAP-Win32 device object required administrative privileges, and (b) if the 
server pushed routes, the client couldn't add them because adding routes 
on Windows requires privilege.

This new release addresses (a).  (b) is still an issue if the server is 
pushing routes.  However (b) is less of an issue now since the "topology 
subnet" feature was added, because it allows a tun-based tunnel to operate 
without requiring any mandatory route pushes in order to function.  Of 
course, if you are pushing custom routes, or are pushing 
"redirect-gateway" to clients, then those routes cannot be added if the 
user lacks administrative privileges (is there a finer-grained 
privilege that allows route modification without full admin privileges?).

Testing is quite easy.  Simply add this line to your "dev tun" based 
server config:

  topology subnet

Download:

http://openvpn.net/beta/to/

Change Log:

2005.09.23 -- Version 2.0.2-TO4

* Added feature to TAP-Win32 adapter to allow it to be
  opened from non-administrator mode.  This feature
  is enabled by default, and can be enabled/disabled
  in the adapter advanced properties dialog.
* Added --allow-nonadmin standalone option for Windows to
  set TAP adapter to allow non-admin access.  This
  is a user-mode version of the code, and duplicates
  the same feature as the above entry.
* Added fix that attempts to solve corner case of tunnel not
  forwarding packets when system clock is reset to an earlier time.
* Added --redirect-gateway bypass-dns option.  (Developers:
  To add bypass-dhcp or bypass-dns support to other OSes,
  add a get_bypass_addresses function to route.c for
  your OS.)
* Added OPENVPN_PLUGIN_CLIENT_CONNECT_V2 plugin callback, which
  allows a client-connect plugin to return configuration text
  in memory, rather than via a file.
* Fixed a bug where --mode server --proto tcp-server --cipher none
  operation could cause tunnel packet truncation.
* openvpn --version will show [LZO1] or [LZO2], depending on
  version that was linked.

James


