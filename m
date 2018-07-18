Date: Wed, 18 Jul 2018 19:51:19 +0200 (CEST)
Message-Id: <201807181751.w6IHpJ8d001044@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1531924073-29243-4-git-send-email-steffan.karger@...1435...>
References: <1531924073-29243-4-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove unneeded newline in
 debug message in reliable.c
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
To: Gert van Dijk <gert.vandijk@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"obvious fix", but if you're used to debugging with printf(), these
newlines slip in... :-) - thanks for fixing.

Your patch has been applied to the master branch.

commit 3e5561d34099f28a759865efff0523005116b6a1
Author: Gert van Dijk
Date:   Wed Jul 18 16:27:53 2018 +0200

     Remove unneeded newline in debug message in reliable.c

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1531924073-29243-4-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17262.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


