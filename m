Date: Sun, 2 Feb 2025 10:48:41 +0100 (CET)
Message-Id: <202502020948.5129mf0u035861@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250201121102.27395-1-gert@...1296...>
References: <20250201121102.27395-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: multi.c: add iroutes after dco
 peer is added
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

Tested with my FreeBSD/DCO and Linux/DCO testbeds, where some of the
server instances are installing a number of iroutes, precisely to test
correct functioning :-) - and all seems to still work as it should.

Your patch has been applied to the master branch.

commit e6b2df0ce618f1fe1f28bbd287b3580147ce34b4
Author: Lev Stipakov
Date:   Sat Feb 1 13:11:02 2025 +0100

     multi.c: add iroutes after dco peer is added

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250201121102.27395-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30780.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


