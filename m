Message-ID: <61f051dc-e76c-c993-b0e1-8c2b4ff84f81@...1227...>
Date: Fri, 11 Feb 2022 12:16:10 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220210162632.3309974-1-arne@...1227...>
 <20220210162632.3309974-2-arne@...1227...> <YgYv50jgbpMyGlv8@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <YgYv50jgbpMyGlv8@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v4 2/8] Change the default for mssfix to
 mssfix 1492 mtu
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Am 11.02.22 um 10:44 schrieb Gert Doering:
> Hi,
> 
> On Thu, Feb 10, 2022 at 05:26:26PM +0100, Arne Schwabe wrote:
>> The current default is 1450, which translates to 1478 byte packets for udp4
>> and 1498 byte packets for udp6. This commit changes the mssfix default
>> to take the outer IP overhead into account as well and changes the target to
>> 1492. 1492 was picked in our community meeting for being a very common
>> encapsulation upper bound.
>>
>> The change also disables an mssfix default if tun-mtu is set to a value
>> different than 1500.
> 
> I think this needs a followup patch... I'll apply it (as it does what
> it says on the lid), but it needs further work, see below.
> 
> 
> Feature-ACK on having "1492 mtu" by default, so that is good.
> 
> It should have a Changes.rst entry for "User-visible Changes" - I tried
> to draft something, but then decided to send it back via the list.  Here's
> my draft text
> 
>    - :code:`--mssfix` default has been changed from 1450 to ``1492 mtu`` to
>      take IPv4 or IPv6 encap and today's typical SoHo internet links into
>      account.  If :code:`--tun-mtu` is changed from the default setting,
>      the default for :code:`--mssfix` is now ``off``


Sounds good.

> 
> Also, the patch needs to change the manpage from
> 
>      "Default value of 1450 allows ..."
> to
>      "Default value of ``1492 mtu`` allows packets to be transmitted
>       over a link with MTU 1492 or higher without IP level fragmentation.
>       If :code:`tun-mtu` is used to set a value != 1500, mssfix needs
>       to be configured with an explicit value, as no default applies."
> (or such)
> 
> 
> The code itself looks a bit fumbly with changing "o->ce.mssfix_encap = true"
> in the defaults section, just to change it back to "false" in the options.c
> handler - why not leave it at false, as it's set to "true" anyway at
> setting MSSFIX_DEFAULT?

Yeah, it is all a bit finnicky and I am not super happy with it. I 
change the default of it to false if you prefer that.
> 
> 
> But my main concern is this combination of options:
> 
>    --tun_mtu 1400 --mssfix
> 
> what would the user expect OpenVPN to do here?  I would expect "apply
> mssfix handling, in a reasonable fashion for the configured tun_mtu",
> but what OpenVPN does is "turn off mssfix, because, not 1500".
> 
> So the default "no mssfix in the config" and "mssfix without arguments"
> are handled the same way.  If this is intentional ("mssfix without
> arguments does nothing if the tun_mtu is not 1500") it should be
> documented.

So my reason is that if you have a tun-mtu > 1500, that you want to had 
a reason and want use larger packet and then a mssfix would break 
whatever you are trying to do.

And if you have a tun-tmu < 1500, then the smaller tun-mtu should 
already give you a MSS value that is small enough. If the MTU value is 
between something like 1450 and 1500, mssfix probably still does 
something but it felt to odd of a corner to still enable it.

Arne

