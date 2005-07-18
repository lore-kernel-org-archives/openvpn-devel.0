From: Arkadiusz Patyk <areq@...104...>
Message-ID: <g94od15m6vp85l6qm5bm7ntjoc78mrqsso@...105...>
MIME-Version: 1.0
Subject: [Openvpn-devel] lzo 2.0.1
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Jul 18 13:35:40 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

In lzo 2.01:
Changes in 2.01 (27 Jun 2005)
  * Changed the configure system to install the LZO library under the
    name "liblzo2" so that parallel installation with LZO v1 is
possible.

openvpn 2.0.1_rc6:

configure: checking for LZO Library and Header files...
checking lzo/lzo1x.h usability... yes
checking lzo/lzo1x.h presence... yes
checking for lzo/lzo1x.h... yes
checking for lzo1x_1_15_compress in -llzo... no
configure: error: LZO headers were found but LZO library was not found
error: Bad exit status from /var/tmp/rpm-tmp.12673 (%build)

configure:9536: checking for lzo/lzo1x.h
configure:9543: result: yes
configure:9698: checking for lzo1x_1_15_compress in -llzo
configure:9728: i486-pld-linux-gcc -o conftest -pipe -Os -march=i486
-falign-loops=0 -falign-jumps=0 -falign-func
tions=0 -mno-align-double -D_REENTRANT -pthread  -I.
-I/usr/include/openssl    conftest.c -llzo  -ldl   >&5
/usr/bin/ld: cannot find -llzo
collect2: ld returned 1 exit status

-- 
Arkadiusz Patyk [areq(at)pld-linux.org] [http://rescuecd.pld-linux.org/]
[IRC:areq ICQ:16231667  GG:1383]  [AP3-6BONE] [AP14126-RIPE]

