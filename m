Date: Mon, 14 Jul 2025 18:18:15 +0200 (CEST)
Message-Id: <202507141618.56EGIFt9049652@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250714160903.7479-1-gert@...1296...>
References: <20250714160903.7479-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: prevent search domain races
 with macOS dns-updown
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

Explanation sonds logical, Arne is using it in production and can no
longer find issues, so in it goes.  I have just briefly looked at the
script for obvious typos.

Your patch has been applied to the master branch.

commit 4848df2fb295740a7fb5a5b44f1baaeeb43307cb
Author: Heiko Hund
Date:   Mon Jul 14 18:08:21 2025 +0200

     prevent search domain races with macOS dns-updown

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250714160903.7479-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32127.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


