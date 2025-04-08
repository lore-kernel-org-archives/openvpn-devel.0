Date: Tue, 8 Apr 2025 13:30:08 +0200 (CEST)
Message-Id: <202504081130.538BU8Mx043020@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250402153337.5262-1-gert@...1296...>
References: <20250402153337.5262-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use
 SSL_get0_peer_signature_name instead of SSL_get_peer_signature_nid
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

Good change.  Use the 3.5 function if available, and move all the
#ifdef mumbo to the compat header.  Not explicitly tested, just
stared a bit at the code & relied on the buildbot tests.

Your patch has been applied to the master branch.

commit b60d2bb98c77d5836b7e3e2d21eeeb17aa55d3f2
Author: Arne Schwabe
Date:   Wed Apr 2 17:33:28 2025 +0200

     Use SSL_get0_peer_signature_name instead of SSL_get_peer_signature_nid

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Message-Id: <20250402153337.5262-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31336.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


