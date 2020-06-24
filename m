References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
 <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
 <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
 <ed88a719-731d-0995-5473-be5d3e2ebefd@...1823...>
 <3b6f724e-d1a3-f048-b4c1-6cffa168e2cb@...1227...>
From: Dmitry Melekhov <dm@...1823...>
Message-ID: <46ab98d4-cf8b-af57-2a55-cdd37a8cabf6@...1823...>
Date: Wed, 24 Jun 2020 14:37:48 +0400
MIME-Version: 1.0
In-Reply-To: <3b6f724e-d1a3-f048-b4c1-6cffa168e2cb@...1227...>
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


24.06.2020 14:12, Arne Schwabe пишет:
>> There are openvpn 2.3 clients in 3g routers which  are built without
>> ability to inform server about cipher, so server uses default cipher for
>> them,
>>
>> in case you need to change default cipher on server you can't do this ,
>> because clients will not work, it is also impossible to change default
>> cipher on all clients at once,
>>
>> so this is where ability to set default cipher on ccd helps.  All these
>> are explained in ticket.
>>
>> Thanks to patch author we were able to change default cipher without
>> downtime.
>>
>> btw, we still run such routers but can't do the same procedure because
>> patch is not compatible with 2.4.9 if for some reason current cipher
>> will became nonsecure as blowfish.
>>
> Allowing to be able to specify ncp-fallback-cipher from my proposal per
> ccd if no NCP could be performed would also fix your use case, right?
>

Yes, sure!

Thank you!


