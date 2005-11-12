From: James Yonan <jim@...41...>
Message-ID: <Pine.LNX.4.58.0511121919160.1972@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1-beta7 released
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
Date: Sat Nov 12 18:23:56 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

For those of you who would like to follow the 2.1-beta series without 
actually downloading it, I've put the 2.1 ChangeLog and man pages on the 
web site.

Download:

http://openvpn.net/download.html

Change Log:

2005.11.12 -- Version 2.1-beta7

* Allow blank passwords to be passed via the management
  interface.
* Fixed bug where "make check" inside a FreeBSD "jail"
  would never complete (Matthias Andree).
* Fixed bug where --server directive in --dev tap mode
  claimed that it would support subnets of /30 or less
  but actually would only accept /29 or less.
* Extend byte counters to 64 bits (M. van Cuijk).
* PKCS#11 fixes (Alon Bar-Lev).
* Fixed bug in Linux get_default_gateway function
  introduced in 2.0.4, which would cause redirect-gateway
  on Linux clients to fail.
* Moved easy-rsa 2.0 scripts to easy-rsa/2.0 to
  be compatible with 2.0.x distribution.
* Documented --route-nopull.
* Documented --ip-win32 adaptive.
* Windows build now linked with LZO2.
* Allow ca, cert, key, and dh files to be specified
  inline via XML-like syntax without needing to
  reference an explicit file.
  For example:
  <ca>
        data here...
  </ca>
* Allow plugin and push directives to have multi-line
  parameter lists such as:
  <plugin>
    my-plugin.so
    parm1
    parm2
  </plugin>
* Added connect-retry-max option (Alon Bar-Lev).
* Fixed problems where signals thrown during initialization
  were not returning to a management-hold state.
* Added a backtrack-hardened system time algorithm.
* Added --remote-cert-ku, --remote-cert-eku, and
  --remote-cert-tls options for verifying certificate
  attributes (Alon Bar-Lev).
* For Windows, reverted --ip-win32 default back to "dynamic".
  To use new adaptive mode, set explicitly.

James


