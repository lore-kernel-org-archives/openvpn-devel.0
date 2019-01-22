Date: Tue, 22 Jan 2019 17:05:50 +0100 (CET)
Message-Id: <201901221605.x0MG5oqj045340@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1548172232-11268-1-git-send-email-selva.nair@...277...>
References: <1548172232-11268-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: White-list pull-filter and
 script-security in interactive service
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"Because it makes sense and moves toward making OpenVPN on Windows more
robust (pull-filter route-method) and secure (script-security)".  Code
change is simple enough :-)

Your patch has been applied to the master and release/2.4 branch
(security enhancement).

commit 0d94d433438f239ff7cf0749f765a503c698f5e8 (master)
commit b8190ecb33f8949f1b881c1cd240e8c1ea4fe144 (release/2.4)
Author: Selva Nair
Date:   Tue Jan 22 10:50:32 2019 -0500

     White-list pull-filter and script-security in interactive service

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1548172232-11268-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18154.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


