Date: Tue, 19 Aug 2025 12:51:32 +0200 (CEST)
Message-Id: <202508191051.57JApWsv055327@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250818164608.39836-1-frank@...2641...>
References: <20250818164608.39836-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns: fix systemd dns-updown
 script
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

In addition to the ACK from Frank I tested this on a "Debian Unstable"
system, after "apt install resolvconf" gave me a resolvconf binary
(and kicked out systemd-resolvconf).  Does not work without the patch,
with the error message reported by Ralf Hildebrandt on -users, works
with the patch.

Your patch has been applied to the master branch.

commit 72a0e6f94f16a6dcfe2b445758d42dedaba11b92
Author: Heiko Hund
Date:   Mon Aug 18 18:46:08 2025 +0200

     dns: fix systemd dns-updown script

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250818164608.39836-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32621.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


