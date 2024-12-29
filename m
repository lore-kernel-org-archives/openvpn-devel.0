Date: Sun, 29 Dec 2024 15:36:06 +0100 (CET)
Message-Id: <202412291436.4BTEa6vY013813@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241229141800.4734-1-gert@...1296...>
References: <20241229141800.4734-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: factor out getting dco
 version
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

Stared at code, had a few issues, those all got addressed.  Stared again
today (looks good).  Test compiled on Ubuntu/MinGW, claims its happy.

Your patch has been applied to the master branch.

commit 10e785f1dcacdfd5240ac18a53f2839b4d3b979c (master)
Author: Lev Stipakov
Date:   Sun Dec 29 15:17:59 2024 +0100

     dco-win: factor out getting dco version

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241229141800.4734-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30297.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


