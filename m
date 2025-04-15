Date: Tue, 15 Apr 2025 20:18:05 +0200 (CEST)
Message-Id: <202504151818.53FII5KB063419@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250415155131.12458-1-gert@...1296...>
References: <20250415155131.12458-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: win: allow OpenVPN service
 account to use any command-line options
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

This is part of a series of changes to make the "non-interactive
OpenVPN service" run itself + openvpn.exec without SYSTEM privileges,
using the iservice.  This service needs more privileges than "joe random
user", especially "run config files from non-default directories", and
we can't add the service user to the "OpenVPN Administrators" group 
-> so add privileges for "the service user", as if part of that group
(config files, and command line options).

Stared hard at the code, and tested building.  Not actually tested
the resulting binaries.

Your patch has been applied to the master branch.

commit 7846055717d138e6b1130cec67412acf127e9b78
Author: Lev Stipakov
Date:   Tue Apr 15 17:51:24 2025 +0200

     win: allow OpenVPN service account to use any command-line options

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250415155131.12458-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31435.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


