References: <20210317220642.38741-1-openvpn@...2080...>
 <202103180744.12I7iaE2073329@...2054...>
 <CAFHpkQF9Ga24wHjGOPAf+v+fZ7qCpmGOW-Ms9fTBiFuYHcrgTg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <05ed2a99-1de5-854d-9809-4c5145e7c67d@...2080...>
Date: Thu, 18 Mar 2021 18:35:58 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQF9Ga24wHjGOPAf+v+fZ7qCpmGOW-Ms9fTBiFuYHcrgTg@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH applied] Re: build: Remove compat-lz4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Gert Doering <gert@...1296...>, samuli.seppanen@...277...
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 18/03/2021 12:14, Илья Шипицин wrote:
> this probably will break windows cross compile (it uses lz4 bundle).
> 
> Samuli, can you please keep any eye on it  (new test installer maybe) ?

Is it too early to consider --disable-lz4 all together?  Maybe try that 
initially for the 2.6 and see how well it is received by beta/rc 
testers.  And further, for 2.7 we can consider having --enable-comp-stub 
by default.

I can do a similar move with the Fedora Copr openvpn-git development builds.


-- 
kind regards,

David Sommerseth
OpenVPN Inc



> чт, 18 мар. 2021 г. в 12:45, Gert Doering <gert@...1296... 
> <mailto:gert@...1296...>>:
> 
>     Acked-by: Gert Doering <gert@...1296...
>     <mailto:gert@...1296...>>
> 
>     I have tested compilation "with default options" on FreeBSD with lz4
>     (works), Gentoo without lz4 (errors out), Gentoo with lz4 (works), and
>     with --disable-lz4 on Gentoo without lz4 (works).
> 
>     I assume some of the buildbots will need a bit of tending now (because
>     "no lz4 installed, since we bundle it anyway").  They will tell me...
> 
>     Your patch has been applied to the master branch.
> 
>     commit 24596b258aa3a9c0bd79e7e7bd4753c48a435408
>     Author: David Sommerseth
>     Date:   Wed Mar 17 23:06:42 2021 +0100
> 
>           build: Remove compat-lz4
> 
>           Signed-off-by: David Sommerseth <davids@...515...
>     <mailto:davids@...515...>>
>           Acked-by: Gert Doering <gert@...1296...
>     <mailto:gert@...1296...>>
>           Message-Id:
>     <20210317220642.38741-1-openvpn@...2080...
>     <mailto:20210317220642.38741-1-openvpn@...2080...>>
>           URL:
>     https://www.mail-archive.com/search?l=mid&q=20210317220642.38741-1-openvpn@...2080...
>     <https://www.mail-archive.com/search?l=mid&q=20210317220642.38741-1-openvpn@...2080...>
>           Signed-off-by: Gert Doering <gert@...1296...
>     <mailto:gert@...1296...>>
> 
> 
>     --
>     kind regards,
> 
>     Gert Doering
> 
> 
> 
>     _______________________________________________
>     Openvpn-devel mailing list
>     Openvpn-devel@lists.sourceforge.net
>     <mailto:Openvpn-devel@lists.sourceforge.net>
>     https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>     <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>
> 


-- 
kind regards,

David Sommerseth
OpenVPN Inc


