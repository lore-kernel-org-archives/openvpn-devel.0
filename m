Message-ID: <53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
In-Reply-To: <b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
Date: Tue, 4 Apr 2017 08:29:49 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Add per session pseudo-random component
 to --reneg-sec intervals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

>> Hi,
>>
>> Initially I've created this RFE but have been told to send it to
>> the devel list instead:
>>
>> https://community.openvpn.net/openvpn/ticket/865
>>
>> Unfortunately I'm not a developer and have never used git so please bear
>> with me as I send a classic patch to the list.
>>
>> As suggested by user "syzzer" I also tried to improve the patch and here
>> it is:
>>
>> -------%<---------------------------------------------------------------
>> While we were suffering from the "TLS Renegotiation Slowdown" bug here
>> https://community.openvpn.net/openvpn/ticket/854 we realized that there
>> is
>> still room for improvement in our use case.
>>
>> It appears that TLS renegotiation is getting more and more expensive in
>> terms of CPU cycles with recent changes for more security. To make
>> things
>> worse, we realized that most renegotiation procedures took place at
>> almost
>> the same time and increased the CPU load too much during these periods.
>> That's especially true on large, multi-instance openvpn setups.
>>
>> I've created attached patch to add a per session pseudo-random component
>> to
>> the --reneg-sec intervals so that renegotiation is evenly spread over
>> time.
>> It is configured by simply adding a second value to --reneg-sec as
>> described
>> in the --help text:
>>
>> --reneg-sec n [r] : Renegotiate data chan. key after n seconds
>> default=3D3600)
>>                     and if r is specified, add a per session
>> pseudo-random
>>                     component in the range of 1 ... r to n (default=3D0).
>>
>> Note that the patch also slightly changes the log output to show the sec
>> value
>> in the same way as the bytes/pkts values:
>>
>> TLS: soft reset sec=3D3084/3084 bytes=3D279897/-1 pkts=3D1370/0
>> -------%<---------------------------------------------------------------
>>
>>
>> The patch is tested and seems to work well in my environment. As always,
>> comments are very welcome.
>>
>> Would be nice to have this patch accepted and included in OpenVPN 2.4.2.
>
> Any comments on this patch? Would be nice to get some feedback :)
>
> Simon

Interesting to see that there is zero interest in this patch here.

I'm very sure a lot of people are suffering this issue without knowing it.
On heavy loaded multi instance servers OpenVPN tends to lose packets every
hour (with default reneg-sec settings).

That's only in a short period of time but still very annoying for things
like VoIP over the VPN links.

We only found this out after the problem became worse with the bug
mentioned above introduced in OpenVPN 2.4.0. The problem has always been
there but we only became aware of it with the 2.4.0 release.

I guess I'll change the patch then to work without any changes to the
config. That way our binary builds are still compatible with the upstream
version but still improve the issue mentioned above.

For those interested to see how the problem shows up, try this:

Run "prettyping -i 0.1 <destination>" to different locations in different
terminals and let it run for a longer time. You will easily see the hourly
packet losses in the patterns. Prettyping is here
https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping

Regards,
Simon


