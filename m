MIME-Version: 1.0
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Tue, 6 Mar 2018 17:16:53 -0500
Message-ID: <CAEsd45T17CTS6xAjLHvDTf80u18YpN73o1T5BmNtfAz8WBdXRQ@...278...>
Subject: [Openvpn-devel] OpenSSL version(s) officially supported by OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi.

Inspired by the recent discussion about LibreSSL support:

Can someone clarify which versions of OpenSSL OpenVPN supports (that
is, "works with when linked statically")?

From what I gather:

 * OpenVPN 2.3.18 supports OpenSSL 1.0.2n
 * OpenVPN 2.4.5 supports OpenSSL 1.0.2n and 1.1.0g
 * OpenVPN 2.5 will support OpenSSL 1.0.2n and 1.1.0g

Is that correct? (I assume OpenVPN 2.5 won't remove support for
OpenSSL 1.0.2, which ends "Long Term Support" on 2019-12-31.)

Thanks in advance,

Jon Bullard (Tunnelblick developer)

PS: Tunnelblick bundles versions of OpenVPN linked with OpenSSL and
LibreSSL. I am considering including versions linked with different
OpenSSLs, too.

