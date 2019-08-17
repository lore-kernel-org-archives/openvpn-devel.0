Date: Sat, 17 Aug 2019 21:05:43 +0200 (CEST)
Message-Id: <201908171905.x7HJ5hHG070129@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190805092529.9467-6-a@...2181...>
References: <20190805092529.9467-6-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: networking_sitnl.c: uncrustify
 file
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

Verified that this does, indeed, only whitespace / bracket changes, and
there are no ambiguous brackets in the parts that are touched.

It messes up your nice formatting of the backspaces for SITNL_ADDATTR(),
though :-)

Lightly tested on FreeBSD and Linux/sitnl.

Your patch has been applied to the master branch.

commit 2c45d268ca65c522fbabb7c4dab5e721296b4623
Author: Antonio Quartulli
Date:   Mon Aug 5 11:25:28 2019 +0200

     networking_sitnl.c: uncrustify file

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190805092529.9467-6-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18727.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


