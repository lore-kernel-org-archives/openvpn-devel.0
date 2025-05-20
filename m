Date: Tue, 20 May 2025 14:08:11 +0200 (CEST)
Message-Id: <202505201208.54KC8BUb034696@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250520105119.10431-1-gert@...1296...>
References: <20250520105119.10431-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: win: match search domains when
 creating exclude rules
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

Looks generally reasonable.  Lev has tested this thoroughly and confirms
it works :-) - there is a bug in string length calculation in here
(wide/normal string) so the code as it stands does not work correctly
for multiple domains.  To be fixed in the next patch (#1028).

I have only compile tested this (ubuntu+mingw).

Your patch has been applied to the master branch.

commit dcc2385c033ac5df98968aad6899ddc8c4d2240e
Author: Heiko Hund
Date:   Tue May 20 12:51:12 2025 +0200

     win: match search domains when creating exclude rules

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20250520105119.10431-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31731.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


