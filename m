References: <1497897488-15999-1-git-send-email-chipitsine@...277...>
	<201706211957.v5LJv8M1076904@...2054...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <fe23e999-4d93-f90a-674e-3bd608497fba@...1856...>
Date: Wed, 21 Jun 2017 22:50:00 +0200
MIME-Version: 1.0
In-Reply-To: <201706211957.v5LJv8M1076904@...2054...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH applied] Re: travis-ci: added gcc and
 clang openssl-1.1.0 builds
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
To: openvpn-devel@lists.sourceforge.net

The following have to be cherry-picked (just tested, works without fuzz):

56e6bd8967d72c4374389dfd5cf32f5e3b86242c
81ba70b39b78d7677aabab957421264800028f53
aeac1139a34321a7f770ca20bfef886a21a89fe9

-Steffan

On 21-06-17 21:57, Gert Doering wrote:
> Your patch has been applied to the master branch.
> 
> I tried to apply it to release/2.4 as well, but it seems some prior
> patch to the .travis/ stuff never made it, so this patch does not apply.
> 
> As I'm a bit lazy today - could you backport all the travis stuff that
> is missing from 2.4 to release/2.4 and send a patch for that?  thanks :)
> 
> commit aeac1139a34321a7f770ca20bfef886a21a89fe9 (master)
> Author: Ilya Shipitsin
> Date:   Mon Jun 19 23:38:08 2017 +0500
> 
>      travis-ci: added gcc and clang openssl-1.1.0 builds
> 
>      Acked-by: Steffan Karger <steffan.karger@...1435...>
>      Message-Id: <1497897488-15999-1-git-send-email-chipitsine@...277...>
>      URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14890.html
>      Signed-off-by: Gert Doering <gert@...1296...>
> 
> 
> --
> kind regards,
> 
> Gert Doering
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

