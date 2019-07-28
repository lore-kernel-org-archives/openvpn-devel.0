Date: Sun, 28 Jul 2019 22:04:18 +0200 (CEST)
Message-Id: <201907282004.x6SK4Ibp082487@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1564197141-30513-1-git-send-email-selva.nair@...277...>
References: <1564197141-30513-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Correct the return value of
 cryptoapi RSA signature callbacks
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

And thanks again :-)  - even less tested, just checking that this is indeed
the only occurance of siglen/*siglen in 2.4

Your patch has been applied to the release/2.4 branch.

commit eed67cf0e7f6cbe596495c2f83aeea7c15db0d6e
Author: Selva Nair
Date:   Fri Jul 26 23:12:21 2019 -0400

     Correct the return value of cryptoapi RSA signature callbacks

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1564197141-30513-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18708.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


