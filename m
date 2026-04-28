Date: Tue, 28 Apr 2026 15:01:41 +0200 (CEST)
Message-Id: <202604281301.63SD1fK2007008@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260427174757.4075-1-gert@...1296...>
References: <20260427174757.4075-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure: Remove
 --enable-strict
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

"Because it makes sense".  Only affects configure -> Makefile flag setting.

Your patch has been applied to the master and release/2.7 branch
(keep build environments aligned if possible).

commit ac62337dd5338ab5fe066f33a09f258dd04d0585 (master)
commit 352d234bee0d88e8a03d84fc3d9c1cd773c19c43 (release/2.7)
Author: Frank Lichtenheld
Date:   Mon Apr 27 19:47:50 2026 +0200

     configure: Remove --enable-strict

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1590
     Message-Id: <20260427174757.4075-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36752.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


