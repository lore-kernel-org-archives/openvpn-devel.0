References: <CAAF3xa85gmN5GEjguVA6cpUPFZuSOKP39g1FKf1hYfmyoo9X5w@...278...>
 <d42dfd0b-8309-2409-0a21-aa97c8a3b651@...2080...>
 <20180522204702.GT79551@...1296...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <3b9e1a1a-7b61-6edc-1f81-2b42eb5c66c8@...1147...>
Date: Wed, 23 May 2018 12:25:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180522204702.GT79551@...1296...>
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] Minimum Linux Version for OpenVPN 2.4.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,


On 22/05/18 22:47, Gert Doering wrote:
> On Tue, May 22, 2018 at 09:10:10PM +0200, David Sommerseth wrote:
>> On 22/05/18 19:32, Marvin wrote:
>>> Can someone tell me the minimum Linux version that OpenVPN 2.4.x will b=
uild
>>> and run on?=A0 We have an older appliance the runs on an older 2.4.31 k=
ernel
>>> (cannot be upgraded -- but it's very hardened so really doesn't need to=
 be for
>>> our use.)
>>
>> But I do know there has been some
>> code changes over the years which is strictly 2.6 kernel and newer; but =
its
>> quite a long time ago so I don't recall exactly what and when.
> For OpenVPN 2.4, I think we kicked out some old method to set up Linux
> tunnels.  OTOH, that was 2.2.x stuff, if I remember correctly...
> (86e2fa5597fd1ad8e010)
>
>
as usual, Gert is right ...
I've=A0 dusted off and fired up a really ancient VM running CentOS 3.9,=20
which is based on kernel 2.4.21. After falling off my chair in amazement=20
and climbing back on, I then copied over openssl 1.0.2, lzo-2.03 and=20
openvpn 2.4.5; openssl builds, as does lzo. As Gert predicted:
OpenVPN 2.4.5 fails to build on tun.c , line 2092: 'TUNSETGROUP' undeclared.

I then copied over openvpn 2.3.18 and built that: it builds and runs=20
just fine.
So in short: openvpn 2.3.X is the last version that can be run on a 2.4=20
kernel.

Now stop and think about this:
- WHY?!?!?!?!!? would you want to do this?
- as others have said, the 2.4 kernel series is no longer updated , and=20
2.4.31 is not even the last version (that's 2.4.37). I would not=A0=20
consider any device running a 2.4 kernel secure enough to run a secure=20
VPN on it, especially over the internet.
- why do would you need openvpn 2.4.x in the first place for such a=20
device?=A0 if it's AES-GCM that you are looking for then there's a good=20
chance that=A0 it will be SLOWER on embedded hardware compared to=20
AES-256-CBC+SHA256.


JM2CW,

JJK

