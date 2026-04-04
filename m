Date: Sat, 4 Apr 2026 22:18:14 +0200 (CEST)
Message-Id: <202604042018.634KIEYx074705@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260404155726.7696-1-gert@...1296...>
References: <20260404155726.7696-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not access internals of
 ASN1_INTEGER to print hex of serial
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

There was a bit of confusion with the buildbot fails on freebsd 13 -
which got fixed by rebasing to current master, some const/non-const
openssl 4.0 work fallout.  I did not investigate further as the rebased
is exactly identical to the v5, just no build fails anymore.

The patch itself passes the corresponding unit test, so it won't
crash and won't change user-visible behaviour.  Plus, ACK from Frank.

Your patch has been applied to the master and release/2.7 branch.

commit bab0e32e6f9de8ee1433abcaafc4719f170b2f47 (master)
commit c3dd2ab23e7e11426d7eedbcdbd97b4fa05bee88 (release/2.7)
Author: Arne Schwabe
Date:   Sat Apr 4 17:57:19 2026 +0200

     Do not access internals of ASN1_INTEGER to print hex of serial

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1589
     Message-Id: <20260404155726.7696-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36459.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


