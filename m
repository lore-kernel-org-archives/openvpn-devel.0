Message-ID: <49246130.9080305@...41...>
Date: Wed, 19 Nov 2008 11:55:44 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1_rc15 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: OpenVpn-Users <openvpn-users@lists.sourceforge.net>, Openvpn-devel@lists.sourceforge.net

2008.11.19 -- Version 2.1_rc15

* Fixed issue introduced in 2.1_rc14 that may cause a
   segfault when a --plugin module is used.

* Added server-side --opt-verify option: clients that connect
   with options that are incompatible with those of the server
   will be disconnected (without this option, incompatible
   clients would trigger a warning message in the server log
   but would not be disconnected).

* Added --tcp-nodelay option: Macro that sets TCP_NODELAY socket
   flag on the server as well as pushes it to connecting clients.

* Minor options check fix: --no-name-remapping is a
   server-only option and should therefore generate an
   error when used on the client.

* Added --prng option to control PRNG (pseudo-random
   number generator) parameters.  In previous OpenVPN
   versions, the PRNG was hardcoded to use the SHA1
   hash.  Now any OpenSSL hash may be used.  This is
   part of an effort to remove hardcoded references to
   a specific cipher or cryptographic hash algorithm.

* Cleaned up man page synopsis.

