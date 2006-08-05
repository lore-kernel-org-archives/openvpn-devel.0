From: Andrew Wenlang Zhu <azhu@...716...>
In-Reply-To: <44D2A3B9.9050506@...277...>
References: <44D2A3B9.9050506@...277...>
Date: Fri, 04 Aug 2006 17:17:03 -0700
Message-Id: <1154737023.20206.169.camel@...717...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OpenVPN dev-type option does not work on Solaris
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


On Solaris 8 and 10, I have to use a different driver other than the
Universal Tun driver. My driver name is "atun". However, if I change my
driver name to "tun", it works just fine.

Basically, on Solaris, OpenVPN can not take a device type and name if
not "tun", and OpenVPN complains:

Thu Aug 3 23:36:04 2006 us=146055 'atun0' is not a TUN/TAP device. The
--ifconfig option works only for TUN/TAP devices.
Thu Aug 3 23:36:04 2006 us=146097 Exiting

The configuration file I used:

dev atun0
dev-type atun
dev-node /dev/atun
remote 172.16.16.6
ifconfig 1.1.1.1 1.1.1.2
secret /static.key
daemon

I do not know if anyone run into the same problem on other X-nux system.
I already have a fix for Solaris and will post the fix shortly.

Andrew 
  


