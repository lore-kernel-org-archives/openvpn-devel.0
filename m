Date: Sun, 21 Feb 2010 21:14:16 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100221201416.GQ9556@...1296...>
References: <7bb795fd1002211100l760645cfl1a3cfc07ebd91e4@...278...>
	<20100221193132.GO9556@...1296...>
	<20100221200311.11614.qmail@...1287...>
Mime-Version: 1.0
In-Reply-To: <20100221200311.11614.qmail@...1287...>
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

Hi,

On Sun, Feb 21, 2010 at 09:03:11PM +0100, Peter Stuge wrote:
> Gert Doering wrote:
> > I'll try to figure out how to setup a cross-compile environment 
> > during next week,
> 
> Some Linux distributions have premade mingw packages.
> 
> In Gentoo building a toolchain for mingw is as simple as:
> 
> emerge crossdev && crossdev -t i686-mingw32
> 
> On other distributions you might benefit from Dan Kegel's crosstool:
> 
> http://kegel.com/crosstool/
> 
> Then run ./configure --host=i686-mingw32 && make in the OpenVPN
> source tree to build using the cross-toolchain.

Thanks for that.  I was googling in parallel, and that's exactly
what is going on in the background here right now (crossdev building 
the mingw environment) :-)

I saw a note here on the list a few weeks ago pointing to the opensc
"build" tool, and I'll try that, as soon as the cross-tools are done.

gert

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

