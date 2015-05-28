MIME-Version: 1.0
In-Reply-To: <20150528140036.GW382@...1296...>
References: <1429540256-4906-1-git-send-email-yegorslists@...1030...>
	<20150421075848.GA7377@...2009...>
	<CAGm1_kt0bzLW_1Bwf7prZW2f7PvrBxO0heEjWe0EaQaFFk=JuA@...278...>
	<20150528140036.GW382@...1296...>
From: Yegor Yefremov <yegorslists@...1030...>
Date: Thu, 28 May 2015 16:14:12 +0200
Message-ID: <CAGm1_kuNqwu1BUkV=EK3Y4g6xuVS0TbJOn5xU8jiwm7v61CGLw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] cert_data: fix memory leak
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, May 28, 2015 at 4:00 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Thu, May 28, 2015 at 02:21:44PM +0200, Yegor Yefremov wrote:
>> On Tue, Apr 21, 2015 at 9:58 AM, Vasily Kulikov <segoon@...2008...> wrote:
>> > On Mon, Apr 20, 2015 at 16:30 +0200, Yegor Yefremov wrote:
>> >> Release pCertName, if SecCertificateCopyValues() fails.
>> >>
>> >> Found via cppcheck.
>> >>
>> >> Signed-off-by: Yegor Yefremov <yegorslists@...1030...>
>> >> Cc: Vasily Kulikov <segoon@...2008...>
>> >
>> > Acked-by: Vasily Kulikov <segoon@...2008...>
> [..]
>> Could you please take a look at this patch?
>
> Looks reasonable to me, and if Vasily as the primary author acks it,
> fine to me.  I'll merge it ASAP, though it would make my life easier
> if I had the original mail (on the openvpn-devel list) to feed into
> "git am"... :-)

Do you mean this one
http://article.gmane.org/gmane.network.openvpn.devel/9600 or should I
just include you in CC next time I send a patch?

>> Btw. do you have a Jenkins or buildbot instance running for OpenVPN?
>>
>> I'm monitoring some OSS projects with Jenkins and cppcheck plugin.
>
> Buildbot, yes.  http://community.openvpn.net/openvpn/wiki/OpenVPN_QA
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //www.muc.de/~gert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...

