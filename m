From: Bernhard Schmidt <berni@...376...>
Date: Fri, 25 Jun 2010 01:27:35 +0000 (UTC)
Message-ID: <i010m7$hjk$1@...1312...>
Subject: [Openvpn-devel] Debian package of feat_allmerged
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I have just restarted building Debian/Ubuntu OpenVPN packages for the
feat_allmerged branch of openvpn-testing.git for my private use. If you
want to test them, feel free to have a look at
https://launchpad.net/~berni/+archive/ipv6 . There are up-to-date
versions for Ubuntu Karmic and Ubuntu Lucid available. The lucid package
works just fine on Debian Squeeze. 

I don't have binaries for older Ubuntu versions and for Debian Lenny at
the moment, because my package relies on new features of dh7. It should
be possible to create one with a bit of work if there is demand (I don't
run OpenVPN on Lenny anywhere).

I will try to automate rebuilding packages on git updates if someone is
interested in them.

Best Regards,
Bernhard


