Message-ID: <552F6E7A.1000505@...515...>
Date: Thu, 16 Apr 2015 11:10:34 +0300
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1427784294-22175-1-git-send-email-samuli@...515...>
	<551A4A9B.6010508@...68...>
In-Reply-To: <551A4A9B.6010508@...68...>
Subject: Re: [Openvpn-devel] [PATCH] Remove useless dash escapes from the
 man-page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net


> Am 31.03.2015 um 08:44 schrieb samuli@...515...:
>> From: Samuli Sepp=E4nen <samuli@...515...>
>>
>> This patch is against the release/2.3 branch
>>
>> Trac: 512
>> Signed-off-by: Samuli Sepp=E4nen <samuli@...515...>
>> ---
>>   doc/openvpn.8 | 1800 ++++++++++++++++++++++++++++---------------------=
--------
>>   1 file changed, 900 insertions(+), 900 deletions(-)
>>
>> diff --git a/doc/openvpn.8 b/doc/openvpn.8
>> index a95d353..bcd2d76 100644
>> --- a/doc/openvpn.8
>> +++ b/doc/openvpn.8
>> @@ -37,7 +37,7 @@
>>   .TH openvpn 8 "17 November 2008"
>>   .\"*********************************************************
>>   .SH NAME
>> -openvpn \- secure IP tunnel daemon.
>> +openvpn - secure IP tunnel daemon.
> I am concerned this will cause misformattings and inability to search
> for options with leading dashes on some systems - I don't recall
> versions, but I do know that some systems used some sort of Unicode
> (soft?) hyphen for a simple non-escaped MINUS character (ASCII 0x2B).
>
> So, for the release/2.3 branch, NAK for now, and more questions on the
> 2.4/trunk.
>
> My objections will be void the moment that we can be sure that those
> (major) distributions that played with the Unicode outside-ASCII hyphens
> in *roff have gone out of support, and supported versions no longer
> modify the plain ASCII minus, but render it verbatim.
>
Hi,

Getting back to this after a while... we did quite extensive tests=20
earlier. I recall testing the following operating systems myself:

- Debian 6
- Debian 7
- Ubuntu 10.04
- Ubuntu 12.04
- CentOS 6

I was unable to reproduce the search issue or to trigger any=20
misrendering on any of those platforms. I think RedHat 5 was also=20
tested, but I'm not sure about the BSD-based operating systems.

In any case the man-page is currently a mishmash of escaped and=20
unescaped dashes, so if there is a problem, people are already having it=20
and not caring.

I suggest we do a few additional tests and if no problems are=20
encountered then merge the patch.

Samuli

