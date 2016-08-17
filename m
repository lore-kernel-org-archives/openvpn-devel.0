From: debbie10t <debbie10t@...277...>
References: <57A87572.6080306@...277...>
	<20160808122011.GC78279@...1296...> <57A896DD.1020004@...277...>
	<a04e17d1-27b9-0415-3625-12c255f2f010@...277...>
	<20160817195057.GZ78279@...1296...>
	<CAKuzo_gWMVtY7ELs4qcx8y1EpNJPsFaQ2P7nC-pXNKkQR9NhBg@...278...>
	<20160817205638.GC78279@...1296...>
Message-ID: <161d5e0b-4a3f-30fe-6869-c96a6702fa03@...277...>
Date: Wed, 17 Aug 2016 23:08:35 +0100
MIME-Version: 1.0
In-Reply-To: <20160817205638.GC78279@...1296...>
Subject: Re: [Openvpn-devel] Is --ifconfig-ipv6-noexec planned ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi


On 17/08/16 21:56, Gert Doering wrote:
> Hi,
>
> (copying openvpn-devel back in, as Selva has a surprising explanation
> for this)
>
> On Wed, Aug 17, 2016 at 04:40:05PM -0400, Selva Nair wrote:
>> If the problem is on windows I believe this may be related to
>> ifconfig_noexec being
>> reset on windows to ip_win32_type = manual, or some such. Then
>> do_ifconfig will get called and the ip setting should get skipped inside
>> it. Recall
>> seeing it while looking into the code setting ipv6 by service. Don't have
>> access to the repo to be more precise..
> You are right:
>
>    if (options->ifconfig_noexec)
>      {
>        options->tuntap_options.ip_win32_type = IPW32_SET_MANUAL;
>        options->ifconfig_noexec = false;
>      }
>
> (in options.c)
>
> so indeed, it would call do_ifconfig() then, and explicitely not do IPv4,
> and then just go forward as if nothing had happened and *do* IPv6.
>
> What a horrible hack...  I hope we can get rid of this as soon as Heiko's
> "do windows in the normal order of things" patch has been fully tested
> and merged.
>
> I'll open a trac ticket as soon as I have proper Internet again, which
> is not paid by the kbyte...
>
> gert

Many thanks Gert and Selva for taking the time to look into this.

I am happy to open a trac ticket for you and attach all my details tomorrow.
save you some time for important stuff :-)

Regards


