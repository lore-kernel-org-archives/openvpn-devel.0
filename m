From: James Yonan <jim@...41...>
Message-ID: <Pine.LNX.4.58.0511011238570.16655@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.0.4 Released -- Note security fixes
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
Date: Tue Nov  1 12:18:11 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

This release contains fixes for two security issues that just came to my
attention over the past 24 hours, which affect OpenVPN 2.0, 2.0.1, 2.0.2,
and the 2.1 beta series.  OpenVPN 1.x is not affected.

Individual patches are available here:

http://openvpn.net/patch/2.0.4-security-patches

Change Log:

* Security fix -- Affects non-Windows OpenVPN clients of
  version 2.0 or higher which connect to a malicious or
  compromised server.  A format string vulnerability
  in the foreign_option function in options.c could
  potentially allow a malicious or compromised server
  to execute arbitrary code on the client.  Only
  non-Windows clients are affected.  The vulnerability
  only exists if (a) the client's TLS negotiation with
  the server succeeds, (b) the server is malicious or
  has been compromised such that it is configured to
  push a maliciously crafted options string to the client,
  and (c) the client indicates its willingness to accept
  pushed options from the server by having "pull" or
  "client" in its configuration file (Credit: Vade79).
  CVE-2005-3393
* Security fix -- Potential DoS vulnerability on the
  server in TCP mode.  If the TCP server accept() call
  returns an error status, the resulting exception handler
  may attempt to indirect through a NULL pointer, causing
  a segfault.  Affects all OpenVPN 2.0 versions.
  CVE-2005-3409
* Fix attempt of assertion at multi.c:1586 (note that
  this precise line number will vary across different
  versions of OpenVPN).
* Added ".PHONY: plugin" to Makefile.am to work around
  "make dist" issue.
* Fixed double fork issue that occurs when --management-hold
  is used.
* Moved TUN/TAP read/write log messages from --verb 8 to 6.
* Warn when multiple clients having the same common name or
  username usurp each other when --duplicate-cn is not used.
* Modified Windows and Linux versions of get_default_gateway
  to return the route with the smallest metric
  if multiple 0.0.0.0/0.0.0.0 entries are present.

James

