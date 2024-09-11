Date: Wed, 11 Sep 2024 14:07:19 +0200 (CEST)
Message-Id: <202409111207.48BC7JFt064144@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240910170005.5586-1-gert@...1296...>
References: <20240910170005.5586-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: generate_auth_token: simplify
 code
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Has an ACK from the owner of the code :-) - plus full test with the
server instance that does auth-tokens (including expiry + regen) and
a bit of stare-at-the-code.

Your patch has been applied to the master branch.

commit 3c77d328911bab5169d6981fbef34e8398c5b7b7
Author: Frank Lichtenheld
Date:   Tue Sep 10 19:00:05 2024 +0200

     generate_auth_token: simplify code

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240910170005.5586-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29178.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


