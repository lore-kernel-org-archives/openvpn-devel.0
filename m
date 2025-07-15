Date: Tue, 15 Jul 2025 13:22:39 +0200 (CEST)
Message-Id: <202507151122.56FBMdBl082928@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250711100853.242102-1-frank@...2641...>
References: <20250711100853.242102-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: move macOS dns-updown common
 code into functions
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

Looks reasonable, and Arne & Heiko confirm that it works.  So I've not
done any testing, just skimmed over the change to see what it touches.

Your patch has been applied to the master branch.

commit 022cd3e7fe19e013709ecd3104aaf93b6e6abe89
Author: Heiko Hund
Date:   Fri Jul 11 12:08:53 2025 +0200

     move macOS dns-updown common code into functions

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250711100853.242102-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32105.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


