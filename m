Date: Mon, 11 Nov 2024 15:05:42 +0100 (CET)
Message-Id: <202411111405.4ABE5gRS064138@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241111094033.16073-1-gert@...1296...>
References: <20241111094033.16073-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change --reneg-bytes and
 --reneg-packets to 64 bit counters
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Stared-at-code, and gave it a quick test with "--reneg-bytes 20000" again
(on FreeBSD/amd64).  BB has also tested this on NetBSD/i386, so 32bit 
systems are also fine.  Testing with 2^65 leads to

2024-11-11 15:03:54 TLS: soft reset sec=30/30 bytes=578818/9223372036854775807 pkts=550/0

.. which should be good enough in terms of error handling, I think
(it's truncating to 2^63-1).  We can revisit this if this is a relevant
distinction for "number of packets until we need to renegotiate".

Your patch has been applied to the master branch.

commit d52ea247d9dec5262a09f3891db83b79b2ca403e
Author: Arne Schwabe
Date:   Mon Nov 11 10:40:33 2024 +0100

     Change --reneg-bytes and --reneg-packets to 64 bit counters

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241111094033.16073-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29744.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


