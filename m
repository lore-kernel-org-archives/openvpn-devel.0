Date: Tue, 13 Aug 2024 08:55:03 +0200 (CEST)
Message-Id: <202408130655.47D6t35f083163@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240809192257.24208-1-gert@...1296...>
References: <20240809192257.24208-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use a more robust way to get
 dco-win version
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

Stared at code here and on the driver side, looks very reasonable and
also backward-compatible in both directions.

Not actually tested, just test compiled via GHA.

Your patch has been applied to the master and release/2.6 branch
(long-term compat).

commit e5a8ea36a0228c30cdbee8791d44a1f0fbaffa9f (master)
commit 41fe48585ebd005e65d191452c2860ab9c089c55 (release/2.6)
Author: Lev Stipakov
Date:   Fri Aug 9 21:22:56 2024 +0200

     Use a more robust way to get dco-win version

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240809192257.24208-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29009.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


