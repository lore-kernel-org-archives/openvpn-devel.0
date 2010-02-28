Date: Sun, 28 Feb 2010 16:05:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100228150546.GO9556@...1296...>
Mime-Version: 1.0
Subject: [Openvpn-devel] FreeBSD funny in the code
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
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

tun.c contains this code, in the 

#elif defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)

part of do_ifconfig() (about line 983 in the IPv6 payload branch):

----------------- snip ----------------
      else { 
        if (tt->topology == TOP_SUBNET)
            argv_printf (&argv,
                              "%s %s %s netmask %s mtu %d up",
                              IFCONFIG_PATH,
                              actual, 
                              ifconfig_local,
                              ifconfig_remote_netmask,
                              tun_mtu
                              );
        else
            argv_printf (&argv,
                          "%s %s %s netmask %s mtu %d up",
                          IFCONFIG_PATH,
                          actual,
                          ifconfig_local,
                          ifconfig_remote_netmask,
                          tun_mtu
                          );
      }                   
----------------- snip ----------------

Is it just me needing new glasses, or is this twice the very same code,
with a little bit of different indentation?

If other people see this too, I'll send in a patch that drops the 
duplicate bits.  The tun.c code is still hard enough to read...

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

