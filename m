Date: Mon, 18 Jan 2010 23:09:52 +0100
From: Bernhard Schmidt <berni@...376...>
Message-ID: <20100118220952.GA6704@...1293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [ANNOUNCE] IPv6 payload patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Hello everyone,

up to now OpenVPN only supports transporting IPv6 data through a
point-to-multipoint (tls-server/tls-client mode) using tap-interfaces,
which emulate a virtual ethernet device. The preferred tun-mode does not
support any IPv6, because the in-process routing engine does not
understand IPv6 addressing.

After planning to force a student to write this part of code (who
unfortunately sensed our plot and ran for his life) Gert Doering finally
yielded to our begging and promises of beer and wrote the code.

So here we go. This patch implements pretty much everything you need for
a decent IPv6 VPN-concentrator setup, including autoconfiguration of the
client and routing of arbitrary subnets from the client to the server or
from the server to the client.

The patch (on stock upstream OpenVPN) and some rough documentation can
be found at http://www.greenie.net/ipv6/openvpn.html . We are also
maintaining the code in git to ease development. There are a public
git-repository on my personal git server

git://git.birkenwald.de/openvpn.git with the following branches:
* upstream (fetched from http://github.com/jjo/openvpn-ipv6/ stock
  branch, which again comes from git-svn from the OpenVPN repository)
* jjo-ipv6 (fetched again from jjo master branch, which is upstream 
  with the additional patches for IPv6 _transport_ (not related to this
  project)
* gert-ipv6 (upstream + gert's patches for IPv6 payload)

There is also a jjo+gert branch which merges both branches.  There was a
small conflict in one function in mroute.c, but that is only cosmetical.
We're working on getting that aligned.

Additionally I have built Debian/Ubuntu binary packages (no guarantees
whatsoever) which are available on my Launchpad PPA at
https://launchpad.net/~berni/+archive/ipv6 . They say Ubuntu
Intrepid/Karmic but run on Debian Lenny just fine. They are however
based on the Debian OpenVPN package from testing (which also includes
jjo's IPv6 transport patch), so they might introduce additional bugs not
present in the stable series. Use at your own risk.

The patched binaries have been tested on a number of OpenVPN installations,
with a large number of different clients (mostly unpatched, some with
IPv6 patches) connecting to patched servers, and we have not seen any
instabilities yet.  So we consider this "safe for more wider-scale testing
and peer review".

So what's left to do? Windows support for IPv6 is completely
unimplemented at the moment, that part of the code would love to see
someone familiar with the platform. Documentation (which is my primary
responsibility, so I'd love to see patches from all of you :-) ) is
pretty much missing.  And of course, testing, testing, testing...

We would love to hear your thoughts and results about it.

Best Regards,
Bernhard and Gert


