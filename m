References: <20161108124506.32559-1-gert@...1296...>
	<201611092014.uA9KErZf048132@...2054...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <8feec195-c9ed-a0bb-31c5-459bf9757ce6@...68...>
Date: Fri, 11 Nov 2016 19:25:57 +0100
MIME-Version: 1.0
In-Reply-To: <201611092014.uA9KErZf048132@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Repair topology subnet on
 FreeBSD 11
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 09.11.2016 um 21:14 schrieb Gert Doering:
> Thanks for testing & review :-)
>
> Patch has been applied to the master and release/2.3 branch.
>
> commit a433b3813d8c38b491d2baa7b433973f2d6cd7c6 (master)
> commit 446ef5bda4cdc75d4cb955e274846faff0181fd3 (release/2.3)
> Author: Gert Doering
> Date:   Tue Nov 8 13:45:06 2016 +0100
>
>      Repair topology subnet on FreeBSD 11
>
>      URL: https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=207831
>      Signed-off-by: Gert Doering <gert@...1296...>
>      Acked-by: Steffan Karger <steffan.karger@...1435...>
>      Message-Id: <20161108124506.32559-1-gert@...1296...>
>      URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12950.html
>      Signed-off-by: Gert Doering <gert@...1296...>

This is now part of FreeBSD's openvpn 2.3.13_1 (on the port's head) and
masked by an option that I enable by default and that I've dubbed
FIXSUBNET. <https://svnweb.freebsd.org/ports?view=revision&revision=425811>.

If nothing new crops up, I can request to merge this back to the
quarterly (stable) branch and drop the option if someone deems this
urgent, else it will propagate to stable ports in early January 2017. I
should probably kick the option before then and make this patch regular
(unless 2.3.14 is out sooner, but I understand if people want to focus
on getting 2.4.0 into Debian).

