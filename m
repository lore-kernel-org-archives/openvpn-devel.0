Date: Wed, 19 Nov 2025 18:03:38 +0100 (CET)
Message-Id: <202511191703.5AJH3cop007492@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251119162934.15672-1-gert@...1296...>
References: <20251119162934.15672-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Add macos-26 and remove
 OpenSSL 1.1 builds on macOS
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

Trivial patch, and Github builds fine with it, so here we go...

Not sure how to move forward with GHA and release/2.6, though - keep 1.1,
drop 1.1 on macos and bring it back on some other platform, ...

Your patch has been applied to the master branch.

commit 9807719077b5c9886fa0e1e4f47f9669b04d09f9
Author: Frank Lichtenheld
Date:   Wed Nov 19 17:29:28 2025 +0100

     GHA: Add macos-26 and remove OpenSSL 1.1 builds on macOS

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1382
     Message-Id: <20251119162934.15672-1-gert@...1296...>
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


