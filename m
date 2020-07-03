Date: Fri, 3 Jul 2020 19:02:01 +0200 (CEST)
Message-Id: <202007031702.063H21GC081133@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200703095506.28559-1-arne@...1227...>
References: <20200703095506.28559-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove did_open_context,
 defined and connection_established_flag
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

Ran a full server side test (with p2p and p2mp instances), and everything
*I* test still works (client-connect script, plugin-auth-pam with 
async-auth, *failed* plugin-auth-pam).

Your patch has been applied to the master branch.

commit c252dcc073155567c1982611ec6f065342909287
Author: Arne Schwabe
Date:   Fri Jul 3 11:55:06 2020 +0200

     Remove did_open_context, defined and connection_established_flag

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20200703095506.28559-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20200.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


