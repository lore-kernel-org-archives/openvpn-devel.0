Message-ID: <20100902025621.19053.qmail@...1287...>
Date: Thu, 2 Sep 2010 04:56:21 +0200
From: Peter Stuge <peter@...1287...>
References: <AANLkTinjxHX-3baqYZARRT3SpYae8a-44CXNPkTXBXtC@...278...>
MIME-Version: 1.0
In-Reply-To: <AANLkTinjxHX-3baqYZARRT3SpYae8a-44CXNPkTXBXtC@...278...>
Subject: Re: [Openvpn-devel] Compiling OpenVPN for Windows
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

Allan Swanepoel wrote:
> I have a small customization that I make to the openvpn sourcecode to
> call external software on initialization, and would like to build a
> Windows build with this in.

Maybe your Linux distribution offers a simple way to install a
cross-compiler. Find out which host tuple you should use and then
do something like:

./configure --host=i686-mingw32 --prefix=/tmp/openvpn && make install

in order to cross-compile openvpn sources. As Gert pointed out,
binaries built with MinGW use public domain headers for the Win32 API
implemented by Microsoft's runtime, so no dependency that is not met
by any Windows system.


//Peter

