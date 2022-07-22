Date: Fri, 22 Jul 2022 15:12:24 +0200 (CEST)
Message-Id: <202207221312.26MDCO9q027059@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220722130224.2442759-1-arne@...1227...>
References: <20220722130224.2442759-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Error out if both remap-usr1
 SIGHUP and config stdin are used
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

All bugs fixed, SOB added, v2 implied!  Does what it says on the lid...

$ openvpn --config stdin --remap-usr1 SIGHUP --dev null
<ctrl-d>
Options error: Options 'config stdin' and 'remap-usr1 SIGHUP' are incompatible with each other.

Your patch has been applied to the master branch.

commit 4df50030fb7ef8b36fa7a6ef451603263c760f11
Author: Arne Schwabe
Date:   Fri Jul 22 15:02:24 2022 +0200

     Error out if both remap-usr1 SIGHUP and config stdin are used

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220722130224.2442759-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24720.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


