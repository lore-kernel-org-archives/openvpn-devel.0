Date: Tue, 21 Nov 2023 20:18:10 +0100 (CET)
Message-Id: <202311211918.3ALJIAji087020@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231121104254.15701-1-frank@...2641...>
References: <20231121104254.15701-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Introduce report_command_status
 helper function
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

Skimmed the code, test compiled, not excercised the management interface.

Obvious improvement.

"client-auth" morphed into "client_auth" here, which I took the liberty
to change back (checked with Arne, avoid a new round).

Your patch has been applied to the master branch.

commit 57172d84096cc03e4a5a0658b9abb15d4173859d (master)
Author: Arne Schwabe
Date:   Tue Nov 21 11:42:54 2023 +0100

     Introduce report_command_status helper function

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20231121104254.15701-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27525.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


