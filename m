Date: Sat, 3 Jun 2023 10:31:24 +0200 (CEST)
Message-Id: <202306030831.3538VOj6057706@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230601102506.4068185-1-arne@...1227...>
References: <20230601102506.4068185-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove key_type argument from
 generate_key_random
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

Acked-by: Gert Doering <gert@...1296...>

"git show -w" confirms that this is really just indent changes plus
taking away the "kt != NULL" path - and since this is called from just
a single place, with NULL, just removing the second argument is indeed
a good strategy.

Tested with a t_client run on FreeBSD (succeeds).

Your patch has been applied to the master branch.

commit 68e45eda7b75b412d7e2568adb2e07a94d3cf594
Author: Arne Schwabe
Date:   Thu Jun 1 12:25:06 2023 +0200

     Remove key_type argument from generate_key_random

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230601102506.4068185-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26737.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


