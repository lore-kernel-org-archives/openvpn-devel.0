Date: Fri, 5 Oct 2018 12:06:44 +0200 (CEST)
Message-Id: <201810051006.w95A6ilJ038120@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1537449154-26879-1-git-send-email-lstipakov@...277...>
References: <1537449154-26879-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refactor NCP-negotiable options
 handling
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

Your patch has been applied to the master branch and release/2.4 branch.

I would appreciate a followup-patch, though, that explains a bit better
what "do_set_ncp_options()" *does* - basically "save the initial set
of config options into a storage space from where it can be recovered
later on, to get back the original options before NCP overwrote them"
- I understand that now (after asking Steffan) but the next one to
stumble across it will ask the same question...

commit 5fa25eeb7fefdbb17ad639d72fe46f393989159f (master)
commit d2ff5164e68e5101b1da2d2d818e23eb7851dc9f (release/2.4)
Author: Lev Stipakov
Date:   Thu Sep 20 16:12:34 2018 +0300

     Refactor NCP-negotiable options handling

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1537449154-26879-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17477.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


