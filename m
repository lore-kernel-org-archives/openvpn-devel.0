Date: Tue, 21 Nov 2023 22:26:18 +0100 (CET)
Message-Id: <202311212126.3ALLQIRZ091555@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231121103930.15175-1-frank@...2641...>
References: <20231121103930.15175-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Log SSL alerts more prominently
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

Better diagnostics is goood!

Your patch has been applied to the master and release/2.6 branch 
(very basic change, no code flow change, enhanced diagnostics good).

We might consider moving from dmsg() to msg() - this is neither 
very time consuming nor increasing binary size hugely.

commit a1cb1b47b138b9f654cd0bca5de6d08dbca61888 (master)
commit 94cd53c70e8e8fdd0beac79b17bdb1f912e03cb7 (release/2.6)
Author: Arne Schwabe
Date:   Tue Nov 21 11:39:30 2023 +0100

     Log SSL alerts more prominently

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231121103930.15175-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27523.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


