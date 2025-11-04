Date: Tue, 4 Nov 2025 18:22:46 +0100 (CET)
Message-Id: <202511041722.5A4HMkKu057639@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251104104448.98093-1-frank@...2641...>
References: <20251104104448.98093-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: init: make some functions static
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Fairly straightforward, a bunch of statics, one moved function so no
prototype is needed anymore ("git show --color-moved"), and all BBs
are happy...

Your patch has been applied to the master branch.

commit 8545a3db4e83d0294d823ad6489a3040de10984e
Author: Antonio Quartulli
Date:   Tue Nov 4 11:44:48 2025 +0100

     init: make some functions static

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1346
     Message-Id: <20251104104448.98093-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34193.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


