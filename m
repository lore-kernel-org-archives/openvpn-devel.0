References: <20170701112951.19119-1-steffan@...1856...>
 <b67daad4-362b-3605-5716-3e17c5f0c362@...2080...>
 <CAFHpkQFADMG50xb4UD_bAvT4a94EbLVstAuPEmhkxhUEnZoXQg@...278...>
 <480c51a7-a17d-c29f-1b8e-33c874ca9670@...2181...>
 <CAFHpkQGNS60dNn7eFED26A6ewVFNjw0eMome9CQZ=Tg=23Kmsw@...278...>
 <cde83666-7a39-4aa5-bc51-27ef42dc5a88@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ffc817b5-f17f-0cfb-85bc-66f07bb3604b@...1227...>
Date: Tue, 15 Aug 2017 13:16:42 +0200
MIME-Version: 1.0
In-Reply-To: <cde83666-7a39-4aa5-bc51-27ef42dc5a88@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Deprecate --keysize
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
To: openvpn-devel@lists.sourceforge.net

Am 15.08.17 um 11:29 schrieb David Sommerseth:
> On 15/08/17 11:17, Илья Шипицин wrote:
> [...]
>>     > there are special cases like Mikrotik openvpn (pretty popular), where
>>     > user simply use what hardware vendor installed (without possibility to
>>     > recompile).
>>     >
>>     > should we contact such hardware vendors as well ?
>>
>>     there might be an non-predictable number of vendors shipping their own
>>     openvpn version. We can't contact them all. It's their responsibility to
>>     stay behind the changes in what they ship.
>>
>>     If they don't, their users will complain aloud with them ;)
>>
>>     On top of that, this does not prevent users from using their own config,
>>     right? So they can still configure the client to avoid deprecated
>>     options.
>>
>>
>> you cannot use regular openvpn config with Mikrotik
>> https://wiki.mikrotik.com/wiki/OpenVPN
>>
>> you can use mikrotik configuration options
> 
> Which just emphasizes even more that Mikrotik needs to do their own
> homework on their own.  Their config syntax is completely alien to us,
> so we have no direct influence on how their syntax ends up as a
> configuration OpenVPN is capable of understanding.  And _we_ shouldn't
> care how Mikrotik does that, it's their own implementation design.
> 

Also Mikrotek broke at least two times with my app. First when we
enabled TLS 1.1+ and second time when we disabled non PFS ciphers. I
have enough of their crappy OpenVPN/SSL support.

Arne


