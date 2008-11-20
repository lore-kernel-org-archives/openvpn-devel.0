Message-ID: <4925A138.4070800@...1114...>
Date: Thu, 20 Nov 2008 18:41:12 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <200811121224.mACCOmfd077621@...1141...>
	<200811201644.mAKGiouf045674@...1141...>
In-Reply-To: <200811201644.mAKGiouf045674@...1141...>
Subject: Re: [Openvpn-devel] [patch] enhance compatibility with
	HTTP/1.1	proxies
Reply-To: dazo@...384...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Frank Behrens <frank@...1140...>
Cc: openvpn-devel@lists.sourceforge.net, Matthias Andree <ma+ovpnd@...31...>

Frank Behrens wrote:
> Hi Matthias!
> 
> Matthias Andree <ma+ovpnd@...31...> wrote on 12 Nov 2008 14:36:
>> On Wed, 12 Nov 2008, Frank Behrens wrote:
>>
>>> James Yonan <jim@...41...> wrote on 4 Nov 2008 12:16:
>>>> Shouldn't you check p->options.http_version and make sure it's >= 1.1 
>>>> before sending the Host header?
>>> Here is a revised patch, that works for me and implements your 
>>> suggestion:
>> Sorry Frank,
>>
>> I have to object. It does not implement James's suggestion as you claim,
> 
> Ok, this was a mistake. I implemented the solution I proposed on this list in my mail from 05 
> Nov 2008 
> (<4911D76D.7020202@...1140...>).
> 
>> but random guesswork - inadequate for security software and prone to
>> breaking at later updates.
> 
> I would not say "random guesswork".
> 
>>> --- proxy.c.orig	2008-10-06 09:22:20.000000000 +0200
>>> +++ proxy.c	2008-11-06 20:49:55.000000000 +0100
>>> @@ -348,6 +348,14 @@ establish_http_proxy_passthru (struct ht
>>>    if (!send_line_crlf (sd, buf))
>>>      goto error;
>>>  
>>> +  /* send Host: header for HTTP version above 1.0 */
>>> +  if (strcmp(p->options.http_version, "1.0") != 0) {
>> This doesn't check for ">= 1.1", but "!= 1.0".
>> What if I use 0.9, or garbage, or nothing?
>> Oops, you lose -- in either case.
> 
> What have we currently? Only HTTP/1.0 and HTTP/1.1. 
> 0.9 does not matter, it defines GET only, has not headers is not able to proxy HTTPS 
> connections. So my solution handles backward compatibility without problems. The 
> remaining question is how to handle future upward compatibility. You never know, what you 
> will get. So we can either:
> - disable all future protocol version the user may configure or
> - hope that the protocol is upwards compatible.
> 
> I decided to implement the 2nd solution, because the other parts are already implemented 
> this way. The user may already use arbitrary protocol versions.
> 
>> You may want to accept only 1.0 and 1.1 rather than 1.0 and 1.n for n >= 1
>> - but there should only ever be A SINGLE PLACE to enforce that.
>>
>> Else you'll have a hell of work once you start implementing HTTP/1.2
>> later on...
> 
> But then this check must no be done for the Host: header, but for the complete proxy 
> support. I see your objections, but "my" additional header does not introduce an additional 
> security problem, all other proxy setup code is already version independent.
> May be "CONNECT HTTP/2.0" will directly connect to the NSA/BND/(insert your favorite 
> agency here)? ;-)

I'd say that if you have a routine which handles HTTP/1.x, you should be 
pretty safe.  At the moment 0.9, 1.0 and 1.1 is what's in use.  0.9 I would 
not care about now, as that one is underspecified and proper RFC is 
completely missing (afaik).  If I'm not mistaken, 0.9 is the version used 
by clients not supporting all 1.0 features.  I think a work on a HTTP/2.0 
protocol did also start but nobody has brought that to life. (you might 
find some references which is about 10 years old or so)

So make sure 1.0 and 1.1 is handled properly, and you're safe.  I'd say 
that 1.2+ can at the moment be handled as 1.1, as the protocols usually is 
backwards compatible.  And I would rather reject 2.0 and 0.9 protocols, as 
they most probably should be considered undocumented at the moment.


kind regards,

David Sommerseth


