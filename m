From: <steffan.karger@...1435...>
Date: Mon, 21 Jan 2013 14:13:24 +0100
Message-ID: <1358774007-4881-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] PolarSSL 1.2.3+ patches for 2.4 (no PolarSSL<1.2.3
	support any more)
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

As discussed on this mailinglist and the openvpn-devel IRC-channel, I created a new set of patches for the '2.4' or master branch. This drops support for versions of PolarSSL before 1.2.3, but considerably reduces the number of #ifdefs, that were required for backward compatibility with polar 1.1.

These patches are otherwise functionally equal to the polar 1.2 patches submitted by me earlier.

Regards,
-Steffan


