Message-ID: <1088639130.40e3509ab594b@...238...>
From: Brandon Knitter <knitterb@...237...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Recommend: Version Banner
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
Date: Wed Jun 30 16:46:04 2004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I had someone with a config error, and I asked them what version they were
running, but since there was a config error, OpenVPN didn't show the version
banner before the config failed to load.

Turns out they had version 1.6, but I'm able to reproduce this in 2.0.  It would
have made it easier to figure out what version they were running and get them
into 2.0 land.

The config error was the "pull" option which 1.6 didn't have.  I added the
config option "eeegads" and I got the same non-banner error in 2.0.

Thanks,

-- 
-bk






