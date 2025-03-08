Date: Sat, 8 Mar 2025 09:54:33 +0100 (CET)
Message-Id: <202503080854.5288sXLm076353@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250305134642.196598-1-frank@...2641...>
References: <20250305134642.196598-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add lwip support to
 t_server_null
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
To: samuli.seppanen@...277...
Cc: openvpn-devel@lists.sourceforge.net

Thanks for addressing my comments, and sorry for dragging my feet again.

Now we have multisockets, so, looking forward to see more challenging
t_server_null+lwip tests materialize in our build infra :-)

Haven't tested it beyond what BB already did, and that is all green.

Your patch has been applied to the master branch.

commit e4f44318b7e2e8543b84b1cbba04bd386ca6d914
Author: Samuli Seppänen
Date:   Wed Mar 5 14:46:42 2025 +0100

     Add lwip support to t_server_null

     Signed-off-by: Samuli Seppänen <samuli.seppanen@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250305134642.196598-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31019.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


