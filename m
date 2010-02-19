Message-ID: <4B7EB12E.5000405@...1114...>
Date: Fri, 19 Feb 2010 16:41:34 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Compiler warnings when using openssl-1.0.0 - beta4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Compiled the master branch from openvpn-testing.git on Fedora 12, and
noticed these warnings:

- ------------------------------------------------------------------------
ssl.c: In function ‘verify_callback’:
ssl.c:944: warning: passing argument 1 of ‘sk_num’ from incompatible
pointer type
/usr/include/openssl/stack.h:79: note: expected ‘const struct _STACK *’
but argument is of type ‘struct stack_st_X509_REVOKED *’
ssl.c:947: warning: passing argument 1 of ‘sk_value’ from incompatible
pointer type
/usr/include/openssl/stack.h:80: note: expected ‘const struct _STACK *’
but argument is of type ‘struct stack_st_X509_REVOKED *’
ssl.c: In function ‘init_ssl’:
ssl.c:1565: warning: passing argument 1 of ‘sk_num’ from incompatible
pointer type
/usr/include/openssl/stack.h:79: note: expected ‘const struct _STACK *’
but argument is of type ‘struct stack_st_X509 *’
ssl.c: In function ‘print_details’:
ssl.c:1766: warning: assignment discards qualifiers from pointer target type
- ------------------------------------------------------------------------

$ rpm -q openssl openssl-devel
openssl-1.0.0-0.13.beta4.fc12.x86_64
openssl-devel-1.0.0-0.13.beta4.fc12.x86_64

If nobody responds, I'll try to find some time looking into this in the
near future.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt+sSsACgkQDC186MBRfrrLHgCfRWG4wiWCcqaLR6qcFXQ+OYm1
PmwAni18mbED9jS6pwYVJxXyvUZ5Heb0
=i/Hd
-----END PGP SIGNATURE-----

