Date: Wed, 26 Nov 2025 12:20:28 +0100 (CET)
Message-Id: <202511261120.5AQBKSN8026591@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251124170055.16034-1-gert@...1296...>
References: <20251124170055.16034-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: iservice: rename one_glyph to
 glyph_size
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

This is actually not a bugfix but a readability improvement, and as such,
very welcome :-) - now everything in that function that deals with bytes
is "_size", and everything that deals in wide characters is "_len".

Build tested on Ubuntu/MinGW ("just to be sure I haven't overlooked anything").

Your patch has been applied to the master branch.

commit dd1524c0bd7c7358b39da2fb4911076054736e0a
Author: Heiko Hund
Date:   Mon Nov 24 18:00:50 2025 +0100

     iservice: rename one_glyph to glyph_size

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1398
     Message-Id: <20251124170055.16034-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34642.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


