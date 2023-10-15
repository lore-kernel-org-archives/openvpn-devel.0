Date: Sun, 15 Oct 2023 16:36:00 +0200 (CEST)
Message-Id: <202310151436.39FEa08c092762@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231008112755.23568-1-frank@...2641...>
References: <20231008112755.23568-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: get driver version
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

This is a useful addition (as we discussed at the hackathon), for
future feature enhancements that require a minimum version of the
DCO-WIN driver ("new driver supports old+new openvpn.exe by means of
v1 and v2 IOCTLs, but new openvpn.exe has no compat layer for old
driver").

Uncrustify complains about ovpn_dco_win.h on commit, because the
exclusion list is not applied in our "commit hook" - but this is
known and accepted for this file ("import from other project").

I have compile-tested this on Ubuntu/MinGW and ran through GHA, and
also done a quick stare-at-code ("does it handle errors, like 'no driver'
or 'driver too old for this IOCTL'?") and this all looks good.

Your patch has been applied to the master and release/2.6 branch.

commit e8e5f8a4c4f8e01dc7317ac87a85d3204882d6bf (master)
commit c54e1b226e9d6709cdc2b243e6a961a6cd47c7c6 (release/2.6)
Author: Lev Stipakov
Date:   Sun Oct 8 13:27:55 2023 +0200

     dco-win: get driver version

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20231008112755.23568-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27174.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


