References: <024d01d26459$2589a3d0$709ceb70$@gmail.com>
From: Gisle Vanem <gvanem@...2101...>
Message-ID: <c1fff25e-28c8-7d3a-42fb-611b489c643a@...2101...>
Date: Mon, 2 Jan 2017 11:23:49 +0100
MIME-Version: 1.0
In-Reply-To: <024d01d26459$2589a3d0$709ceb70$@gmail.com>
Subject: Re: [Openvpn-devel] Visual Studio support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Fish Wang wrote:

> I'm finishing up a patch to make sure OpenVPN compiles under Visual Studio.
> I have several questions;

I'm also compiling using TDM-MinGW and MSVC-2015. But since approx 2 years,
the CL compiler breaks at compiling options.c:
  src/openvpn/options.c(7937): fatal error C1026: parser stack overflow, program too complex

Did you manage to work around that?

I'm using  the latest CL v.19.00.24215.1. I also reported this 2 years ago in:
  https://sourceforge.net/p/openvpn/mailman/message/34683175/

-- 
--gv

