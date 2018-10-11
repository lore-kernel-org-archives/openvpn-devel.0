Date: Thu, 11 Oct 2018 17:00:22 +0200 (CEST)
Message-Id: <201810111500.w9BF0MGB096301@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1539153883-15789-1-git-send-email-steffan.karger@...1435...>
References: <1539153883-15789-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix mbedtls unit tests
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I haven't fully tested this because it needs "mbedtls in a non-default
location" to break in the first place, which I was too lazy to set up
now.  So I trust travis to check this case now :-)

commit b081038c7464f7a916560b4a71ebc83537a84b9d
Author: Steffan Karger
Date:   Wed Oct 10 08:44:43 2018 +0200

     Fix mbedtls unit tests

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1539153883-15789-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17687.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


