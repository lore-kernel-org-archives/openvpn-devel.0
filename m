MIME-Version: 1.0
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 24 Mar 2021 17:14:37 +0200
Message-ID: <CAGyAFMUg4+nsVGpjFiEBiJf4nP7BqvhRv6GC7jXBp20ef49HZA@...278...>
Subject: [Openvpn-devel] Introducing the OpenVPN Data Channel Offload
 Windows driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Dear all,

OpenVPN Inc. and I are happy to announce that we've released
ovpn-dco-win, which stands for
"OpenVPN Data Channel Offload for Windows". It is a modern Windows
driver, which functions
as a virtual network adapter and implements required functionality to
handle the OpenVPN data channel.
When using ovpn-dco-win, the OpenVPN software doesn't send data
traffic back and forth between user
and kernel space, but operations on payload take place in the Windows
kernel. The driver is being developed
using modern frameworks - WDF, NetAdapterCx and DMF. Because of that,
the code is easy to read
and maintain. Speed-wise the new driver performs significantly better
compared to tap-windows6,
so it should eliminate the main bottleneck which hampers the
performance of OpenVPN on Windows.

Source code repository is hosted here: https://github.com/OpenVPN/ovpn-dco-win

Performance numbers below are iperf3 test results conducted on AMD
ThreadRipper 3970x
between Hyper-V Windows and Linux guests. Cipher algorithm used is AES-256-GCM.

OpenVPN 2.5 dco-win          <-> OpenVPN 2.5 dco-linux: Down
1.74Gbit/s, Up 1.51Gbit/s
OpenVPN 2.5 wintun            <-> OpenVPN 2.5 dco-linux: Down
1.20Gbit/s, Up 1.20Gbit/s
OpenVPN 2.5 tap-windows6 <-> OpenVPN 2.5 dco-linux: Down  500Mbit/s,
Up  600Mbit/s

Thanks to Arne Schwabe, there is now a beta version of the openvpn-gui
client with dco-win support.
Installer could be found here:
https://swupdate.openvpn.net/beta-downloads/win-dco/openvpn-install-dco-preview-Win10.exe
It was built from "dco" branch in Arne's github repo
https://github.com/schwabe/openvpn/tree/dco.
See https://github.com/schwabe/openvpn/blob/dco/README.dco.md for more
info about current and general limitations.

To use ovpn-dco-win with openvpn2, add the following lines to the .ovpn profile:

  windows-driver ovpn-dco-win
  tun-mtu 1428

OpenVPN3 support is in progress and coming soon.

Please note that ovpn-dco-win only works with Windows 10 2004 and
newer versions.

Looking forward to feedback and patches!

