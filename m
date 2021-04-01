Date: Thu, 1 Apr 2021 15:53:25 +0200 (CEST)
Message-Id: <202104011353.131DrPeb084976@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210401131337.3684-8-arne@...1227...>
References: <20210401131337.3684-8-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove unused field txqueuelen
 from struct tuntap
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

As far as I can see, only Linux uses txqueuelen at all, and that one
still compiles with this patch applied.  Out it goes!

Your patch has been applied to the master branch.

commit 3667df1d668420374d91607685b67a0efbcee328
Author: Arne Schwabe
Date:   Thu Apr 1 15:13:30 2021 +0200

     Remove unused field txqueuelen from struct tuntap

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210401131337.3684-8-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21947.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


