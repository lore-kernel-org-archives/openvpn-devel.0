Date: Wed, 7 Dec 2022 19:12:49 +0100 (CET)
Message-Id: <202212071812.2B7ICnwl047668@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221207103530.18198-1-frank@...2641...>
References: <20221207103530.18198-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: ChangeLog: Fix encoding
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

Acked-by: Gert Doering <gert@...1296...>

Amazing enough, this survived e-mail, being saved and applied on an
ISO8859-1 system, and generally being close to me...

Verified with od -c that it is, indeed, now UTF8 umlauts in there!

0120440    s   )   :       f   i   x       f   o   r   e   i   g   n   _
0120460    o   p   t   i   o   n   _   {   n   }       t   y   p   o  \n
0120500   \n   T   Ã 265   i   v   o       L   e   e   d   j   Ã 244   r
0120520    v       (   1   )   :  \n                           S   t   o
0120540    p       u   s   i   n   g       d   e   p   r   e   c   a   t
0120560    e   d       g   e   t   p   a   s   s   (   )  \n  \n   V   i
0120600    l   l   e       S   k   y   t   t   Ã 244       (   1   )   :
0120620   \n                           R   E   A   D   M   E   .   d   o


Your patch has been applied to the release/2.6 branch.

commit d4f105c7d36f99b7bf9bfbfe38a6988bcc72f1a5
Author: Frank Lichtenheld
Date:   Wed Dec 7 11:35:30 2022 +0100

     ChangeLog: Fix encoding

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221207103530.18198-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25630.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


