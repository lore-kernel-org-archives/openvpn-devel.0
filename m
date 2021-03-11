Date: Thu, 11 Mar 2021 18:23:10 +0100 (CET)
Message-Id: <202103111723.12BHNAYE012156@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210310124808.14741-1-gert@...1296...>
References: <20210310124808.14741-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Require at least 100MB of
 mlock()-able memory if --mlock is used.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks, Selva.

v3 has actually been buildbot-tested on all the platforms (I tested
v2 after the ACK, and it failed OpenSolaris, so I grumbled and adjusted
the #ifdef's...).  It has been "tested for real" on Linux, which has
"prlimit" to tell you the currently-active limits for *other* processes 
- haven't found something equivalent on the BSDs, so only "it will
report the right value(s) and not explode"-tested (+ buildbot compile).

Patch has been applied to the master branch.

commit b0bff5590152fbcc5b4d47c18817838fd00c58c3
Author: Gert Doering
Date:   Wed Mar 10 13:48:08 2021 +0100

     Require at least 100MB of mlock()-able memory if --mlock is used.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20210310124808.14741-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21657.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


