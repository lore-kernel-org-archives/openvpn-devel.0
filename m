Date: Sat, 30 Dec 2023 16:26:00 +0100 (CET)
Message-Id: <202312301526.3BUFQ0c6028894@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231230142348.29108-1-gert@...1296...>
References: <20231230142348.29108-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure: enable silent rules
 by default
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Tested, looks good.  Nothing is lost, as the full output is still
available with "make V=1".

Your patch has been applied to the master branch.

commit bfcad5cd054bf615c33ace2a920756c69467d497
Author: Frank Lichtenheld
Date:   Sat Dec 30 15:23:48 2023 +0100

     configure: enable silent rules by default

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20231230142348.29108-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27865.htm
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


