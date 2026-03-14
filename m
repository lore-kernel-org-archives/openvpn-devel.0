Date: Sat, 14 Mar 2026 18:07:26 +0100 (CET)
Message-Id: <202603141707.62EH7Ql7090038@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260313175209.12024-1-gert@...1296...>
References: <20260313175209.12024-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: crypto: Change cipher_kt_*_size
 to return unsigned instead of int
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

Quite a few small changes, but overall towards a more well-defined API - 
and indeed, "unsigned int" and "use it for everything-mumble-size" here
makes sense.  Thanks Arne for the thorough review.

Your patch has been applied to the master branch.

commit b0c2174a9ee7bfdf40df5a728b84967bded555d7
Author: Frank Lichtenheld
Date:   Fri Mar 13 18:52:04 2026 +0100

     crypto: Change cipher_kt_*_size to return unsigned instead of int

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1508
     Message-Id: <20260313175209.12024-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36114.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


