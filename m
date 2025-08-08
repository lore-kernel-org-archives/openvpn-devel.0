Date: Fri, 8 Aug 2025 07:58:02 +0200 (CEST)
Message-Id: <202508080558.5785w2EN078070@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250807203741.31359-1-gert@...1296...>
References: <20250807203741.31359-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: t_client.sh: Do not wait 3
 seconds for OpenVPN to come up
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

"Because it makes sense" :-) - lightly tested on Linux, heavily tested by
the buildbots.

Your patch has been applied to the master branch.

commit db1fd1a80baa9e44df8ae82f0fd2b56c59195484
Author: Frank Lichtenheld
Date:   Thu Aug 7 22:37:35 2025 +0200

     t_client.sh: Do not wait 3 seconds for OpenVPN to come up

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250807203741.31359-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32585.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


