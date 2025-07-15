Date: Tue, 15 Jul 2025 16:09:57 +0200 (CEST)
Message-Id: <202507151409.56FE9vsv088142@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250711100700.241668-1-frank@...2641...>
References: <20250711100700.241668-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: mac dns: do not run dns-updown
 in parallel
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

Locking good :-) - and the code looks quite reasonable.

Your patch has been applied to the master branch.

commit bc2c74291b8fce3f7a64346753d56f18cd182886
Author: Heiko Hund
Date:   Fri Jul 11 12:07:00 2025 +0200

     mac dns: do not run dns-updown in parallel

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250711100700.241668-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32108.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


