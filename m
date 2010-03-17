Message-ID: <4BA159B8.1000508@...1114...>
Date: Wed, 17 Mar 2010 23:37:44 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1268855205316802500@...1315...>
	<4BA1433A.8090808@...1114...>
	<1268862004900065500@...1315...>
	<4BA1511E.5060202@...1114...>
	<1268863262384008500@...1315...>
In-Reply-To: <1268863262384008500@...1315...>
Subject: Re: [Openvpn-devel] Bytecount Reporting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn@...1315...
Cc: openvpn-devel@lists.sourceforge.net

On 17/03/10 23:01, openvpn@...1315... wrote:
> Hi,
> 
> All very good questions! Some thoughts, below.
> 
> Thanks for all your help!
> ... Russell
> 
> On Wed, Mar 17, 2010 05:01 PM, David Sommerseth <openvpn.list@...1114...> wrote:
>>
> On 17/03/10 22:40, openvpn@...1315... wrote:
>>> Hi,
>>>
>>>
>>>
>>> I'm running OpenVPN (client) on Windows - connecting to a Linux Server. 
>>
>> I'm presuming you're connecting to the management interface on the Linux
>> server.
> Russell: No, on the local client (i.e. on Windows). This avoids having to send information over the link (=wasted bandwidth, and lower speed).
>>
>>> I am wondering if a value isn't reported if there is no traffic - that could be part of this 
>>
>> I have a feeling this is the reality. As I don't see any timer alarms
>> scheduled in the management part of the code. So I need to see this
>> more in connection with the main part of the event loop code. But I
>> believe this is the case.
>
> Russell: Understood - if it is please just let me know.

Will do!

>>> (though it would be better to report information anyways).
>>>
>>> Make sense?
>>
>> Yeah, I can see your point. But isn't the information going to be
>> rather useless if it hasn't changed? If there is no change, no need to
>> dump the same info once again. What do you think?
>
> Russell: I understand your point, but I'm also wanting to show transfer rate, and plot the data (which would be easiest if the data arrives uniformly). Not a huge issue, but I would to at least like to understand why this is the case. I guess if this is the way it works it should at least be captured in the documentation for the Management Interface, right?

I'll definitely look into this!  And if the behaviour is in need of
network traffic, updating the docs is always the quickest and safest
update we can do :)


kind regards,

David Sommerseth




>>> On Wed, Mar 17, 2010 04:01 PM, David Sommerseth <openvpn.list@...1114...> wrote:
>>>
>>>
>>>>
>>> On 17/03/10 20:46, openvpn@...1315... wrote:
>>>>> Hi,
>>>>>
>>>>> I am trying to write an application that monitors traffic over an OpenVPN link - by using bytecount information from the management interface. However, after I telnet in, and enter "bytecount 1" (for 1 second updates), I find that the real-time bytecount updates are not really every second. They seem to be initially, but soon slow down (to an update every 5-10 seconds).
>>>>>
>>>>> Is this expected, or a known issue?
>>>>
>>>> Hi,
>>>>
>>>> I'd say this is probably unexpected. But I'd like to know a little bit
>>>> more about your setup. What kind of OS are you running OpenVPN?
>>>>
>>>> It sounds like your OpenVPN process get lower priority somehow. But it
>>>> could also be that it is dependent on the amount of traffic passing over
>>>> the tunnel. I'll dig more into the code to see if there are some
>>>> oddities there before concluding.
>>>>
>>>>
>>>> kind regards,
>>>>
>>>> David Sommerseth
>>>>
>>
>>


