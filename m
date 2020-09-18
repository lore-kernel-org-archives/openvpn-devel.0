References: <20200914070843.51678-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <1bf8d72c-6ba3-bc70-194f-708c893e9cb3@...2181...>
Date: Fri, 18 Sep 2020 09:28:14 +0200
MIME-Version: 1.0
In-Reply-To: <20200914070843.51678-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Fix combination of --dev tap and
 --topology subnet across multiple platforms.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 14/09/2020 09:08, Gert Doering wrote:
> --topology should have no effect in tap mode (tap is always "subnet"),
> but due to the way options are checked, setting "topology subnet" caught
> an improper branch on all non-linux and non-win32 platforms.
> 
> Easily tested by adding "--topology subnet" to a "--dev tap" t_client
> test.
> 
> Tested, verified, and fixed on FreeBSD 13.3, NetBSD 8.1, OpenBSD 6.5,
> OpenIndiana 2019 (Solaris) and MacOS X Mojave.
> 
> This is a forward-port of commit 6c13e24e5709 - the original intent
> for "master" was to restructure tun.c in a larger way and clean up
> these if() blocks more nicely... which has not happened yet, so this
> patch is basically applying exactly the same changes to context that
> has changed too much for git to be able to do this automatically.
> 
> Trac: #1085
> 
> Signed-off-by: Gert Doering <gert@...1296...>

This change is very well contained and straightforward.
It just does what it says and makes the if-branches more clear.

Acked-by: Antonio Quartulli <a@...2181...>



-- 
Antonio Quartulli

