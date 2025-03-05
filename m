Date: Wed, 5 Mar 2025 07:56:40 +0100 (CET)
Message-Id: <202503050656.5256ue6p024121@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250228170232.322186-1-frank@...2641...>
References: <20250228170232.322186-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add more 'intentional
 fallthrough' comments
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

Thanks for this.  Helping the compiler see the intentions vs. a forgotten
"break" is a good long-term strategy, I'd say :-)

Your patch has been applied to the master branch.

commit fed37d003d9cbc9e7c3ea5fdd0f0a287f4cee538
Author: Frank Lichtenheld
Date:   Fri Feb 28 18:02:32 2025 +0100

     Add more 'intentional fallthrough' comments

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250228170232.322186-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30990.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


