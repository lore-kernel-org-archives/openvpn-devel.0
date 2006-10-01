Message-ID: <451FBC52.70900@...41...>
Date: Sun, 01 Oct 2006 07:02:10 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.0.9 and 2.1-beta16 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: 'openvpn-users' <openvpn-users@lists.sourceforge.net>, OpenVPN devel <openvpn-devel@lists.sourceforge.net>, openvpn-announce@lists.sourceforge.net

2006.10.01 -- Version 2.0.9

* Windows installer updated with OpenSSL 0.9.7l DLLs to fix
  published vulnerabilities.

* Fixed TAP-Win32 bug that caused BSOD on Windows Vista
  (Henry Nestler).  The TAP-Win32 driver has now been
  upgraded to version 8.4.

2006.10.01 -- Version 2.1-beta16

* Windows installer updated with OpenSSL 0.9.7l DLLs to fix
  published vulnerabilities.

* Fixed TAP-Win32 bug that caused BSOD on Windows Vista
  (Henry Nestler).

* Autodetect 32/64 bit Windows in installer and install
  appropriate TAP driver (Mathias Sundman, Hypherion).

* Fixed bug in loopback self-test introduced
  in 2.1-beta15 where self test as invoked by
  "make check" would not properly exit after
  2 minutes (Paul Howarth).

James



