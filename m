Message-ID: <43662220.3000807@...486...>
From: Albert Siersema <appie@...486...>
MIME-Version: 1.0
Subject: [Openvpn-devel] pkcs11-protected-authentication not working in 2.1beta4 ?
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
Date: Mon Oct 31 05:55:14 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Hello,

I've given 2.1beta4 a try as it includes direct PKCS11 support which
looks very promising in being able to run openvpn as a service AND
getting the cert from a smartcard. At least I hope I can archieve just that.
If i'm totally barking up the wrong tree please tell me right away :)

The setup i've been testing is Windows XP OS and SafeSign PKCS#11 provider DLL.

The --show-pkcs11-* commands cause the SafeSign PIN code popup to show
before openvpn.exe can access the smartcard.

Using (--)askpass works fine too when connecting with openvpn but
pkcs11-protected-authentication doesn't seem to work:
Mon Oct 31 14:35:04 2005 PKCS#11: Adding PKCS#11 provider 'aetpkss1.dll'
Mon Oct 31 14:35:06 2005 PKCS#11: Cannot set parameters -'CKR_ARGUMENTS_BAD'
Mon Oct 31 14:35:06 2005 Cannot load certificate "........"

config excerpt:

ca cacert.pem
pkcs11-providers aetpkss1.dll
;pkcs11-sign-mode auto
;
pkcs11-slot-type label
pkcs11-slot MYSLOT
; need to use askpass as:
;pkcs11-protected-authentication
; won't work. Dunno why not as the --show-pkcs11 commands do pop up
; the safesign PIN dialog box
askpass
pkcs11-id-type label
pkcs11-id MYCERT

Cheers,
Albert
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDZiIfKltZixSsH2QRA3GEAJ0YwqnvC63rW8pm0c7O7LNZDopS4gCfUMIa
eHDL1I0Sa7lRer+mgMQPpAs=
=0ZLt
-----END PGP SIGNATURE-----

