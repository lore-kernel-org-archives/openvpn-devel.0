Date: Wed, 29 Mar 2023 10:38:13 +0200 (CEST)
Message-Id: <202303290838.32T8cD6X007871@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230322221456.1660425-1-selva.nair@...277...>
References: <20230322221456.1660425-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move digest_sign_verify out of
 test_cryptoapi.c
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

"git show --color-moved=zebra" agrees with "this is just moving stuff
around".  I have tested that "make dist" picks up the new file (this
is something we tend to get wrong), and ran this by GHA (pass).

At this point in the 2.6 life cycle, I think we can go back to the
"everything goes to master, only bugfixes go to release/2.6" way of
doing things - so this patchset (and subsequent new features for
cryptoapi that benefit from the unit test) would only be "in master".

I am bringing this up at the community meeting today (and here in the
mail) so you all have a chance to yell at me and convince me otherwise.

Your patch has been applied to the master branch.

commit 3bc071a8e3e21250f9be9c29273de0d96288056e (master)
Author: Selva Nair
Date:   Wed Mar 22 18:14:54 2023 -0400

     Move digest_sign_verify out of test_cryptoapi.c

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230322221456.1660425-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26484.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


