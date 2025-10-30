Date: Thu, 30 Oct 2025 21:55:42 +0100 (CET)
Message-Id: <202510302055.59UKtgHn025217@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251030194402.1729-1-gert@...1296...>
References: <20251030194402.1729-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: clean up environment variable
 handling in verify_user_pass_script
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

Stared at the code (verified the claims about "username is already
exported"), and ran this through the t_server tests which do need a
working script/plugin env.  Works.

Your patch has been applied to the master branch.

commit 3fbba254b8645d2d1241e59f6ebd05e85ce05b52
Author: Arne Schwabe
Date:   Thu Oct 30 20:43:56 2025 +0100

     clean up environment variable handling in verify_user_pass_script

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1326
     Message-Id: <20251030194402.1729-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34069.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


