Date: Fri, 26 Jun 2020 12:47:57 +0200 (CEST)
Message-Id: <202006261047.05QAlv0O092030@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200626101050.442-1-lstipakov@...277...>
References: <20200626101050.442-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: msvc: fix various level2
 warnings
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I have test compiled this on MacOS, FreeBSD, Linux to see if it brought
in "new warnings" - nada.  And the changes are good :-) - thanks.

Your patch has been applied to the master branch.

commit 2569902c4455554657464077950fca52516ca81e
Author: Lev Stipakov
Date:   Fri Jun 26 13:10:50 2020 +0300

     msvc: fix various level2 warnings

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200626101050.442-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/search?l=mid&q=20200626101050.442-1-lstipakov@...277...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


