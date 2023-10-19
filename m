Date: Thu, 19 Oct 2023 18:58:16 +0200 (CEST)
Message-Id: <202310191658.39JGwGau096499@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231008104022.20200-1-frank@...2641...>
References: <20231008104022.20200-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: mss/mtu: make all size
 calculations use size_t
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Not a huge fan of size_t (8 bytes instead of 4 bytes for an unsigned int,
on normal LP64 platforms), but this is all non-critical code, not stored
and not in the packet forwarding path.  So not NAKing an already-ACKed
patch again...

Smoke-tested locally and on GHA.

Your patch has been applied to the master branch.

commit 00685421aefcc294581d6e74371e744acdce6bbf
Author: Frank Lichtenheld
Date:   Sun Oct 8 12:40:22 2023 +0200

     mss/mtu: make all size calculations use size_t

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20231008104022.20200-1-frank@...2641...>
     URL: https://www.mail-archive.com/search?l=mid&q=20231008104022.20200-1-frank@...2641...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


