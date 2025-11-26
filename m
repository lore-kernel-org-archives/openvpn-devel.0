Date: Wed, 26 Nov 2025 12:05:54 +0100 (CET)
Message-Id: <202511261105.5AQB5sBM025479@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251126104315.4776-1-gert@...1296...>
References: <20251126104315.4776-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: iservice: return correct size
 when domains are truncated
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

This does what it says - return the correct overall size (either 0, or
"what we have so far + extra 0 byte, counting the latter as wchar = glyph").

Your patch has been applied to the master branch.

commit aeda359efaeae3d2d77f7a89223fa1b5bcac2c90
Author: Heiko Hund
Date:   Wed Nov 26 11:43:07 2025 +0100

     iservice: return correct size when domains are truncated

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1391
     Message-Id: <20251126104315.4776-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34680.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


