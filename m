From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 22 Oct 2015 17:29:54 +0300
Message-ID: <5628F2E2.1050500@...277...>
References: <1445519360-24866-1-git-send-email-lstipakov@...277...>
	<20151022132635.GF22054@...1296...>
	<1445521155.4113.71.camel@...1866...>
	<CA+UdHn9f9reNrCCdtw8+Ei2KZ9_2beDPCL9Vb-JGs2jJ5nnrXw@...278...>
	<20151022135158.GG22054@...1296...>
	<1445522144.4113.79.camel@...1866...>
	<20151022135935.GH22054@...1296...>
Mime-Version: 1.0
In-Reply-To: <20151022135935.GH22054@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Use adapter index instead of name
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

Hello,

 > And with interface indexes, it works all the time?

We have tested it on a few machines which previously have had this 
problem and this patch has fixed that. We will test it for larger 
audience in near future and report results.

-Lev


On 22.10.2015 16.59, Gert Doering wrote:
> hi,
>
> On Thu, Oct 22, 2015 at 02:55:44PM +0100, David Woodhouse wrote:
>>> So what is the underlying issue here?  Non-ASCII characters in the
>>> device name ("this *should* have been fixed a few releases ago")?
>>
>> No, and not spaces (despite the vpn.ccrypto.org link above suggesting
>> that it is).
>
> Spaces are known to not cause issues ("I do test things" :-) ).
>
>> The issue is not known. Seriously, "because Windows".
>>
>> Renaming the interface, and then renaming it back to precisely what it
>> was before, and doing registry dumps and checking that things really
>> *are* just the same as they were before, is sufficient to fix it.
>
> Urgh.
>
> And with interface indexes, it works all the time?  In that case, we'll
> just change over... (the new rgi6 stuff uses interface indexes for routing
> anyway)  ((meh, git master really is different from 2.3 code here...))
>
> gert
>
>
>
> ------------------------------------------------------------------------------
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>



