References: <6cc03a83-47e6-cedb-254b-f445972788f5@...515...>
 <b9c984d6-bcde-0d0e-349d-3a586600b668@...515...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <6ebf219f-6a8e-6e39-893c-5610129abaef@...1147...>
Date: Thu, 29 Nov 2018 10:49:37 +0100
MIME-Version: 1.0
In-Reply-To: <b9c984d6-bcde-0d0e-349d-3a586600b668@...515...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 28th Nov 2018)
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
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

Hi,

On 29/11/18 09:03, Samuli Sepp=E4nen wrote:
> [...]

> Had a discussion about --fragment. Agreed that if we can fix internal
> fragmentation without needing a change in frame format then we can
> definitely deprecate --fragment in the long-term. Also noted that lack
> of tun-mtu support on Windows might be for historic reasons and might
> not apply to tap-windows6. Also questioned whether the default MTU of
> 1500 is the best possible choice.
>
I wish I'd known about this discussion - I saw the topic list and figured I=
 wouldn't be able to contribute much to the discussion.
Regarding MTU/fragment however.....

--fragment is/was very useful on a system where you do not / cannot change =
the tun MTU size. Up to Windows XP, this was not=20
possible without rebooting the OS. Since Vista, it *is* possible to change =
the MTU of an adapter on the fly (as explained in my=20
trusty old cookbook, of course ;))

--fragment is also quite useful in combination with compression, to ensure =
that the payload never exceeded a particular size=20
*after* compression+encryption+encapsulation.

Now that Windows XP and below are gone, and now that compression+encryption=
 is considered evil (voracle) it might be possible to=20
better calculate/predict the maximum encrypted payload size. With that, it =
would be possible to fix the link-mtu to 1500 (or=20
whatever is set on the outbound interface) and then subtract the header siz=
e to get a meaningful tun-mtu size.

As for mtu=3D1500 being the best possible choice: that depends if you are d=
oing routing on your VPN or not. 95+ % of all Ethernet=20
LANs have the MTU set to 1500 - increasing the tun MTU to 9000 does not inc=
rease performance, as forwarded packets are coming in=20
from the LAN at 1500 bytes. If we can come up with an efficient method to g=
ather a bunch of packets before processing them=20
inside OpenVPN then I am all for increasing the MTU to something higher (wh=
y not go for 65000?). However, until we can do that=20
increasing the tun mtu size will do little to improve (routing/forwarding) =
performance.

Having said all that, I do have one gripe with the way the link or tun mtu =
is calculated in the current codebase:
In the 2.3 code base, the server tun mtu size was equal to the client tun-m=
tu size.
In the 2.4+ code base, the server-side tun mtu size is set to some ridiculo=
us low level (with link-mtu 1500 set) in order to=20
accomocate all possible encryption ciphers - *even if I add ncp-disable* . =
To me, that does not make a whole lot of sense. If I=20
add '--ncp-disable' I'd expect the client and the server to behave pretty m=
uch like an OpenVPN 2.3 client (with a possible 3=20
bytes difference to accomodate for the peer id).

JM2CW,

JJK


