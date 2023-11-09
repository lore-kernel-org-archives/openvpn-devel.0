Date: Thu, 9 Nov 2023 12:31:46 +0100 (CET)
Message-Id: <202311091131.3A9BVkHJ020329@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231108124947.76816-1-gert@...1296...>
References: <20231108124947.76816-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove saving initial frame code
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

Since this was security related (CVE) it was posted to the security@ list
first, and reviewed and ACKed by core team members there.  Re-Posting the
patches + the commit message here, after 2.6.7 release.

I have skimmed the code change and it looks reasonable - and I have
subjected this (+ 2/3 and 3/3) to the full set of t_client and t_server
patches, and things work as well as before.

Your patch has been applied to the release/2.6 and master branch.

commit 1cfca659244e362f372d9843351257f456392a2f (release/2.6)
commit a341914246d16ff277f2d521c2dc9273d41fa5ed (master)
Author: Arne Schwabe
Date:   Thu Oct 19 15:14:33 2023 +0200

     Remove saving initial frame code

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: David Sommerseth <davids@...515...>
     Acked-by: Heiko Hund <heiko@...2662...>
     Message-Id: <20231108124947.76816-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20231108124947.76816-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


