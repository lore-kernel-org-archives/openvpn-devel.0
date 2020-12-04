Date: Fri, 4 Dec 2020 11:46:57 +0100 (CET)
Message-Id: <202012041046.0B4Akvwn048411@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201203182230.33552-1-steffan@...1856...>
References: <20201203182230.33552-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: tls-crypt-v2: fix server memory
 leak
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

I have not done much testing, and not even stared much at the
code.  But it's your code and Antonio has a keen eye :-)

Your patch has been applied to the master and release/2.5 branch.

commit fb169c3b8fdfa9792c0eee8441956f062dfd7982 (master)
commit 06e769552481729ddae28ee46b30f2dc8ca77509 (release/2.5)
Author: Steffan Karger
Date:   Thu Dec 3 19:22:30 2020 +0100

     tls-crypt-v2: fix server memory leak

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20201203182230.33552-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21310.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


