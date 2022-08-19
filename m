Date: Fri, 19 Aug 2022 11:07:00 +0200 (CEST)
Message-Id: <202208190907.27J9709J087381@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220819065250.222590-1-a@...2181...>
References: <20220819065250.222590-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: check for incompatible
 options
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"This one is better" :-)

Test built via GHA for MSVC, tested on Linux non-DCO / DCO client and 
DCO server.  This time, neither "non DCO" nor "DCO build" exhibited 
any surprises (as expected).

Not tested actual Windows build, but the checks match the commit
message (and the discussions on what works and what doesn't).

Your patch has been applied to the master branch.

commit 8c3b7c11d1212a6521e84a1d423abe75b974741e
Author: Antonio Quartulli
Date:   Fri Aug 19 08:52:50 2022 +0200

     dco-win: check for incompatible options

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220819065250.222590-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25014.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


