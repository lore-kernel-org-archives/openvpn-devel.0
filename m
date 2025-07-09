Date: Wed, 9 Jul 2025 09:46:13 +0200 (CEST)
Message-Id: <202507090746.5697kDBv019386@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250708185210.30421-1-gert@...1296...>
References: <20250708185210.30421-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns: do not run updown scripts
 with lwipovpn
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

Lightly tested on a FreeBSD build with lwipovpn, and stared a bit at
the code.

Your patch has been applied to the master branch.

commit 4dc57d923d23bdc73c7c24a9851c9137f2097d8c
Author: Heiko Hund
Date:   Tue Jul 8 20:52:04 2025 +0200

     dns: do not run updown scripts with lwipovpn

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250708185210.30421-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32069.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


