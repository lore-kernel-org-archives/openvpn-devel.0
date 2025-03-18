Date: Tue, 18 Mar 2025 18:17:35 +0100 (CET)
Message-Id: <202503181717.52IHHZmf000154@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250318155320.32573-1-gert@...1296...>
References: <20250318155320.32573-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: Cleanup and simplify
 options_postprocess_verify_ce
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

I have thoroughly stared at the code, and the change definitly makes
things easier to understand and more straightforward.

I have not actively verified that all variants of invalid option combinations
are still flagged - but that's why macros, to make sure the code always
does the right thing.  Buildbot says "it compiles fine, ship it" ;-)

Your patch has been applied to the master branch.

commit db48cea4f71005bd40499a4af901b91e4dff0569
Author: Frank Lichtenheld
Date:   Tue Mar 18 16:53:11 2025 +0100

     options: Cleanup and simplify options_postprocess_verify_ce

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250318155320.32573-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31155.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


