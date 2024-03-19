Date: Tue, 19 Mar 2024 20:35:17 +0100 (CET)
Message-Id: <202403191935.42JJZHk6051314@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240318181744.20625-1-gert@...1296...>
References: <20240318181744.20625-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Disable DCO if proxy is set via
 management
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

Straight and to the point :-)

Minimally tested with a linux t_client setup that uses DCO and proxy (but
no --managment-query-proxy).

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit fd6b8395f6cee8a61111c28f335ec25ed6db11f7 (master)
commit 462fed53c7a5f21c07dafa4910765efe56d7402d (release/2.6)
Author: Lev Stipakov
Date:   Mon Mar 18 19:17:44 2024 +0100

     Disable DCO if proxy is set via management

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240318181744.20625-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28415.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


