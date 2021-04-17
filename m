Date: Sat, 17 Apr 2021 14:34:47 +0200 (CEST)
Message-Id: <202104171234.13HCYl95011504@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210417100544.5497-1-gert@...1296...>
References: <20210417100544.5497-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Repair --secret deprecation
 warning.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master branch.

Wording fixed as requested ("depreciation" is a valid term, but refers
to "financial value diminishes over time")

Tested, of course - now only the p2p test warns (as opposed to "all warn"),
and that's to be expected :-)

commit 85080921096fe60c6956b1e0a13fe6f9a3f93ab6 (master)
Author: Gert Doering
Date:   Sat Apr 17 12:05:44 2021 +0200

     Repair --secret deprecation warning.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210417100544.5497-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22139.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


