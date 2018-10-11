Date: Thu, 11 Oct 2018 20:08:12 +0200 (CEST)
Message-Id: <201810111808.w9BI8CKa006220@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1539258702-15427-1-git-send-email-lstipakov@...277...>
References: <1539258702-15427-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: options.c: fix broken unary
 minus usage
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for bearing with me :-) - code looks correct, passes all t_client
tests (which should trigger the increment/decrement code paths).  Bonus
points for *removing* a cast ;-))

Your patch has been applied to the master and release/2.4 branch (bugfix).

commit ed31cf2ab718d879615dea81e6a17d26537ab43a (master)
commit 62eb234c810533c7ea13d8a9faa28eebe07f2e82 (release/2.4)
Author: Lev Stipakov
Date:   Thu Oct 11 14:51:42 2018 +0300

     options.c: fix broken unary minus usage

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1539258702-15427-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17739.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


