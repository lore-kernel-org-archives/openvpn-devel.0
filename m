Date: Mon, 3 May 2021 08:53:51 +0200 (CEST)
Message-Id: <202105030653.1436rpq7037630@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210422152939.2134046-5-arne@...1227...>
References: <20210422152939.2134046-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Replace OS_SPECIFIC_DIRSEP with
 PATH_SEPARATOR
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

I have not actually tested it (only test compiled on the unix zoo and
MinGW), but it looks very reasonable.

Your patch has been applied to the master branch.

commit d4c1a453c2084fa09baeee58cda0a9823e0b5038
Author: Arne Schwabe
Date:   Thu Apr 22 17:29:38 2021 +0200

     Replace OS_SPECIFIC_DIRSEP with PATH_SEPARATOR

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210422152939.2134046-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22203.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


