Date: Thu, 26 Mar 2026 17:49:42 +0100 (CET)
Message-Id: <202603261649.62QGngUe046899@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260312173144.15602-1-gert@...1296...>
References: <20260312173144.15602-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: auth_token: Clean up type
 handling in verify_auth_token and its UT
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

Arne owns that code, ACKed it, so who am I to ask :-) - that said, I
still ran the unit tests, and things still work (and the changes look
good, and improve readability)

Your patch has been applied to the master branch.

commit 5933af1620a93bb06b8c48b6f1f0eb23ed13cbf9
Author: Frank Lichtenheld
Date:   Thu Mar 12 18:31:38 2026 +0100

     auth_token: Clean up type handling in verify_auth_token and its UT

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1510
     Message-Id: <20260312173144.15602-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36079.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


