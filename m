MIME-Version: 1.0
In-Reply-To: <CABT9mj97qvvdif9wJw4iUZ+514_Xxo1ZUD=MtbZKB11PXpXYxg@...278...>
References: <CABT9mj_+3KRELoLQBGK5B14Q=Y_HGGjS48E6bEWnDPuCwBXgtw@...278...>
	<CAOazyz0zS1WjVrLv1u22ZN+cr18ewuzeZnc-5PrSHjss1Cn=ew@...278...>
	<CABT9mj9Xjs6T_hCA-pcEPUaoCe4ZxZ8-yGHB_MeDReM=wHBa8Q@...278...>
	<CABT9mj96OXMejAXm3bp3SxY-OHespaPV_tdiYcpCk01BoC94xg@...278...>
	<CAOazyz1vHGfX-M+h7LEgXDA=1d0f_stRqvH08U9b++5gddWAPg@...278...>
	<CABT9mj97qvvdif9wJw4iUZ+514_Xxo1ZUD=MtbZKB11PXpXYxg@...278...>
Date: Tue, 13 Mar 2012 21:05:06 +0200
Message-ID: <CAOazyz3F1kdntVEgRdwE4ZeG+5=ov-1szEom27s2GE6ySN4Sbw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] mingw32-built openvpn-2.3-alpha1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Athanasios Douitsis <aduitsis@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Mar 13, 2012 at 8:59 PM, Athanasios Douitsis <aduitsis@...277...> wrote:
> A question then: The generic method is supposed to be invoked from cmd or
> from the cygwin shell? Because I suspect the cygwin bash shell dislikes the
> carriage returns in the build script so naturally one must convert the files
> before running it. Even after converting, I saw further errors, but I want
> to view them carefully before reporting.

yes, cygwin.
How come you have carriage returns?
If there were I could not build this in Linux...
Probably something in your git settings?
Best if you install git in cygwin as well and clone it using this git.

Alon.

