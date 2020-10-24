Date: Sat, 24 Oct 2020 22:23:20 +0200 (CEST)
Message-Id: <202010242023.09OKNKtY001432@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201023113244.26295-1-arne@...1227...>
References: <20201023113244.26295-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove --disable-def-auth
 configure argument
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

Looked at the changes (look good), saw that a few #ifdefs are now
"ENABLE_MANAGEMENT", so compiled with default settings and with
--disable-management.  Both passed compile + t_client tests.

I have not specifically tested management functionality - I do not
have a server testbed for that yet, and I was too lazy to compile
a windows client to test the client side.  I do assume that you
tested that part on the Android client already.

Your patch has been applied to the master branch.

commit 99d217b20064e7fef90dfa49bdcbab23ea7fbcb3
Author: Arne Schwabe
Date:   Fri Oct 23 13:32:44 2020 +0200

     Remove --disable-def-auth configure argument

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201023113244.26295-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21214.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


