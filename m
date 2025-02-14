Date: Fri, 14 Feb 2025 17:18:57 +0100 (CET)
Message-Id: <202502141618.51EGIvn1012202@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250214160634.6670-1-gert@...1296...>
References: <20250214160634.6670-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add android build to Github
 Actions
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

Tested on GHA, succeeds.  v3 failed due to -Werror in effect, and
some of these warnings are in #ifdef messes that need careful pruning...
(gerrit #894, work in progress).

(Why are we doing this?  To avoid commits like 3ddfe26e491... :-) )

Your patch has been applied to the master branch.

commit 6248e0af25a936728745a239bc99a390fb774a7c
Author: Arne Schwabe
Date:   Fri Feb 14 17:06:34 2025 +0100

     Add android build to Github Actions

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250214160634.6670-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30900.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


