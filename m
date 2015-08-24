Message-ID: <55DB6DD8.4040203@...277...>
Date: Mon, 24 Aug 2015 21:17:44 +0200
From: Jiri Horky <jiri.horky@...277...>
MIME-Version: 1.0
References: <551A5509.702@...277...> <20150824181826.GD34798@...1296...>
In-Reply-To: <20150824181826.GD34798@...1296...>
Subject: Re: [Openvpn-devel] Increasing TUN_MTU_MIN to make connection
 establishment faster
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
To: Gert Doering <gert@...1296...>
Cc: FF Systems <ff-system@...2025...>, openvpn-devel@lists.sourceforge.net

Hi Gert,

thanks for the information. I see you effectively increased the size to
1.2k which, as far as I know, will not work for people with dial ups.
Surprisingly, it seems there is still some 3% [1] of people having that
type of Internet connection.

I wonder, if you considered this or not, or if there is a mean in
OpenVPN code which will make OpenVPN work even in these case (without
user interaction).

Regards
Jiri Horky

[1] http://time.com/3856066/aol-verizon-deal-dial-up-internet/

On 08/24/2015 08:18 PM, Gert Doering wrote:
> Hi,
>
> On Tue, Mar 31, 2015 at 10:04:25AM +0200, Jiri Horky wrote:
>> continuing yesterday's IRC discussion. I would like to ask whether you
>> can think of a reason why TUN_MTU_MIN is set to only 100 bytes, and
>> maybe more importantly, why this value is effectively enforced in function
> I'm not sure if you've been following the list and/or git master
> commits, but we have somehing in master for a while now...
>
> commit fc91d4b0071178e298052078431fb86f03be84fc (master)
>
> Author: Steffan Karger
> Date:   Tue Jun 30 21:44:56 2015 +0200
>
>      Increase control channel packet size for faster handshakes
>
>      Signed-off-by: Steffan Karger <steffan@...1856...>
>      Acked-by: Gert Doering <gert@...1296...>
>      Message-Id: <1435693496-10931-1-git-send-email-steffan@...1856...>
>      URL: http://article.gmane.org/gmane.network.openvpn.devel/9841
>      Signed-off-by: Gert Doering <gert@...1296...>
>
>
> ... and as far as we can see, this "just works" (and OpenVPN 3 on iOS
> and Android also uses larger packets for the control channel, so we're
> just following suit here).
>
> So, if you run git master, you already have it :-) - and if you run 2.3.x,
> you can just cherry-pick the patch, it should apply easily.
>
> (It will eventually hit 2.3.9 or 2.3.10, but I want to wait for a bit
> more feedback from the "early testers")
>
> gert
>


