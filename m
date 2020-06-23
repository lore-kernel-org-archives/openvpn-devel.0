References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
 <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
 <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
From: Dmitry Melekhov <dm@...1823...>
Message-ID: <ed88a719-731d-0995-5473-be5d3e2ebefd@...1823...>
Date: Tue, 23 Jun 2020 12:52:02 +0400
MIME-Version: 1.0
In-Reply-To: <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

23.06.2020 12:34, Arne Schwabe пишет:
> Am 23.06.20 um 06:16 schrieb Dmitry Melekhov:
>> 22.06.2020 20:58, Selva Nair пишет:
>>> +*WARNING*    This MAY break configurations where the client uses
>>> +                ``--disable-occ`` feature where the ``--cipher`` has
>>> +                not been explicitly configured on both client and
>>> +                server side.  It is recommended to remove the
>>> ``--disable-occ``
>>> +                option*or*  explicitly add ``--cipher AES-256-GCM``
>>> on the
>>> +                client side if ``--disable-occ`` is strictly needed.
>> Well, may be it is possible to add support for setting cipher in ccd
>>
>> as it was possible before 2.4.9 using patch from here
>>
>> https://community.openvpn.net/openvpn/ticket/845
>>
> I get that this might have been needed in 2.4.x with the first version
> of NCP. But the NCP negoiation in 2.5.x should handle all use cases.
>
> Help me understand why --cipher in ccd should be needed?
>
> Arne
>
There are openvpn 2.3 clients in 3g routers which  are built without 
ability to inform server about cipher, so server uses default cipher for 
them,

in case you need to change default cipher on server you can't do this , 
because clients will not work, it is also impossible to change default 
cipher on all clients at once,

so this is where ability to set default cipher on ccd helps.  All these 
are explained in ticket.

Thanks to patch author we were able to change default cipher without 
downtime.

btw, we still run such routers but can't do the same procedure because 
patch is not compatible with 2.4.9 if for some reason current cipher 
will became nonsecure as blowfish.


Thank you!



