Date: Sat, 18 Oct 2025 20:03:35 +0200 (CEST)
Message-Id: <202510181803.59II3Z22035059@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251018170237.21928-1-gert@...1296...>
References: <20251018170237.21928-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: push_util: Fix conversion
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Smoke tested ("does it compile and pass client side tests").  Still no
real testbed for PUSH_UPDATE, alas.  Marco says it's fine, and it's his
code, and BB agrees, forward we move ;-)

Application of the patch needed a bit of pressure because quite a bit
of context has changed in the meantime (commit 5e4c9a69eaf) - but only
context, no affected code itself.

Your patch has been applied to the master branch.

commit a8b8e41c7906c895ba6c88aa748e6dfa3946aff5
Author: Frank Lichtenheld
Date:   Sat Oct 18 19:02:32 2025 +0200

     push_util: Fix conversion warnings

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: mrbff <marco@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1283
     Message-Id: <20251018170237.21928-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59248341/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


