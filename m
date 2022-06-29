From: Kristof Provost <kprovost@...2661...>
Date: Wed, 29 Jun 2022 21:22:48 +0200
Message-ID: <547317B9-3CCA-4FAD-8F9C-B3D9248E08FA@...2661...>
In-Reply-To: <d5cf0aca-954b-ebce-6078-8b766a27fc8a@...1227...>
References: <20220628162848.20103-1-kprovost@...2661...>
 <2a5bf6c9-c54a-06bb-9649-f19ff5f2be31@...1227...>
 <AC0FF0F0-0545-4367-B16F-81638D475C51@...2661...>
 <d5cf0aca-954b-ebce-6078-8b766a27fc8a@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH DCO]: FreeBSD DCO support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 29 Jun 2022, at 21:08, Arne Schwabe wrote:
> Am 29.06.2022 um 19:40 schrieb Kristof Provost:
>> On 29 Jun 2022, at 17:15, Arne Schwabe wrote:
>>> Am 28.06.22 um 18:28 schrieb Kristof Provost via Openvpn-devel:
>>>> Hi,
>>>>
>>>> Here's the most recent version of the FreeBSD DCO patch.
>>>> This is based on top of the dco branch, at
>>>> 480fa1c983aba9b0790ea94df209e1686f08336b.
>>>>
>>>> Relatedly, the kernel side of that support has just landed in FreeBSD's
>>>> repo: https://cgit.freebsd.org/src/commit/?id=3Dab91feabcc6f9da21d5c75=
028153af16d06e679a
>>> I tested this on top of Antonios branch but got an error when connectin=
g from a test client:
>>>
>>> 2022-06-29 17:10:57 us=3D506086 lethe/192.168.188.134:61923 dco_new_pee=
r: peer-id 0, fd 7
>>> 2022-06-29 17:10:57 us=3D506125 lethe/192.168.188.134:61923 Failed to c=
reate new peer 51
>>> 2022-06-29 17:10:57 us=3D506137 lethe/192.168.188.134:61923 Cannot add =
peer to DCO: Operation not permitted
>>>
>>>
>>> Any idea why I might get a permission denied from the kernel there?
>>>
>> The first thing to note here is that the =E2=80=98Operation not permitte=
d=E2=80=99 error is misleading. That=E2=80=99s produced based on the return=
 value of dco_new_peer(), which is going to be -1. The line above it has th=
e errno, which is 51 or ENETUNREACH.
>>
>> I suspect this is happening because you=E2=80=99re using ipv6_ipv4mappin=
g (or sysctl net.inet6.ip6.v6only=3D0). Presumably that indicates a bug on =
my side, but can you see if disabling that helps?
> Yes. That is the default that OpenVPN uses. It will ignore the sysctl sin=
ce we use the socket option per default on v6 sockets. (search the man page=
 for ipv6only). Adding --proto udp4 fixes the problem but that is something=
 at least needs a better error mesage.
>
I=E2=80=99ll do some digging in the next couple of days. I=E2=80=99m hopefu=
l it can just be made to work.

Kristof

