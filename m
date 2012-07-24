MIME-Version: 1.0
Date: Tue, 24 Jul 2012 23:50:36 +0800
Message-ID: <CAO5YuCXYLusXiOcqFXF0Ni77b73Z+XTKsE_JpBrN45bTiMfdHQ@...278...>
From: jay alco <jproxy22@...277...>
Subject: [Openvpn-devel] Windows building error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I'm trying to build openvpn on windows with mingw but having trouble.
I tried building both openvpn 2.1.4 and 2.2.2 from source without
changing configuration, just executing domake-win and it builds the
exe perfectly. But when i change configurations in makeopenvpn file i
cause me the error.

I use the following configuration to guild without crypto and ssl. just lzo.

	    --enable-strict \
	    --prefix=$H/windest \
	    MAN2HTML=true \
	    --disable-crypto \
	    --disable-ssl \
	    --enable-password-save \
	    --with-lzo-headers=$H/$LZO_DIR/include \
	    --with-lzo-lib=$H/$LZO_DIR \
	    --with-pkcs11-helper-headers=$H/$PKCS11_HELPER_DIR/usr/local/include \
	    --with-pkcs11-helper-lib=$H/$PKCS11_HELPER_DIR/usr/local/lib

but it produce the following error both 2.1.4 and 2.2.2.
LZO headers were not found
LZO libraby available from http:\\'' etc.....etc...
configure: error: Or try ./configure --disable-lzo //I don't wan to disable lzo
install-win32/makeopenvpn: line 24:
--with-lzo-headers=/c/mingw/msys/1.0/home/administrator/openvpn-2.1.4/../lzo-2.02/inlcude:
No such file or directory

i have the lzo libs in the directory and was able to complete it
without disabling crypto and ssl. But when i disable SSL and crypto it
doesn't seem to find the lzo libs.

then i tried disabling lzo in openvpn 2.2.2 and it created the exe
file without cryto and ssl but not what i want since i need lzo.
Problem with openvpn 2.1.4 is even with lzo features disabled it still
gives me error

options.c: In fuction 'parse_http_proxy_fallback':
options.c:1474:33: error: dereferencing pointer to incomplete type
options.c:1477:4: error: dereferencing pointer to incomplete type
options.c:1478:4: error: dereferencing pointer to incomplete type

I don't even know what parse_http_proxy_fallback got to do with SSL
and CRYTO. any one knows what i'm doing wrong except from the fact
that i disabled ssl?

