Message-ID: <00098d0c-c226-442e-8cf7-fa27188181d5@...2181...>
Date: Tue, 8 Mar 2022 15:36:42 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220224165557.22060-1-kprovost@...2661...>
 <20220224165557.22060-3-kprovost@...2661...>
 <f4d55b82-4a9d-fd09-a8d9-f4ec6a8692d1@...2181...>
 <DED07A0F-3068-494D-BECA-B043BD97D49B@...2661...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <DED07A0F-3068-494D-BECA-B043BD97D49B@...2661...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] ovpn-dco: introduce FreeBSD
 data-channel offload support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Kristof Provost <kprovost@...2661...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 08/03/2022 15:29, Kristof Provost wrote:
> It’s not really too relevant either way for FreeBSD, because the header contains very little information. It’s mostly only the ioctl numbers. There are no structures shared between the kernel and user land. Instead we use nvlists (name/value pair serialisation).

Yeah, quite similar to the linux header actually - netlink is indeed a 
list of attribute/value airs. The Linux header contains also the 
attribute names (as they are encoded into an int and must not change 
once defined).

> 
> Theoretically I’d prefer to use the OS header, but I can certainly see the upside of not having that dependency. We’ll always have to do the runtime check (dco_available()) anyway, so I can certainly live with that.
> 
>> p.s. as a side note, the rest of the code contains some "code style" issues. Nothing major, but wanted to mention it (we can discuss on IRC if you want).
>>
> I’m happy to fix that. Do you have a rough list of what’s wrong?
> https://community.openvpn.net/openvpn/wiki/CodeStyle is the authoritative style guide, right?

Correct. Not everything might be there, so feel free to ask for any 
clarification on IRC. Your code is already pretty clean actually.
Some things I have seen:
- We tend to avoid "if (a == NULL)" (or "!= 0") in favor of just "if (a)";
- We avoid spaces after the cast operator;
- we always use brackets {} for one-line blocks;


Regards,

-- 
Antonio Quartulli

