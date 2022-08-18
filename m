Date: Thu, 18 Aug 2022 16:19:23 +0200 (CEST)
Message-Id: <202208181419.27IEJNgq067880@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220818080550.177771-1-a@...2181...>
References: <20220818080550.177771-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_util: fix prototype style
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Seems we need an uncrustify option to enforce this for new code
(*most* prototypes have the "all-in-one-line" approach, some follow
the "return type on previous line" as for functions).

Subject fixed, ssl_util, not ssh_util :-)

Your patch has been applied to the master branch.

commit 31346b8d8df6fb09faa56d53508205a8b74c15df
Author: Antonio Quartulli
Date:   Thu Aug 18 10:05:50 2022 +0200

     ssl_util: fix prototype style

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220818080550.177771-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24983.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


