MIME-Version: 1.0
In-Reply-To: <20101214202845.28190.qmail@...1287...>
References: <AANLkTi=Fykb-NkSxx+=HM1U0ob4mmD0GkyfP_Mhb9=m1@...278...>
	<1292286924.6222.3.camel@...1259...>
	<AANLkTikhRr-YhNP4OaZM8kCJ++-OcKh=eQ9jAeedxjNj@...278...>
	<4D07AEC7.3010408@...1114...>
	<AANLkTik0razPaAEqNSNEYgsoH_sczjUSj7fbgVsVraYy@...278...>
	<20101214194612.17985.qmail@...1287...>
	<AANLkTikwK2_A+MEEWwy+TeM=K5T-BV7GemTsbY6jgzq=@mail.gmail.com>
	<20101214202845.28190.qmail@...1287...>
Date: Tue, 14 Dec 2010 14:22:53 -0800
Message-ID: <AANLkTi=GLcQr-S8B8GT3nHmsPm7uiQRSRTr1zTytiE1u@...278...>
From: Vineet Kumar <vineet.kumar@...277...>
Subject: Re: [Openvpn-devel] Can *plugin* kill specific ovpn tunnel?...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Sorry pl. explain the "intermediary" part. Is that supposed to solve
the single telnet server accepting multiple *concurrent* client
sessions?

The interactive session part: not a requirement but we have no way to
disallow an interactive user from telnetting when we programmatically
plan to use the same IP:port.

Vineet
On Tue, Dec 14, 2010 at 12:28 PM, Peter Stuge <peter@...1287...> wrote:
> Vineet Kumar wrote:
>> You mean closing the telnet session after every use so that whoever
>> the next guy is gets served?
>
> No I mean creating an intermediary that will know about your use case
> and provide an interface that works.
>
>
>> say, an interactive telnet session
>
> Are they a requirement in your use case?
>
>
> //Peter
>
> ------------------------------------------------------------------------------
> Lotusphere 2011
> Register now for Lotusphere 2011 and learn how
> to connect the dots, take your collaborative environment
> to the next level, and enter the era of Social Business.
> http://p.sf.net/sfu/lotusphere-d2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

