Date: Fri, 13 Oct 2023 22:18:53 +0200 (CEST)
Message-Id: <202310132018.39DKIrSD050054@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231009105714.34598-1-frank@...2641...>
References: <20231009105714.34598-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add warning for the
 --show-groups command that some groups are missing
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

Seems to make sense to avoid confusion.  Minimally tested.

Your patch has been applied to the master and release/2.6 branch.

commit a840d5099a7d1a5ceb752c481fc345f6385719df (master)
commit f41eb752368f0aa7f2a2504221df01d498f5a238 (release/2.6)
Author: Arne Schwabe
Date:   Mon Oct 9 12:57:14 2023 +0200

     Add warning for the --show-groups command that some groups are missing

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231009105714.34598-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27193.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


