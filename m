Date: Tue, 10 Sep 2024 14:52:13 +0200 (CEST)
Message-Id: <202409101252.48ACqDhP016902@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240910122008.23507-1-gert@...1296...>
References: <20240910122008.23507-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Various fixes for -Wconversion
 errors
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

I'm not a great fan of patches that do nothing more than "appease compilers",
and some of the conversions should really not be necessary - OTOH,
compilers have become better at spotting implicit conversions that *are*
not intended, losing precision and breaking things in the long run - so
better be explicit about int types...

I have stared-at-code (in addition to the ACK by Arne, recorded in Gerrit,
which somehow did not make it into the mail) - looks good.  Also, gave
it some basic tests on Linux and FreeBSD + GHA (-Werror builds), and
all fine..

Your patch has been applied to the master branch.

commit 53449cb61ff569c4862926c7999d50f634030fd9
Author: Frank Lichtenheld
Date:   Tue Sep 10 14:20:08 2024 +0200

     Various fixes for -Wconversion errors

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20240910122008.23507-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29172.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


