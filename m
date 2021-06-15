Date: Tue, 15 Jun 2021 20:14:03 +0200 (CEST)
Message-Id: <202106151814.15FIE3uU047237@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210520151148.2565578-2-arne@...1227...>
References: <20210520151148.2565578-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement auth-token-user
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

Your patch has been applied to the master and release/2.5 branch 
(long-term compat).

I'm not exactly happy with this patch for a number of reasons, which is
why I was a bit reluctant to merge it.  It does what it says on the lid,
the code is safe, and it got ACKs.  So, merging.

That said, this is sort of a special case for a special case that 
seems to have come out of OpenVPN Inc product marketing (do 2FA outside 
OpenVPN and then notice that this doesn't actually work) - and it makes
the code even more complex by having this extra boolean to check in
a number of places...  (a somewhat simpler approach could be to have
a "default username" - <NOT-SET> or such - and use that if up is not
defined)


Anyway.  I have tested the "does auth-token, on reneg, and token
expiry still work?" bit fairly thoroughly - as this is code that took
us quite a while to get right - and it seems to still work.  I have
not tested actually pushing "auth-token-user bla", but I have been
told Heiko and David have tested that path in earnest.

I have also taken the liberty to clean up the comments quite a bit
(seems Richard did not like this patch and did not spell-check :-) ).

commit b398aa37ca309948b481401adf0074ea5589eb2d (master)
commit d38d61111d08558e2f52cc9bcdc928ca9c4fca61 (release/2.5)
Author: Arne Schwabe
Date:   Thu May 20 17:11:41 2021 +0200

     Implement auth-token-user

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210520151148.2565578-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22417.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


