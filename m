Date: Tue, 24 Jan 2023 12:03:09 +0100 (CET)
Message-Id: <202301241103.30OB3942019309@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230124091441.397-1-lstipakov@...277...>
References: <20230124091441.397-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnmsica: remove unused
 declarations
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

Quite straightforward - "if the code is gone, we do not need prototypes
in .h files either" :-)

Not tested anything (beyond "push to mygithub" to be sure I did not
overlook a ";" or anything).

Your patch has been applied to the master and release/2.6 branch.

commit 6effd9197cdbadedc19bb5e3254a1178697513ce (master)
commit 5ddc7102b1b27b5b0f646d4c40c9d91b8e1989dd (release/2.6)
Author: Lev Stipakov
Date:   Tue Jan 24 11:14:41 2023 +0200

     openvpnmsica: remove unused declarations

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230124091441.397-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26070.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


