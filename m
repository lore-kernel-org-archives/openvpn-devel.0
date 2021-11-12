Date: Fri, 12 Nov 2021 14:20:44 +0100 (CET)
Message-Id: <202111121320.1ACDKil9091842@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211112130231.3799480-1-arne@...1227...>
References: <20211112130231.3799480-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow loading of non default
 providers
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I tool Selva's patch, and added my own for the change v5->v6 (which
is really just moving the #ifdef to the other side of the block,
so the options.c code is always compiled in).

Tested on 1.1 ("unsurprisingly, no change") and 3.0 builds ("my test 
cases against 2.3 servers with BF-CBC are working again").

Code change also looks reasonable.  In it goes!

A few minor whitespace fixes ("type* var" vs. "type *var").

Your patch has been applied to the master branch.

commit 8a636779d9a28dc8040448483dc4a8af05d5c37f
Author: Arne Schwabe
Date:   Fri Nov 12 14:02:31 2021 +0100

     Allow loading of non default providers

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211112130231.3799480-1-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20211112130231.3799480-1-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


