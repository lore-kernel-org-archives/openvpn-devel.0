From: Arkadiusz Patyk <areq@...104...>
Message-ID: <8stemv0kdc7e2mlbfedacq1bepruuppevj@...105...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Problem with regenerate ac/am stuff.
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Sep 16 14:01:02 2003
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

I have a problem with regenerate ac/am stuff.

+ cd openvpn-1.5-beta7
+ aclocal
+ autoheader
+ autoconf
+ #touch malloc.c
+ automake -a -c -f --foreign
Makefile.am:42: required file `./malloc.c' not found

Ugly hack:
touch malloc.c before automake.

autoconf-2.57-6
automake-1.7.7-1

Any ideas ?

Best regards,

--=20
Arkadiusz Patyk [areq(at)pld-linux.org] [http://rescuecd.pld-linux.org]

