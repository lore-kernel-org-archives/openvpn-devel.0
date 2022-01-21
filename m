Date: Fri, 21 Jan 2022 17:12:41 +0100 (CET)
Message-Id: <202201211612.20LGCfQ1036134@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220121144313.24961-1-a@...2181...>
References: <20220121144313.24961-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: unit-test: fix test_crypto when
 USE_COMP is not defined
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This looks better, and actually works :-)

Your patch has been applied to the master branch.

commit 33d9c7ace354693168c093550bd5a9f4dfed4078
Author: Antonio Quartulli
Date:   Fri Jan 21 15:43:13 2022 +0100

     unit-test: fix test_crypto when USE_COMP is not defined

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220121144313.24961-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23628.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


