Date: Tue, 23 Sep 2025 14:56:53 +0200 (CEST)
Message-Id: <202509231256.58NCura6015524@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250923122006.12212-1-gert@...1296...>
References: <20250923122006.12212-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure.ac: Make
 ACL_CHECK_ADD_COMPILE_FLAGS append instead of prepend
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

So, as discussed on IRC, this is not really intended to "change anything
noticeable" - but when working on adding CFLAGS and generally autoconf
related, it helps when "add this to CFLAGS" does not "it will show up
in front" (because your mental model expects this "at the end").

Tested, -W arguments and -g/-O2/-std=c11 are in reverse order, everything
else is the same.

Your patch has been applied to the master branch.

commit 9bfd4d246c50743c8ff9cdb72afc8741eab91f03
Author: Frank Lichtenheld
Date:   Tue Sep 23 14:20:00 2025 +0200

     configure.ac: Make ACL_CHECK_ADD_COMPILE_FLAGS append instead of prepend

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1204
     Message-Id: <20250923122006.12212-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59237450/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


