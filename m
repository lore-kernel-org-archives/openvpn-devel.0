Message-ID: <4B22E318.7040701@...41...>
Date: Fri, 11 Dec 2009 17:26:00 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1.1 released
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, OpenVpn-Users <openvpn-users@lists.sourceforge.net>, openvpn-announce@lists.sourceforge.net

2009.12.11 -- Version 2.1.1

* Fixed some breakage in openvpn.spec (which is required to build an
   RPM distribution) where it was referencing a non-existent
   subdirectory in the tarball, causing it to fail (patch from
   David Sommerseth).

James

