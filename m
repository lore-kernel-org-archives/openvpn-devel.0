From: Kristof Provost <kprovost@...2661...>
Date: Fri, 12 Aug 2022 15:41:52 +0200
Message-Id: <20220812134154.16729-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCHv2]: FreeBSD DCO support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Here's the updated version of the FreeBSD DCO patch. It should address
all remarks on the userspace side of things.

I'm still trying to reproduce the fragmentation issue. I've gotten
Gert's additional information, but I've not yet been able to act on it.
I'm fairly certain that any bug is going to be on the kernel side, so
it makes sense to me to continue these changes while I dig into that.

Best regards,
Kristof


