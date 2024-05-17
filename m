Date: Fri, 17 May 2024 08:44:13 +0200 (CEST)
Message-Id: <202405170644.44H6iDZl024352@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240516120434.23499-1-gert@...1296...>
References: <20240516120434.23499-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Only schedule_exit() once
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
To: reynir@...2756...
Cc: openvpn-devel@lists.sourceforge.net

Thanks :-) - this is mostly the same as v2, with a whitespace fix,
and remodeling receive_exit_message() to avoid -Werror failures 
when comping without ENABLE_MANAGEMENT ("unused variable").

Tested on GHA, buildbots and the server testbed.

Your patch has been applied to the master and release/2.6 branch.

The CC EEN functionality is not part of 2.5, so the "clients can use
this to get not dropped off" attack does not exist - and the patch
is not applicable.

commit 55bb3260c12bae33b6a8eac73cbb6972f8517411 (master)
commit 65fb67cd6c320a426567b2922c4282fb8738ba3f (release/2.6)
Author: Reynir Björnsson
Date:   Thu May 16 13:58:08 2024 +0200

     Only schedule_exit() once

     Signed-off-by: Reynir Björnsson <reynir@...2756...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240516120434.23499-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28679.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


