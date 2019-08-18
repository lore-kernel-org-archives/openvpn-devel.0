From: Matthias Andree <matthias.andree@...68...>
Date: Sun, 18 Aug 2019 13:18:10 +0200
Message-Id: <20190818111811.8853-1-matthias.andree@...68...>
MIME-Version: 1.0
Subject: [Openvpn-devel] v2: fix release/2.4 regression of 2.4.7,
 permit build with LibreSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: pizzamig@...1249...

It was deemed that the previous patch was insufficient, so let's
take a new stab. Note that this does not mean I endorse using
LibreSSL, but at least we should not be breaking existing library
support in a point release 2.4.7 (that cannot be compiled
against LibreSSL) when 2.4.6 could.

Details on the rationale also in the subsequent patch's description.


