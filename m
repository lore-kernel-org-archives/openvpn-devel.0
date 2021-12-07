Date: Tue, 7 Dec 2021 19:50:33 +0100 (CET)
Message-Id: <202112071850.1B7IoXox074190@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211207170211.3275837-2-arne@...1227...>
References: <20211207170211.3275837-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove max_size from
 buffer_list_new
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

Acked-by: Gert Doering <gert@...1296...>

That was one of the easy ones :-) - verified that indeed, this option
is never used in OpenVPN code.

I have client-side tested this ("make check"), just to be sure.

"void" has been added to prototype and function declaration...

Your patch has been applied to the master branch.

commit 5962f6267fcdf33f83f8de725751b5ef41e94f7c
Author: Arne Schwabe
Date:   Tue Dec 7 18:01:51 2021 +0100

     Remove max_size from buffer_list_new

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211207170211.3275837-2-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20211207170211.3275837-2-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


