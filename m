From: Steffan Karger <steffan@...1856...>
Date: Wed,  8 Jun 2016 14:20:38 +0200
Message-Id: <1465388443-15484-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Add support for cipher negotiation
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

The following five patches add support for cipher negotiation, according to
the 'IV_NCP=2' mechanism as described in
http://permalink.gmane.org/gmane.network.openvpn.devel/9385.

Please test and provide comments.  I ran the 'make check' test suite, including
t_client tests, and performed manual testing.  But, as Gert eloquently puts it,
this is likely to 'break stuff in interesting ways', so more testing (and
review) is very welcome!

-Steffan

PS I already sent 1/5 to the list before, but it did not get reviewed back then.
   This patch set requires it to work properly, so I included it anyway.


