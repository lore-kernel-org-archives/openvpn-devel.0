From: Kristof Provost <kprovost@...2661...>
Date: Mon,  5 Dec 2022 17:40:59 +0100
Message-Id: <20221205164103.9190-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH]: FreeBSD DCO updates
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

This patch series is version two of the "Read DCO traffic stats from the
kernel" patch. This version should build for FreeBSD, Linux and Windows
now (although I've not tested Windows builds, because I lack Windows
machines).

It also adds the ability for DCO drivers to include counters in the peer
deletion notification.

It also includes extensions to read the reason a peer went away from the
kernel (which the FreeBSD kernel started including from
https://cgit.freebsd.org/src/commit/?id=da69782bf06645f38852a8b23afc965fc30d0e08)
Happily this will still work even when the kernel doesn't include that
data.

Finally there's a small cleanup patch to remove reading packets through
the ioctl interface.

If anyone wants to play around with the peer counters on FreeBSD you'll
also want these patches for FreeBSD:

 * https://reviews.freebsd.org/D37602 (not related, but required to have
   the next patches apply cleanly)
 * https://reviews.freebsd.org/D37603
 * https://reviews.freebsd.org/D37604
 * https://reviews.freebsd.org/D37605 (not related, but required to have
   the next one apply cleanly)
 * https://reviews.freebsd.org/D37606

Best regards,
Kristof



