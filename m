Date: Fri, 22 Jul 2022 16:29:10 +0200 (CEST)
Message-Id: <202207221429.26METAw0028387@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220722134652.2446598-1-arne@...1227...>
References: <20220722134652.2446598-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix segfault when no --config
 argument is given
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

Tested with and without --config, AND with "make check"!

Your patch has been applied to the master branch.

commit 6a0fcced7c44ae03a15e2ee28cd1867171c2c988
Author: Arne Schwabe
Date:   Fri Jul 22 15:46:52 2022 +0200

     Fix segfault when no --config argument is given

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220722134652.2446598-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24722.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


