Date: Fri, 5 Nov 2021 16:05:49 +0100 (CET)
Message-Id: <202111051505.1A5F5n35085273@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211019183127.614175-19-arne@...1227...>
References: <20211019183127.614175-19-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix error when BF-CBC is not
 available
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

As discussed online, this is really just about OCC initialization,
and that really shouldn't pull in BF-CBC if not requested :-)

I have rewrapped the comment - one overlong line + one short line looked
avoidably silly :-)

Your patch has been applied to the master branch.

commit 056991925633ea27a1536bb610e0055072631ce7
Author: Arne Schwabe
Date:   Tue Oct 19 20:31:24 2021 +0200

     Fix error when BF-CBC is not available

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Max Fillinger <maximilian.fillinger@...2507...>
     Message-Id: <20211019183127.614175-19-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23010.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


