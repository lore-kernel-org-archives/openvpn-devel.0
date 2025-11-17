From: Gert Doering <gert@...1296...>
Date: Mon, 17 Nov 2025 18:28:57 +0100
Message-ID: <20251117173843.10091-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Patches in Master that were privately reviewed
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
To: openvpn-devel@lists.sourceforge.net

Hi,

as you have seen, there was a 2.7_rc2 release and a 2.6.16 release
today.  Both have seen fixes that were considered CVE worthy, and we
do review and ACK these fixes privately, for a coordinated release.

I'm sending the "master" patches in this patch series.  Release/2.6
has only the "memcmp()" patch.

We do not think that the "reject mismatched address family" patch can
be used to do something really nasty (like "crash openvpn" or "get
access to memory with interesting secrets in it") - but it is a buffer
over-read, and you never know, so fix it, and tag it properly.

The "memcmp check" patch can be used for state exhaustion attacks
against an OpenVPN server (read: send legitimately-looking packets
from random source addresses, each opening a new TLS session, eating
CPU and memory).  Technically, this has always been possible, "since
ever", and this check was introduced in 2.6.0 to do a syn-cookie-like
source IP verification (do not add state in the first packet, only
add state if the proper cookie comes back later) - which did not work
the way it was intended.  But for whatever reasons, reflection attacks
using OpenVPN and state exhaustion attacks have fallen out of favour,
so nobody ever noticed...  but if you run a server, you want to update.


The commits in tree are:

commit 18c483dd6031d86eb393527855734e8cd62fea19
Author: Arne Schwabe <arne@...1227...>
Date:   Mon Oct 27 10:05:55 2025 +0100

    Fix memcmp check for the hmac verification in the 3way handshake being inverted
    CVE: 2025-13086

commit f1b851dae60eb1e277315dfe6265e3a58660b16a
Author: Mikhail Khachaiants <mkhachaiants@...277...>
Date:   Sat Oct 18 11:42:31 2025 +0300

    socket: reject mismatched address family in get_addr_generic
    CVE: 2025-12106

(This mail is created with git-send-email --compose, which alas does not
easily permit PGP signing.  It's still me, and you can verify the commits
in the repo - and the changes are straightforward enough.  The v2.7_rc2
and 2.6.16 commits & tags *are* signed.)

gert



