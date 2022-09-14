Date: Wed, 14 Sep 2022 10:22:02 +0200 (CEST)
Message-Id: <202209140822.28E8M2PC005633@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220628080814.745-1-frank@...2641...>
References: <20220628080814.745-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: doc: cleanup for --data-ciphers
 and related
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

I have not proofread these changes - Arne is the expert, and has ACKed.

(I have looked at the actual code changes, and it's only text and
comments, so no further testing done)

There was a comment about removal of some still-valid sections for 2.4
clients, and missing P2P NCP updates... -> so pointing this out here for
future work.

Your patch has been applied to the master branch.

commit bbcc17a7350dae81b43de1d84c14a8d4739b5b1a
Author: Frank Lichtenheld
Date:   Tue Jun 28 10:08:14 2022 +0200

     doc: cleanup for --data-ciphers and related

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220628080814.745-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24575.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


