Date: Mon, 13 Feb 2023 19:52:32 +0100 (CET)
Message-Id: <202302131852.31DIqWgF002151@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230208005925.393200-1-selva.nair@...277...>
References: <20230208005925.393200-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Build unit tests in mingw
 Windows build
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

Tested on Linux (native), Linux / MinGW, AIX.  Native platforms still
run the tests (and succeed / fail as before).

On MinGW, if there is no cross-built libcmocka, this patch will not change
anything.  If there is, it tries to build the tests, which fails for me,
but this seems to be a local install issue with cross-built cmocka and
32/64 bit compilers.  It's not a problem introduced by this patch (the
difference here is "do not *run* the resulting binaries") so I've decided
to move forward with merging it.

Your patch has been applied to the master and release/2.6 branch.

commit e3ad1fc4230fb3a08b484e76ce0a31f2479d3c8f (master)
commit a6d7e8843154bfca8b98a9eb11a11b320a03db36 (release/2.6)
Author: Selva Nair
Date:   Tue Feb 7 19:59:25 2023 -0500

     Build unit tests in mingw Windows build

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230208005925.393200-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26188.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


