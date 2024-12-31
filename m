Date: Tue, 31 Dec 2024 17:50:53 +0100 (CET)
Message-Id: <202412311650.4BVGorKf008842@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241227124632.110920-1-frank@...2641...>
References: <20241227124632.110920-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow DEFAULT in data-ciphers
 and report both expanded and user set option
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

I have only lightly reviewed this, and it all seems to make sense.

The idea is good, as we have seen in all these bug reports for 2.6 related
to `--data-ciphers`.  The test rig is happy.  Also, unit tests ;-)

Your patch has been applied to the master branch.

commit 6a7931a4a89cb35be7b799942e7fa03fde2cdc63
Author: Arne Schwabe
Date:   Fri Dec 27 13:46:32 2024 +0100

     Allow DEFAULT in data-ciphers and report both expanded and user set option

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20241227124632.110920-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30245.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


