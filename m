Date: Tue, 15 Jul 2025 16:02:33 +0200 (CEST)
Message-Id: <202507151402.56FE2XKs087806@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250711152309.286177-1-frank@...2641...>
References: <20250711152309.286177-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: mac dns: compare servers before
 restoring backup
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

This is a very welcome feature (... I regularily bump into this, when
moving "with VPN open" from LTE to wifi, then close VPN, and the restored
DNS is no longer working - Tunnelblick today, but I hear that our script
might become useful there too ;-) ).

I have not tested this, just skimmed the code change.

Your patch has been applied to the master branch.

commit c1f44ea8a24754139beee8758c15657fe367cbb0
Author: Heiko Hund
Date:   Fri Jul 11 17:23:09 2025 +0200

     mac dns: compare servers before restoring backup

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250711152309.286177-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32110.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


