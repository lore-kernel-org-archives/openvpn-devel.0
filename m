Date: Thu, 16 Mar 2023 15:06:24 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZBMiYC8gEiFgg2QD@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.6.1 released
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
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

The OpenVPN community project team is proud to release OpenVPN 2.6.1.

This is mostly a bugfix release with some improvements. 

Feature changes:

* Dynamic TLS Crypt:
  When both peers are OpenVPN 2.6.1+, OpenVPN will dynamically create a tls-crypt
  key that is used for renegotiation. This ensure that only the previously
  authenticated peer can do trigger renegotiation and complete renegotiations.
* CryptoAPI (Windows): support issuer name as a selector.
  Certificate selection string can now specify a partial issuer name string as
  "--cryptoapicert ISSUER:<string>" where <string> is matched as a substring of
  the issuer (CA) name in the certificate. 

Note: configure now enables DCO build by default on FreeBSD and Linux. On Linux
this brings in a new default dependency for libnl-genl (for Linux distributions
that are too old to have a suitable version of the library, use
"configure --disable-dco")

Windows MSI changes since 2.6.0:

* Update included ovpn-dco-win driver to 0.9.2 

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/release/2.6/Changes.rst>

(The Changes document also contains a section with work-arounds for
common problems encountered when using OpenVPN with OpenSSL 3)

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community-downloads/>

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

On Red Hat derivatives we recommend using the Fedora Copr repository.

<https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-release/>

Kind regards,
-- 
  Frank Lichtenheld

