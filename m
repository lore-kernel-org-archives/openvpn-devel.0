Message-ID: <4366228B.8060007@...486...>
From: Albert Siersema <appie@...486...>
MIME-Version: 1.0
Subject: [Openvpn-devel] substring subject matching suggestion for new pkcs11 support
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
Date: Mon Oct 31 05:57:03 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

In pkcs11.c instead of
if (!strcmp (szId, szSubject))
could strstr() to match on substring in the subject ?
(akin cryptoapicert "SUBJ:...")
This would be easier in distributing config files to clients.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDZiKLKltZixSsH2QRA6K+AJ95Ly7zSQBF3yGUhO+uHut5CIC33wCfbmFj
OHgv3p1Lr6JsseD3AcVoVj8=
=fCbT
-----END PGP SIGNATURE-----

