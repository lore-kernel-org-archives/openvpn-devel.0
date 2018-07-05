Date: Thu, 5 Jul 2018 22:51:57 +0200 (CEST)
Message-Id: <201807052051.w65KpvfM056630@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180704175404.22371-1-steffan@...1856...>
References: <20180704175404.22371-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move file-related functions
 from misc.c to platform.c
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"only moving stuff around (+renaming), reason given makes sense, passes
t_client and cmocka tests"

Your patch has been applied to the master branch.

commit b7bea782f3356dbd82613dc8f38fd4ef0bc714ca
Author: Steffan Karger
Date:   Wed Jul 4 19:53:56 2018 +0200

     Move file-related functions from misc.c to platform.c

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20180704175404.22371-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17208.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


