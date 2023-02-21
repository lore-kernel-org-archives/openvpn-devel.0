Date: Tue, 21 Feb 2023 08:27:09 +0100 (CET)
Message-Id: <202302210727.31L7R9oh084214@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230220090601.983-1-lstipakov@...277...>
References: <20230220090601.983-1-lstipakov@...277...>
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

Patch looks reasonable.

Not tested beyond "does it compile on Linux and MinGW?".

Your patch has been applied to the master and release/2.6 branch.

commit 45a1cb2ad85a50feded10dad706132bd8a7f6133 (master)
commit 42cda5ad9e8542a48385eb2e0b7807773aa341f1 (release/2.6)
Author: Lev Stipakov
Date:   Mon Feb 20 11:06:01 2023 +0200

     Disable DCO if proxy is set via management

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20230220090601.983-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26287.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


