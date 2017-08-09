References: <1502207741-31750-1-git-send-email-steffan.karger@...1435...>
 <CAFHpkQG8Lw5Va2PHT=BA86z-WgXv2Lqe+r9Q+fBeFsgRniKSCw@...278...>
 <CAFHpkQE+2_BCADNJFVDreLagvhNONQP8eP_s7W4s835ChfSpiA@...278...>
 <CAFHpkQHNoM+zRjALQ5vxYQ8jG6oY=8jDzHihfSKDjt4YKaAtyA@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <ad14aa0a-4741-381a-8811-319b7726f349@...1856...>
Date: Wed, 9 Aug 2017 22:09:20 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHNoM+zRjALQ5vxYQ8jG6oY=8jDzHihfSKDjt4YKaAtyA@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Add coverity static analysis to Travis
 CI config
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 09-08-17 08:12, Илья Шипицин wrote:
> 2017-08-09 10:47 GMT+05:00 Илья Шипицин <chipitsine@...277...
> <mailto:chipitsine@...277...>>:
>     2017-08-09 10:41 GMT+05:00 Илья Шипицин <chipitsine@...277...
>     <mailto:chipitsine@...277...>>:
>         2017-08-08 20:55 GMT+05:00 Steffan Karger
>         <steffan.karger@...1435... <mailto:steffan.karger@...1435...>>:
> 
>             Enable coverity analysis for the release/2.4 branch.
> 
>             We can only do a limited number of coverity scans per week
>             with our FOSS
>             account, but since we only occasionally push commits, that
>             should work out
>             fine.  But this limit is the reason we don't use the
>             standard travis addon,
>             because that would cause the coverity script to run on all
>             of our matrix
>             builds.  That would cause us to reach our limit faster, and
>             waste travis'
>             resources.
> 
>             Since our FOSS coverity account doesn't handle multiple
>             branches very well,
>             we have to pick one branch to run coverity on.  I think it's
>             best to use
>             the most recent stable branch for that (i.e. for now,
>             release/2.4).
>             Though for ease of maintenance, it's probably best to apply
>             the patch to
>             both master and release/2.4.
> 
>         I would refactor it like that
>         https://gist.github.com/chipitsine/8dcae4ff1d59eb43df39f6015c6106fd
>         <https://gist.github.com/chipitsine/8dcae4ff1d59eb43df39f6015c6106fd>
>         however, your is ok as well
> 
>     maybe, "script" would be better here
>     https://gist.github.com/chipitsine/8dcae4ff1d59eb43df39f6015c6106fd#file-gistfile1-txt-L74
>     <https://gist.github.com/chipitsine/8dcae4ff1d59eb43df39f6015c6106fd#file-gistfile1-txt-L74>
>     than "before_script"
> 
> oops, travis does not support braches within matrix
> 
> https://gist.github.com/chipitsine/8dcae4ff1d59eb43df39f6015c6106fd#file-gistfile1-txt-L70-L72
> 
> sorry for that

I like your idea, and toyed with it a bit.  But in the end, it needs too
much fiddling to get right.  So I prefer my own suggested approach.

-Steffan

