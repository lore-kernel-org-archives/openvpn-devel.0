Date: Tue, 28 Jun 2022 14:21:20 +0200 (CEST)
Message-Id: <202206281221.25SCLKJa028140@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220513093740.1091639-1-heiko@...2662...>
References: <20220513093740.1091639-1-heiko@...2662...>
Subject: [Openvpn-devel] [PATCH applied] Re: signal --dns support in peer
 info
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

We had the ACK for this since a long time, but then had discussions on
"is this what we really want", leading to the "DNS foreign option" patch
committed just now - so after checking with Arne, this is now making sense
for the server side intent ("if IV_PROTO contains the DNS bit, the server
can stop pushing dhcp-options, because --dns will do all the job, and 
more, even for old-style platforms").

The patch itself is trivially correct "the bit is unique, and it is added" :-)

Your patch has been applied to the master branch.

commit 1f7f7d2a8943b5e33f86f208cce8f5d10c91a8f4
Author: Heiko Hund
Date:   Fri May 13 11:37:40 2022 +0200

     signal --dns support in peer info

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20220513093740.1091639-1-heiko@...2662...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24350.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


