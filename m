Date: Sat, 4 Oct 2025 17:36:09 +0200 (CEST)
Message-Id: <202510041536.594Fa97Q087602@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251004061545.7277-1-gert@...1296...>
References: <20251004061545.7277-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: crypto_epoch: Clean up type
 handling in ovpn_expand_label()
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

Looks reasonable.  Buildbot states that all tests (including t_client runs)
still pass. ACK from Max.  (After the last addition of ASSERT() I've become
a bit more careful and ran it on the server testbed which has epoch tests,
and that also works fine).

Your patch has been applied to the master branch.

commit cb8155711a18e2c6b4e437ab224a9eb5961dfeda
Author: Frank Lichtenheld
Date:   Sat Oct 4 08:15:38 2025 +0200

     crypto_epoch: Clean up type handling in ovpn_expand_label()

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: MaxF <max@...2606...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1218
     Message-Id: <20251004061545.7277-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59242119/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


