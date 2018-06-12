References: <20180608052017.6696-2-a@...2181...>
 <20180612074240.18865-1-a@...2181...>
 <20180612092937.GA57262@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <830e09cf-7902-4144-bce7-5ff6c5081225@...1227...>
Date: Tue, 12 Jun 2018 12:14:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180612092937.GA57262@...1296...>
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
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>
Cc: Antonio Quartulli <antonio@...515...>, openvpn-devel@lists.sourceforge.net

Am 12.06.18 um 11:29 schrieb Gert Doering:
> Hi,
> 
> another reply to the same mail, on purpose, to keep thoughts in
> separate threads...
> 
> On Tue, Jun 12, 2018 at 03:42:40PM +0800, Antonio Quartulli wrote:
>> This change ensures that an interface is properly brought
>> up even when only IPv6 settings are configured/pushed.
>>
>> At the same time, the do_ifconfig() function has been rearranged by
>> splitting the logic into a v4 and a v6 specific part. Each part has
>> then been moved into an idependent helper that can be invoked as
>> needed.
> [..]
> 
> The existing Android code is different from all the other platforms,
> as it sends IPv6 info ("IFCONFIG6") *before* IPv4 info.
> 
> Arne, do I have to assume that this is intentional, and your client will
> explode if it receives IFCONFIG first and IFCONFIG6 second, or no
> IFCONFIG at all?

No ifconfig at at all will produce an error since ANdroid itself will
not like to have no ifconfig at all. For the Android client it is only
important that ifconfig/routes/etc. all happen before opening the tun
device.

IPv6 only should be fine with my client.

Arne

