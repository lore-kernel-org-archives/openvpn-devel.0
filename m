Date: Wed, 18 Oct 2023 15:15:44 +0200 (CEST)
Message-Id: <202310181315.39IDFiu6070053@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231009105151.34074-1-frank@...2641...>
References: <20231009105151.34074-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change type of frame.mss_fix to
 uint16_t
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

Thanks for bearing with me :-) - I'm not happy with all the changes, but
we do want to avoid needless casts, and eventually build with -Wall -Werror,
so I understand there's no other way...

Lightly tested by running an instance with --mssfix 200 and looking 
with tcpdump at the resulting SYNs (mss 133 for IPv4, mss 113 for IPv6,
with AES-256-GCM, not doing the math for you today).

Your patch has been applied to the master branch.

commit 613f4a7c9fda4dd6f0063caefab6c03d4a628667
Author: Frank Lichtenheld
Date:   Mon Oct 9 12:51:51 2023 +0200

     Change type of frame.mss_fix to uint16_t

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20231009105151.34074-1-frank@...2641...>
     URL: https://www.mail-archive.com/search?l=mid&q=20231009105151.34074-1-frank@...2641...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


