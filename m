From: James Yonan <jim@...41...>
Message-ID: <Pine.LNX.4.58.0511012109090.13189@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1-beta6 released
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
Date: Tue Nov  1 20:15:34 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Download:

http://openvpn.net/beta/

Change Log:

2005.11.01 -- Version 2.1-beta6

* Security fixes (merged from 2.0.4).
* Fix attempt of assertion at multi.c:1586 (note that
  this precise line number will vary across different
  versions of OpenVPN).
* Windows reliability changes:
  (a) Added code to make sure that the local PATH environmental
      variable points to the Windows system32 directory.
  (b) Added new --ip-win32 adaptive mode which tries 'dynamic'
      and then fails over to 'netsh' if the DHCP negotiation fails.
  (c) Made --ip-win32 adaptive the default.
* More PKCS#11 additions/changes (Alon Bar-Lev).
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
* Added ">NEED-OK" alert and "needok" command to management
  interface to provide a general interface for sending
  alerts to the end-user.  Used by the PKCS#11 code
  to send Token Insertion Requests to the user.
* Added actual remote address used to the ">STATE" alert
  in the management interface (Rolf Fokkens).

James

