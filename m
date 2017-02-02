References: <1484297432-14435-1-git-send-email-chipitsine@...277...>
	<7dc75a19-451e-effa-503a-ac5b75a23bab@...515...>
	<ac93d2de-d56a-0ff9-b97a-a590923f5cf8@...2080...>
	<CAFHpkQEHRCveRiiBWscwLQ7U3UoJ+yY5_0Lx82UMc=f4ucwMbQ@...278...>
	<CAFHpkQFs5x_7MEH5gjieUsp=1f2SPdG9Fr6PeakgBGrSEPQC_Q@...278...>
	<6256c846-ca60-be4f-7122-60465374a322@...515...>
	<7e7799f0-e2f1-8773-18aa-6a89b87d3500@...2080...>
	<b907084b-77a5-3152-3ff9-366ecd1bf5a4@...515...>
	<CAFHpkQHF7Wxw_WMBsnyzz5qgDr+ghYnoiWkDJp+rbfK2qr1mQA@...278...>
	<20170202120708.GW12187@...2182...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <f79c809b-1804-acda-c46b-17a97bf279f2@...515...>
Date: Thu, 2 Feb 2017 14:15:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170202120708.GW12187@...2182...>
Subject: Re: [Openvpn-devel] [PATCH] add PR template in order to simplify
 new developers cooperate properly if they open PR. discussed here:
 https://sourceforge.net/p/openvpn/mailman/message/35601310/
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Antonio Quartulli <a@...2181...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0Lg=?= =?UTF-8?B?0YbQuNC9?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 02/02/2017 14:07, Antonio Quartulli wrote:
> On Thu, Feb 02, 2017 at 04:58:37PM +0500, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=
=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:
>>> Please send your patch using [git-send-email](https://git-s
>>> cm.com/docs/git-send-email). For example to send your latest commit to
>>> the list:
>>>
>>>     $ git-send-email --to=3Dopenvpn-devel@lists.sourceforge.net HEAD~1
>>>
>>
>> documentation seems to be confusing here.
>> I could not get "git-send-email" for fedora, it is "git send-email" inst=
ead.
>
> I think this was a typ0 from Samuli. It's "git send-email" on every syste=
m.
> Giving an easy way to send patches (with just one command) is probably us=
eful:
> avoid several iterations when people try to send their patches with gmail=
 and
> similar ..
>
> Cheers,

It was not a typo. I actually did not know about "git send-email" until=20
now. I've used "git-send-email" which on Debian/Ubuntu resides in=20
/usr/lib/git-core. Are these the same thing?

Anyways, let's use "git send-email" in the PR template if that one is=20
readily available on all Git installations.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

