Date: Wed, 2 Apr 2025 16:33:04 +0200 (CEST)
Message-Id: <202504021433.532EX44k061390@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250402113016.14980-1-gert@...1296...>
References: <20250402113016.14980-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: Ensure correct
 OVERLAPPED scope
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

I have not tested this beyond "does it make mingw happy" (it does),
but stare-at-code and comparison to the master commit (f60a493) makes
clear that this is fine.

Your patch has been applied to the release/2.6 branch.

commit 9c888671832041febf9284ca66fb163ab9d54a93
Author: Lev Stipakov
Date:   Wed Apr 2 13:30:11 2025 +0200

     dco-win: Ensure correct OVERLAPPED scope

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250402113016.14980-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31316.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


