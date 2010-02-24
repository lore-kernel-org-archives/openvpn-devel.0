From: Marcel =?iso-8859-1?q?Pennewi=DF?= <mailinglists@...1145...>
Date: Wed, 24 Feb 2010 14:24:39 +0100
MIME-Version: 1.0
Message-Id: <201002241424.39312.mailinglists@...1145...>
Subject: [Openvpn-devel] Gentoo Git-Live-Ebuild
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

following the discussions and new patches i adapted the current Gentoo Ebuild 
to use the allmerged-testing-tree (openvpn-9999.ebuild). 

I'll try to keep it working and also i'll try to support the ebuilds on the 
openvpn-devel mailinglist ;) The Ebuilds and all associated files can be found
in our Gentoo-FeM-Overlay which can be accessed

via HTTP / Subversion:
http://subversion.fem.tu-ilmenau.de/repository/fem-overlay/trunk/net-
misc/openvpn/

via WebSVN:
http://subversion.fem.tu-ilmenau.de/websvn/wsvn/fem-overlay/trunk/net-
misc/openvpn/

or included via layman:
layman --overlays=http://subversion.fem.tu-ilmenau.de/overlay.xml \
-L -a fem-overlay"

This is a slotted Ebuild so that a normal openvpn version can be installed 
parallel to the dev-ebuild where the bin, init-script and manpage are renamed 
to openvpn-dev. with the init script you can reuse the existing configs which 
will be nice for testing on productive systems. For a better bugreporting the 
ebuild append the commit ID  (e.g. "OpenVPN 2.1.1b-
git-6f53b4bf5f9b40dd96aecfcf325b0095f9ef3285").

In march i'll try to setup a full ipv6-setup using Gert's payload-patch. This 
setup could be tested by our members during daily use. Maybe some livebuilds 
for ubuntu/debian will be available then?

best regards and big thx for spending your valuable time 

Marcel

