Message-ID: <5468BB10.8020609@...1856...>
Date: Sun, 16 Nov 2014 15:56:16 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Removing the --disable-ssl configure flag
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net

Hi,

To reduce the code and testing complexity a bit, I'd like to remove the
--disable-ssl configure option in the master/2.4 branch.

During the community meeting this weekend there were no objections
amongst he developers present. But before actually removing the flag, we
wanted to put this out there so anyone who relies on this can step forward.

So, is there anyone out there who needs --disable-ssl?

-Steffan

(BCC to openvpn-devel, keep any discussion within openvpn-users please)

