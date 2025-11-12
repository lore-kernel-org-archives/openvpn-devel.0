Date: Wed, 12 Nov 2025 10:59:47 +0100 (CET)
Message-Id: <202511120959.5AC9xlaa033862@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251111172504.7683-1-gert@...1296...>
References: <20251111172504.7683-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: msvc: fix struct initialization
 for v19 compilers
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

This makes sense - it matches how we do struct initialization elsewhere
(in networking_sitnl, a few '= {}' remain, but everything else clears
with CLEAR() or with '= { 0 }').

For a sanity check, compiled on ubuntu2404/mingw.

Your patch has been applied to the master branch.

commit 5888adc6fa86ae6ec718c76f733733c8b9fbd38b
Author: Heiko Hund
Date:   Tue Nov 11 18:24:57 2025 +0100

     msvc: fix struct initialization for v19 compilers

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1366
     Message-Id: <20251111172504.7683-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34327.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


