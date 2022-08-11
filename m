Date: Thu, 11 Aug 2022 12:03:45 +0200 (CEST)
Message-Id: <202208111003.27BA3jBP091528@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220514103717.235-1-timo@...2669...>
References: <20220514103717.235-1-timo@...2669...>
Subject: [Openvpn-devel] [PATCH applied] Re: platform: Retain CAP_NET_ADMIN
 when dropping privileges
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
To: Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel@lists.sourceforge.net

I have not tested this myself, but if I had, the test setup would have
been very similar to what Frank did (so, big thanks) - run a DCO 
environment with "owner nobody", and see if things still work.

I will add this to my DCO server test environment - run one of the
iroute-using instances with "nobody", so it is continuously tested.

I did have a stare-at-code a few weeks ago, and we did discuss this
a few months ago, and the approach chosen seems to make sense.

Uncrustify complained about two lines with tabs -> fixed.

Your patch has been applied to the master branch.

commit 2e359a088226ab1e5ee41fbab27d38d8a8d192ac
Author: Timo Rothenpieler
Date:   Sat May 14 12:37:17 2022 +0200

     platform: Retain CAP_NET_ADMIN when dropping privileges

     Signed-off-by: Timo Rothenpieler <timo@...2669...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220514103717.235-1-timo@...2669...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24360.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


