Date: Wed, 22 Apr 2026 09:05:10 +0200 (CEST)
Message-Id: <202604220705.63M75AvM035005@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260422055636.20691-1-gert@...1296...>
References: <20260422055636.20691-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-linux: enforce ifindex only
 for DEL_PEER notifications
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Tested this (on Ubuntu 20.04 with old-DCO) and I can confirm that 
management "status" is now back to working.  Comparison to 2.7/master
also clarified what went wrong in the previous backport commit.

Didn't test this on other platforms as only dco_linux.c is changed
(BB did, of course).

Your patch has been applied to the release/2.6 branch.

commit adece45628f78aa8f1f997850095bc9a57caefbe (release/2.6)
Author: Ralf Lici
Date:   Wed Apr 22 07:56:30 2026 +0200

     dco-linux: enforce ifindex only for DEL_PEER notifications

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1636
     Message-Id: <20260422055636.20691-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36721.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


