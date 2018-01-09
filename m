Date: Tue, 9 Jan 2018 15:31:40 +0100 (CET)
Message-Id: <201801091431.w09EVeSP070386@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
References: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: travis: use clang's
 -fsanitize=address to catch more bugs
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

ACK, makes sense.

Your patch has been applied to the master branch.

commit 7b11915ddfe97d8c28f998db54c40384a4eafb93
Author: Steffan Karger
Date:   Fri Dec 29 10:47:37 2017 +0100

     travis: use clang's -fsanitize=address to catch more bugs

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16102.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


