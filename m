Date: Thu, 23 Oct 2025 17:47:10 +0200 (CEST)
Message-Id: <202510231547.59NFlAGp066459@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251023111138.25245-1-gert@...1296...>
References: <20251023111138.25245-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not try to use the
 encrypt-then-mac ciphers from OpenSSL 3.6.0
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Change and explanation make sense, and BB/GH confirms that macOS is now
happy again (this isn't a "macOS" problem but the GHA workers on macOS
discovered it first).

Your patch has been applied to the master branch.

commit a69d9b66502f13354750d8146cd038cc7a26a0bd
Author: Arne Schwabe
Date:   Thu Oct 23 13:11:33 2025 +0200

     Do not try to use the encrypt-then-mac ciphers from OpenSSL 3.6.0

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1294
     Message-Id: <20251023111138.25245-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33846.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


