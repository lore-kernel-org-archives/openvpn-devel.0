Date: Thu, 1 Dec 2022 16:19:01 +0100 (CET)
Message-Id: <202212011519.2B1FJ1Sj031118@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221201125902.400-1-lstipakov@...277...>
References: <20221201125902.400-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: disable dco on Windows if
 --remote is not defined
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"DCO WIN wants to do outgoing stuff", no server, no no-remote - so yes,
makes sense.

Your patch has been applied to the master branch.

commit fd1c460ccfa38ca03e40e05524e2627917c58647
Author: Lev Stipakov
Date:   Thu Dec 1 14:59:02 2022 +0200

     dco: disable dco on Windows if --remote is not defined

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221201125902.400-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25604.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


