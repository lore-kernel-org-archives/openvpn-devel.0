Date: Mon, 4 Aug 2025 21:57:19 +0200 (CEST)
Message-Id: <202508041957.574JvJtP029312@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250804195054.21729-1-gert@...1296...>
References: <20250804195054.21729-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix build error with clang-cl
 on latest Windows SDK
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

I was sure I had seen something like this before, but maybe that was
in a PR that never made it to the list, or so... but indeed, clang-cl
is not MSVC.

Your patch has been applied to the master branch.

commit e6db5936f383542983cf38ffe6841100df4118c7
Author: Frank Lichtenheld
Date:   Mon Aug 4 21:50:48 2025 +0200

     Fix build error with clang-cl on latest Windows SDK

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250804195054.21729-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32513
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


