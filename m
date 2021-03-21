Date: Sun, 21 Mar 2021 19:50:56 +0100 (CET)
Message-Id: <202103211850.12LIoux4079541@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210321143353.2677-1-arne@...1227...>
References: <20210321143353.2677-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement peer-fingerprint to
 check fingerprint of peer certificate
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

Your patch has been applied to the master branch.

I have moved the Changes.rst hunk to the "new in 2.6" section, as my
time machine is broken and this won't make 2.5.1 anymore :-)

I have not tested this feature itself, just stared at the code + docs
(seems to make sense) and ran the client side tests (fine).  A real
test setup will have to be built.

commit c3a7065d5bec0ca4ad479e27c124e74fbd7c2234
Author: Arne Schwabe
Date:   Sun Mar 21 15:33:53 2021 +0100

     Implement peer-fingerprint to check fingerprint of peer certificate

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210321143353.2677-1-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20210321143353.2677-1-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


