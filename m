Date: Wed, 19 Mar 2025 18:47:42 +0100 (CET)
Message-Id: <202503191747.52JHlg0M050559@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250319142234.25046-1-gert@...1296...>
References: <20250319142234.25046-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Post tchar.h removal cleanup
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

"Clean up the rest" - it looks a bit confusing at first, why the
UNICODE stuff is removed from service.h - but that's just because
"everything!" includes ../tapctl/basic.h, including service.h

Your patch has been applied to the master branch.

commit 6bb20fa8bebc29d8b3103662ffba4904d03e852d
Author: Frank Lichtenheld
Date:   Wed Mar 19 15:22:24 2025 +0100

     Post tchar.h removal cleanup

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250319142234.25046-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31172.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


