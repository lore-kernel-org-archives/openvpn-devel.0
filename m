Date: Sat, 4 Apr 2026 16:04:28 +0200 (CEST)
Message-Id: <202604041404.634E4SSd068071@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260401102247.21915-1-gert@...1296...>
References: <20260401102247.21915-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Rename key* to privkey* in
 cert_data.h
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

This is an easy one even I can understand ;-)  (preparing for a future
UT extention that would have a name collision).

The patch looks much smaller with "-w"... thanks, clang-format.

Your patch has been applied to the master and release/2.7 branch.

commit 579046470f2e8dc773144a63b1ca800e55dc64e9 (master)
commit 4d16f2a604d6d0fb7e87a655361fdcd78b10073e (release/2.7)
Author: Arne Schwabe
Date:   Wed Apr 1 12:22:42 2026 +0200

     Rename key* to privkey* in cert_data.h

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1597
     Message-Id: <20260401102247.21915-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36401.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


