Date: Tue, 19 Mar 2024 18:20:11 +0100 (CET)
Message-Id: <202403191720.42JHKBu7042208@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240319154456.2967716-1-frank@...2641...>
References: <20240319154456.2967716-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: general update March 2024
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

Tested on my GH repo.  Works (except as noted for ubuntu/ASAN).

Your patch has been applied to the master and release/2.6 branch.

(Two merge conflicts, one related to "there is no checkout for
mingw-unittests in 2.6 (yet)" and one to "no mbedtls3 tests")

commit 36ff5cdb45183c13b0cb084b288b237ad55345cd (master)
commit 5afc89ab747cfc8ad6b391f17dca61661e9b9df3 (release/2.6)
Author: Frank Lichtenheld
Date:   Tue Mar 19 16:44:56 2024 +0100

     GHA: general update March 2024

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240319154456.2967716-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28422.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


