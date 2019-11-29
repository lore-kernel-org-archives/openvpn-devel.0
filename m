Date: Fri, 29 Nov 2019 11:50:50 +0100 (CET)
Message-Id: <201911291050.xATAooDJ003464@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191129104335.4518-1-lstipakov@...277...>
References: <20191129104335.4518-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: travis: bump clang version
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

This looks reasonable - we want to see warnings-as-errors with recent
compilers.  Older compilers may warn all they want, but we can not 
consider it an *error* or spend time on fixing them (in ugly ways).

Your patch has been applied to the master branch.

commit 4a2c8dab5dffff7a09d794d9b2afc4bf710db2b9
Author: Lev Stipakov
Date:   Fri Nov 29 12:43:35 2019 +0200

     travis: bump clang version

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20191129104335.4518-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19203.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


