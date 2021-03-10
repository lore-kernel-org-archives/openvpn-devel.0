Date: Wed, 10 Mar 2021 12:48:15 +0100 (CET)
Message-Id: <202103101148.12ABmF3I079482@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210310102823.29508-1-arne@...1227...>
References: <20210310102823.29508-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change parameter of
 send_auth_pending_messages from context to tls_multi
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

Reviewed (did that for v3), only change in v4 is the push.h prototype
fix.  Taking Lev's ACK from v1 or v2 in as well.

Stared-at-code, tested client-and-server, all good!

Your patch has been applied to the master branch.

commit d8ed59320e619eb5c9e5ba2acbac1a4fecae36b1
Author: Arne Schwabe
Date:   Wed Mar 10 11:28:23 2021 +0100

     Change parameter of send_auth_pending_messages from context to tls_multi

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210310102823.29508-1-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20210310102823.29508-1-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


