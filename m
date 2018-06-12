References: <20180608052017.6696-2-a@...2181...>
 <20180612074240.18865-1-a@...2181...>
 <20180612092937.GA57262@...1296...>
 <830e09cf-7902-4144-bce7-5ff6c5081225@...1227...>
 <20180612111710.GB57262@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <8bcd8c52-6acb-5b3f-269a-f234a38732bb@...1227...>
Date: Tue, 12 Jun 2018 13:55:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180612111710.GB57262@...1296...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH v3] **Android** note: tun: ensure
 interface can be configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

Am 12.06.18 um 13:17 schrieb Gert Doering:
> Hi,
> 
> On Tue, Jun 12, 2018 at 12:14:27PM +0200, Arne Schwabe wrote:
>>> The existing Android code is different from all the other platforms,
>>> as it sends IPv6 info ("IFCONFIG6") *before* IPv4 info.
>>>
>>> Arne, do I have to assume that this is intentional, and your client will
>>> explode if it receives IFCONFIG first and IFCONFIG6 second, or no
>>> IFCONFIG at all?
>>
>> No ifconfig at at all will produce an error since ANdroid itself will
>> not like to have no ifconfig at all. For the Android client it is only
>> important that ifconfig/routes/etc. all happen before opening the tun
>> device.
>>
>> IPv6 only should be fine with my client.
> 
> So, to paraphrase this: you will handle IFCONFIG and IFCONFIG6 in
> either order or "just one of them" fine?
> 
> I was sort of assuming the code waits for an incoming IFCONFIG and then
> fires up the VPN API with "IFCONFIG and optional IFCONFIG6" - in which
> case, sending IFCONFIG first would have caused "fun effects with IFCONFIG6",
> and "not sending IFCONFIG at all" would cause interesting effects :-)
> 
> ... but now I do seem to remember that you collect *all* information
> first (IFCONFIG* and ROUTE*), so it doesn't really matter in which order
> the "core" sends it...

Yeah, I do. At the moment I think I need ifconfig before route but that
is not a bug issue to change that. Only thing that I really need is that
opening TUN happens after everything else because after opening tun
there no more changes possible.

Arne

