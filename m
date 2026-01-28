Date: Wed, 28 Jan 2026 18:09:12 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <aXpCuBE-Iy-O2J4b@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.7_rc6 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

The OpenVPN community project team is proud to release OpenVPN 2.7_rc6.

This is the sixth release candidate for the feature release 2.7.0.

Important changes since 2.7_rc5:

* bugfix on restarting a p2mp server instance with SIGUSR1
  (inadvertedly closing fd 0, causing a crash on the next
   restart - GH OpenVPN/openvpn#966)
* prevent NULL pointer crash on suitable combination of
  --dns-updown statements in openvpn config file (not pushable)
* prevent inappropriate management interface activity if a
  password is set and --management-forget-disconnect or
  --management-signal are active
* add mbedTLS 4 support

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/master/Changes.rst>

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community-downloads/>

Packages for Debian, Ubuntu, Fedora, RHEL, and openSUSE are available in the various
official Community repositories:

<https://community.openvpn.net/Pages/OpenVPN%20software%20repos>

Kind regards,
-- 
  Frank Lichtenheld

