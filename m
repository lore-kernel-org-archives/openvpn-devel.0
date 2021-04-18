Date: Sun, 18 Apr 2021 16:37:10 +0200 (CEST)
Message-Id: <202104181437.13IEbAGP085763@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210416110955.1162574-1-arne@...1227...>
References: <20210416110955.1162574-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add parsing of dhcp-option
 PROXY_HTTP
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

We discussed the feature-ACK part in the last community meeting - this
is for (Android) clients "everything that runs while the VPN is active"
should use an http proxy.  This is installed by the VPN API and "just
passed through" through OpenVPN.

The new code is all #ifdef TARGET_ANDROID, so if you say this is good,
we're not to doubt it :-) (but it looks reasonably safe).  The argument
count change is (unfortunately) necessary but also looks good.

I have run a t_client test run, but that didn't excercise the DHCP
code much.

Your patch has been applied to the master branch.

commit 8d109f68fd277b3e00ba7bef61a172b4130c35b8
Author: Arne Schwabe
Date:   Fri Apr 16 13:09:55 2021 +0200

     Add parsing of dhcp-option PROXY_HTTP

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210416110955.1162574-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22129.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


