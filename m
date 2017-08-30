References: <CAEycoiUeA+zbn3vT9t3F3Df6yxsKp8HmAdiaHCMmLV1ew+d8Xw@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4777209f-c480-0404-91c6-cf1bd3b3f507@...1227...>
Date: Wed, 30 Aug 2017 03:49:33 +0200
MIME-Version: 1.0
In-Reply-To: <CAEycoiUeA+zbn3vT9t3F3Df6yxsKp8HmAdiaHCMmLV1ew+d8Xw@...278...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] Please take a second look at "#2 Improve
 TCP-over-TCP performance"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: wang yu <wangyu.cn@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 29.08.17 um 22:53 schrieb wang yu:
> URL  https://community.openvpn.net/openvpn/ticket/2
> <https://community.openvpn.net/openvpn/ticket/2>
> 
> As I mentioned,the custom TCP protocol(I called FakeTCP) bypasses the
> TCP over TCP performance issue.Its helpful when UDP is not
> avaliable(being blocked or being throttled or not well supported by NAT
> devices).
> 
> This was your reply:
>>We are not going to implement it, though. OpenVPN over TCP is needed
> when you have nasty firewalls out there that do sequence number checking
> and all that - and then your FakeTCP is not going to work either. If you
> have no firewalls in the way, OpenVPN over UDP works perfectly well
> (including "through NAT").
> 
> Sorry,I cant get the logic behind the sentence.
> 
> UDP not avaliable is a much more common circumstance,while a nasty
> firewall which tracks everything of TCP is just a rare circumstance.
> 
> This method solves most of the troubles when UDP is not avaliable just
> except the nasty-firewall circumstance you mentioned.
> 
> It seems like you rejected a commonly workable feature for a rare
> circumstance.
> 
> I tried to have a further discussion with you by another reply in the
> Tracker,but you closed the issue without a word.
> 
> I am okay wheter or not the feature can be implemented.I just hope its
> well discussed and there is a convincing reason if it cant
> be implemented.If this feature is acceptable I can make patches.
> 
> If you dont have time to discuss with me,plz leave the ticket open for a
> few days,so that I can possibly get some more convincing feedback from
> others.
>

While a fake TCP as UDP sounds like a nice idea, OpenVPN itself is
probably the wrong place to implement it. It would mean to implement a
TCP/IP stack in userspace, something that would complicate OpenVPN
without much gain. Much better would be to teach the kernel to speak
this fake TCP UDP protocol so openvpn can just set the socket options on
its tcp socket to enable this special mode.

Take a look at Multipath TCP to get an idea what implementing such a
fake TCP might entail. Also OpenVSwitch implemts a STT [1], a fake TCP
protocol but for a very different reason.

[1]
https://networkheresy.com/2012/03/04/network-virtualization-encapsulation-and-stateless-tcp-transport-stt/

In sum and I think I speak for all us, we are not against such a FakeTCP
protocol but it should be

a) implemented outside openvpn (the kernel)
b) nobody of the OpenVPN core team will implement it

This protocol will probably help only if people just block all UDP and
allowed a few TCP protocol. You won't fool a real firewall that checks
TCP with it.

Arne

