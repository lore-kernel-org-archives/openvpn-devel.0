From: "James Yonan" <jim@...41...>
Message-ID: <twig.1086485727.92671@...41...>
Subject: [Openvpn-devel] OpenVPN 2.0-beta3 released
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
Date: Sat Jun  5 18:36:05 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Change Log:

2004.06.05 -- Version 2.0-beta3

* More changes to TAP-Win32 driver's INF file which
  affects the placement of the driver in the Windows
  device namespace.  This is done to work around an
  apparent bug in Windows when short HWIDs are used,
  and will also ease the upgrade from 1.x to 2.0 by
  reducing the chances that a reboot will be needed
  on upgrade.  Like beta2, this upgrade will
  delete existing TAP-Win32 interfaces, and reinstall
  a single new interface with default properties.
* Major rewrite of I/O event wait layer in the style
  of libevent.  This is a precursor to TCP support
  in --mode server.
* New feature: --status.  Outputs a SIGUSR2-like
  status summary to a given file, updated once
  per n seconds.  The status file is comma delimited
  for easy machine parsing.
* --ifconfig-pool now remembers common names and
  will try to assign a consistent IP to a given
  common name.  Still to do: persist --ifconfig-pool
  memory across restarts by saving state in file.
* Fixed bug in event timer queue which could cause
  recurring timer events such as --ping to not
  correctly schedule again after firing.  This in
  turn would cause spurrious ping restarts and possible
  connection outages.  Thanks to Denis Vlasenko for
  tracking this down.
* Possible fix to reported bug where --daemon argument
  was not printing to syslog correctly after restart.
* Fixed bug where pulling --route or --dhcp-option
  directives from a server would problematically
  interact with --persist-tun on the client.
* Updated contrib/multilevel-init.patch (Farkas Levente).
* Added RPM build option to .spec and .spec.in files
  to optionally disable LZO inclusion (Ian Pilcher).
* The latest MingW runtime and headers define
  'ssize_t', so a patch is needed (Gisle Vanem).

James


