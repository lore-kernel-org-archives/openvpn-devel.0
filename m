Date: Fri, 7 Oct 2022 14:19:44 +0200 (CEST)
Message-Id: <202210071219.297CJilS070626@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221006122940.1202712-1-arne@...1227...>
References: <20221006122940.1202712-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Document/cleanup event_timeout
 functions
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

Thanks for the thorough review.  I have adjusted the 3 minor nits in 
the comments, as instructed.  I have also removed the spurious blank line.

The code change looks huge, indeed, unless viewed with "-w" - then it's
quite straightforward.  For good measure I've still subjected this to
the server side torture testing, and it's all still well-behaved
(= nothing new breaks).

Your patch has been applied to the master branch.

commit 0b980fa4e5761d6544ccf96b89fc2186ce23e144
Author: Arne Schwabe
Date:   Thu Oct 6 14:29:40 2022 +0200

     Document/cleanup event_timeout functions

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20221006122940.1202712-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25348.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


