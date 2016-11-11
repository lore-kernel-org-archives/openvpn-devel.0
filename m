References: <1478609729-25222-5-git-send-email-samuli@...515...>
	<1478613043-27033-1-git-send-email-samuli@...515...>
	<68076cb3-b018-28c7-0776-85f8a7212e38@...277...>
	<20161111075846.GY28918@...1296...>
	<7be9cd74-894a-455a-0471-a102fe4077e8@...515...>
From: debbie10t <debbie10t@...277...>
Message-ID: <138786e6-6e44-bea0-4d79-9840fcb0189e@...277...>
Date: Fri, 11 Nov 2016 10:50:16 +0000
MIME-Version: 1.0
In-Reply-To: <7be9cd74-894a-455a-0471-a102fe4077e8@...515...>
Subject: Re: [Openvpn-devel] [PATCHv2 4/4] Allow passing extra arguments to
 fping/fping6 in t_client.rc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net



On 11/11/16 09:53, Samuli Sepp=E4nen wrote:
> Il 11/11/2016 09:58, Gert Doering ha scritto:
>> Hi,
>>
>> On Fri, Nov 11, 2016 at 12:25:49AM +0000, debbie10t wrote:
>>> On 08/11/16 13:50, samuli@...515... wrote:
>>>> From: Samuli Sepp=E4nen <samuli@...515...>
>>>
>>>> +    $cmd -b $bytes -C 20 -p 250 -q $FPING_EXTRA_ARGS $targetlist
>>>> >>$LOGDIR/$SUF:fping.out 2>&1
>>>
>>> This allows $FPING_EXTRA_ARGS to take precedence over previous arguments
>>>
>>> eg: $FPING_EXTRA_ARGS =3D "-C 1000 -p 1000 -i 1000"
>>
>> Right, which was the point of "v2" :-) - it's a good way to shoot your
>> own foot, but this is an "expert mode knob".

OK, I misunderstood the requirement but now that is clear.

>>
>>> This does not:
>>> $cmd $FPING_EXTRA_ARGS -b $bytes -C 20 -p 250 -q $targetlist
>>> $LOGDIR/$SUF:fping.out 2>&1
>>
>> Right, which was v1.
>>
>> gert
>
> In any case, thanks for the review to both of you!

Doing my best :-)


