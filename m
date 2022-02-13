Date: Sun, 13 Feb 2022 15:10:07 +0100 (CET)
Message-Id: <202202131410.21DEA7Iq073236@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211105150742.2909443-1-arne@...1227...>
References: <20211105150742.2909443-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Default to --cipher BF-CBC if
 not set and compat-mode < 2.4.0
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

I have not given this much testing, as Antonio has tested the relevant
combinations.  Code looks good.  Client-tested.

Your patch has been applied to the master branch.

commit fd72a3b99dcb110953d8466bfe6c47dab3a29657
Author: Arne Schwabe
Date:   Fri Nov 5 16:07:42 2021 +0100

     Default to --cipher BF-CBC if not set and compat-mode < 2.4.0

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20211105150742.2909443-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23100.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


