Date: Wed, 10 Oct 2018 20:39:35 +0200 (CEST)
Message-Id: <201810101839.w9AIdZKP063080@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181010142527.27025-1-arne@...1227...>
References: <20181010142527.27025-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove MANAGMENT_EXTERNAL_KEY,
 MANAGMENT_IN_EXTRA, ENABLE_CLIENT_CR
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

Your patch has been applied to the master branch.

Cursory review, looks all reasonable, and passes my local t_client tests
plus a windows build ("just to be safe").

Spurious extra whitespace fixed on the go.

There is one thing that Selva commented on on the first round of this
patch in December 2015 which you might want to look at - while 
ENABLE_CLIENT_CR depended on ENABLE_MANAGEMENT, there's a code path in
misc.c which is useful also on "non management enabled" clients, in
get_user_pass_cr() - "Get username/password from standard input?"
now depends on #ifdef ENABLE_MANAGEMENT, which is what we *had*, but
might not be what we *want*...  as far as I can see, these two blocks
should not be dependent on management functions (didn't test, though).

commit 66b9409bb25402c1bfcd66359332792cf57d0825 (master)
Author: Arne Schwabe
Date:   Wed Oct 10 16:25:27 2018 +0200

     Remove MANAGMENT_EXTERNAL_KEY, MANAGMENT_IN_EXTRA, ENABLE_CLIENT_CR

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20181010142527.27025-1-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20181010142527.27025-1-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


