Message-ID: <48522FAC.1020006@...41...>
Date: Fri, 13 Jun 2008 01:28:28 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1_rc8 released
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
To: Openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Download:

https://secure.openvpn.net/beta/

File signatures:

https://secure.openvpn.net/beta/signatures/

Change Log:

2008.06.11 -- Version 2.1_rc8

* Added client authentication and packet filtering capability
   to management interface.  In addition, allow OpenVPN plugins
   to take advantage of deferred authentication and packet
   filtering capability.

* Added support for client-side connection profiles.

* Fixed unbounded memory growth bug in environmental variable
   code that could have caused long-running OpenVPN sessions
   with many TLS renegotiations to incrementally
   increase memory usage over time.

* Windows release now packages openssl-0.9.8h.

* Build system changes -- allow building on Windows using
   autoconf/automake scripts (Alon Bar-Lev).

* Changes to Windows build system to make it easier to do
   partial builds, with a reduced set of prerequisites,
   where only a subset of OpenVPN installer
   components are built.  See ./domake-win comments.

* Cleanup IP address for persistence interfaces for tap and also
   using ifconfig, gentoo#209055 (Alon Bar-Lev).

* Fall back to old version of extract_x509_field for OpenSSL 0.9.6.

* Clarified tcp-queue-limit man page entry (Matti Linnanvuori).

* Added new OpenVPN icon and installer graphic.

* Minor pkitool changes.

* Added --pkcs11-id-management option, which will cause OpenVPN to
   query the management interface via the new NEED-STR asynchronous
   notification query to get additional PKCS#11 options (Alon Bar-Lev).

* Added NEED-STR management interface asynchronous query and
   "needstr" management interface command to respond to the query
   (Alon Bar-Lev).

* Added Dragonfly BSD support (Francis-Gudin).

* Quote device names before passing to up/down script (Josh Cepek).

* Bracketed struct openvpn_pktinfo with #pragma pack(1) to
   prevent structure padding from causing an incorrect length
   to be returned by sizeof (struct openvpn_pktinfo) on 64-bit
   platforms.

* On systems that support res_init, always call it
   before calling gethostbyname to ensure that
   resolver configuration state is current.

* Added NTLMv2 proxy support (Miroslav Zajic).

* Fixed an issue in extract_x509_field_ssl where the extraction
   would fail on the first field of the subject name, such as
   the common name in:  /CN=foo/emailAddress=foo@...1106...

* Made "Linux ip addr del failed" error nonfatal.

* Amplified --client-cert-not-required warning.

* Added #pragma pack to proto.h.

James




