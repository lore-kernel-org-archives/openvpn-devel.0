From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <b174d626-1cf3-3c85-c61c-34ad587c454e@...515...>
Date: Thu, 20 Dec 2018 15:17:28 +0200
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] Dropping Ubuntu 12.04 packages?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I've worked on openvpn-vagrant and sbuild_wrapper recently[*] and
noticed that mainstream support for Debian 7 and Ubuntu 12.04 ended:

https://wiki.debian.org/DebianReleases
https://wiki.ubuntu.com/Releases

However, Ubuntu 12.04 is still under "Extended Security Maintenance",
meaning that a small subset of packages still receive security updates:

https://wiki.ubuntu.com/SecurityTeam/ESM/12.04

OpenVPN and OpenSSL are among the packages that Canonical still supports.

The question is: do _we_ want to keep releasing OpenVPN packages for
Ubuntu 12.04?

[*] Testing a review would be appreciated:

https://github.com/OpenVPN/sbuild_wrapper/pull/1
https://github.com/OpenVPN/openvpn-vagrant/pull/6

