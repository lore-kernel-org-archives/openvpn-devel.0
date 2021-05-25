Date: Tue, 25 May 2021 22:08:25 +0200 (CEST)
Message-Id: <202105252008.14PK8P9V041064@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210505231255.1880-1-a@...2181...>
References: <20210505231255.1880-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: forward: get rid of useless
 declarations for actually static functions
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
To: Antonio Quartulli <antonio@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Stared at code ("git diff color-moved=zebra"), ran local linux tests.  Did
not expect issues, had none :-)

Your patch has been applied to the master branch.

commit b7701fc5ce3a2d49bca890859541bb4b8dff0aec
Author: Antonio Quartulli
Date:   Thu May 6 01:12:55 2021 +0200

     forward: get rid of useless declarations for actually static functions

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20210505231255.1880-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22315.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


