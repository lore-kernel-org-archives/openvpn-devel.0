References: <70f8e104-6d26-b1e7-12df-50f88d02cd74@...515...>
 <50c0416c-5b51-df12-aafc-3264c9839367@...515...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <550b290f-c707-7d82-87d3-d2f46dcb52a1@...1147...>
Date: Fri, 25 Oct 2019 12:46:19 +0200
MIME-Version: 1.0
In-Reply-To: <50c0416c-5b51-df12-aafc-3264c9839367@...515...>
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] Tap-windows6 test installer with PRs #84 and #86
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 23/10/19 13:20, Samuli Sepp=E4nen wrote:
> Il 23/10/19 14:19, Samuli Sepp=E4nen ha scritto:
>> Hi,
>>
>> Here is a new Windows 10 / Server 2016+ tap-windows6 installer. It is
>> based on the latest code in "master" plus two currently unmerged PRs:
>>
>> "Introduce TAP adapter as a virtual device"
>>
>> <https://github.com/OpenVPN/tap-windows6/pull/84>
>>
>> "constants.h: make driver not halt on suspend"
>>
>> <https://github.com/OpenVPN/tap-windows6/pull/86>
>>
>> I have smoke-tested the installer on Windows Server 2016 and it passes
>> the signature verification just fine.
>>
>> We hope to later merge these two PRs and push out a new, official
>> tap-windows6 release.
>>
>> Samuli
>>
> And the link:
>
> <https://build.openvpn.net/downloads/snapshots/tap-windows-9.24.2-I601.ex=
e>
>
>
Just to confirm: this new driver fixes the HP Envy "wifi drops when tun=20
connects" problem under Windows 10.
Thanks very much for the hard work to trace down and fix this nasty bug!


cheers,

JJK


