From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20040302102022.GA14062@...33...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Files missing from BETA20 CVS
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
Date: Tue Mar  2 02:26:02 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

the files list.c, mroute.c and multi.c appear to be missing from the
BETA20 branch in CVS:

ma@...174...:~/cvs-3rdparty/openvpn> LANG=C make -ks 2>&1 | grep ^make
make[1]: *** No rule to make target `list.c', needed by `list.o'.
make[1]: *** No rule to make target `mroute.c', needed by `mroute.o'.
make[1]: *** No rule to make target `multi.c', needed by `multi.o'.
make[1]: *** [openvpn.o] Error 1
make[1]: Target `all-am' not remade because of errors.
make: *** [all] Error 2

Best wishes,
Matthias

