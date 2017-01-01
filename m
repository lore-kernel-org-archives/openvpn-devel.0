References: <024d01d26459$2589a3d0$709ceb70$@gmail.com>
From: Steffan Karger <steffan@...1856...>
Message-ID: <95e34ede-d810-4eec-3eba-b39af9b65749@...1856...>
Date: Sun, 1 Jan 2017 19:17:15 +0100
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
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 01-01-17 19:01, Fish Wang wrote:
> I'm finishing up a patch to make sure OpenVPN compiles under Visual Studio.
> I have several questions;
> 
> - Do you want to apply such a patch to master and/or release/2.4, or should
> I maintain it separately?

Yes, we intend to keep OpenVPN compilable under MSVC, and accept patches
to make that work (provided the patch is good, etc.).  Not many (if
any?) of the frequent patch authors actually use MSVC themselves, so we
unfortunately break compilation in MSVC every now and then.

> - What is the minimum version of Visual Studio do we want to support?

We require full C99 support, so iirc that means at least VS2015.  But
you are most likely better informed than I am.

> - Should such a patch be developed against maste, release/2.4 branch, or
> both?

master, and then probably cherry-picked back to release/2.4.

-Steffan

