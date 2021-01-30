Date: Sat, 30 Jan 2021 19:54:47 +0100 (CET)
Message-Id: <202101301854.10UIslPu006064@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210125125628.30364-2-arne@...1227...>
References: <20210125125628.30364-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change pull request timeout use
 a timeout rather than a number
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

Your patch has been applied to the master branch.

Only very lightly tested.

Observation: it introduces "*session" and "*ks" to send_push_request() 
which might be needed by later patches on, but are not used by code 
in this patch yet.

commit 413580b6a41d7eefb35438701fc79a63e0344ced
Author: Arne Schwabe
Date:   Mon Jan 25 13:56:18 2021 +0100

     Change pull request timeout use a timeout rather than a number

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20210125125628.30364-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21490.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


