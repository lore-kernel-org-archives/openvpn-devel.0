Date: Wed, 16 Jan 2019 19:42:35 +0100 (CET)
Message-Id: <201901161842.x0GIgZfP053010@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <E1gjn4T-0003e9-LN@...2487...>
References: <E1gjn4T-0003e9-LN@...2487...>
Subject: [Openvpn-devel] [PATCH applied] Re: Extend tls-crypt-v2 unit tests
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

Acked-by: Gert Doering <gert@...1296...>

Patch does what it says on the tin - test for this particular regression.

Without Arne's patch, running "make check" with mbedtls fails (openssl
succeeds).  With Arne's patch applied - commit 92a5ec31363e76e6 -
both succeed.

Your patch has been applied to the master branch. 

commit ef4b8c972f8f4f9debf56bd1ccff7b5889b3305d
Author: Steffan Karger
Date:   Wed Jan 16 16:24:50 2019 +0100

     Extend tls-crypt-v2 unit tests

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <E1gjn4T-0003e9-LN@...2487...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18095.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


