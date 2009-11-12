Message-ID: <4AFBDD9E.8090207@...41...>
Date: Thu, 12 Nov 2009 03:04:14 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1_rc21 released
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
To: Openvpn-devel@lists.sourceforge.net, OpenVpn-Users <openvpn-users@lists.sourceforge.net>, openvpn-announce@lists.sourceforge.net

This release is to respond to the OpenSSL vulnerability CVE-2009-3555.

Some people have worried that the fix made to OpenSSL to address this
vulnerability (ban all SSL/TLS renegotiations) would break OpenVPN's
session renegotiation capability.  This is not the case.  OpenVPN does 
not rely on the session renegotiation capability that is built into 
SSL/TLS, and therefore if OpenVPN is linked against an OpenSSL library 
that disables SSL/TLS renegotiation, there should be no loss of 
functionality.

Changes:

2009.11.12 -- Version 2.1_rc21

* Rebuilt OpenVPN Windows installer with OpenSSL 0.9.8l to address
   CVE-2009-3555.  Note that OpenVPN has never relied on the session
   renegotiation capabilities that are built into the SSL/TLS protocol,
   therefore the fix in OpenSSL 0.9.8l (disable SSL/TLS renegotiation
   completely) will not adversely affect OpenVPN mid-session SSL/TLS
   renegotation or any other OpenVPN capabilities.

* Added additional session renegotiation hardening.  OpenVPN has always
   required that mid-session renegotiations build up a new SSL/TLS
   session from scratch.  While the client certificate common name is
   already locked against changes in mid-session TLS renegotiations, we
   now extend this locking to the auth-user-pass username as well as all
   certificate content in the full client certificate chain.

James

