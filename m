Message-ID: <20100221200311.11614.qmail@...1287...>
Date: Sun, 21 Feb 2010 21:03:11 +0100
From: Peter Stuge <peter@...1287...>
References: <7bb795fd1002211100l760645cfl1a3cfc07ebd91e4@...278...>
	<20100221193132.GO9556@...1296...>
MIME-Version: 1.0
In-Reply-To: <20100221193132.GO9556@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] make ipv6_payload compile
	under	windowze ( feat_ipv6_payload branch )
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
To: openvpn-devel@lists.sourceforge.net

Gert Doering wrote:
> I'll try to figure out how to setup a cross-compile environment 
> during next week,

Some Linux distributions have premade mingw packages.

In Gentoo building a toolchain for mingw is as simple as:

emerge crossdev && crossdev -t i686-mingw32

On other distributions you might benefit from Dan Kegel's crosstool:

http://kegel.com/crosstool/


Then run ./configure --host=i686-mingw32 && make in the OpenVPN
source tree to build using the cross-toolchain.


//Peter

