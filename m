References: <20210512131511.1309914-1-arne@...1227...>
 <20210512131511.1309914-10-arne@...1227...>
 <AAoNQJ8hje_YpG-e2TN2X_-zH6YoLvPujzpWicW_D13NeAysfWRNi89BMQDr-vld9FGAI7cbafIiFgYVYlnql_dE3kCWKQevVHV7tP1dTQ0=@protonmail.com>
From: Arne Schwabe <arne@...1227...>
Message-ID: <1468b026-4ad2-75a6-5f55-779378c79872@...1227...>
Date: Thu, 20 May 2021 01:36:03 +0200
MIME-Version: 1.0
In-Reply-To: <AAoNQJ8hje_YpG-e2TN2X_-zH6YoLvPujzpWicW_D13NeAysfWRNi89BMQDr-vld9FGAI7cbafIiFgYVYlnql_dE3kCWKQevVHV7tP1dTQ0=@protonmail.com>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 9/9] Add detailed man page section to
 setup a OpenVPN setup with peer-fingerprint
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: tincantech <tincantech@...2282...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> I just want this to be verified because the manual reads that:
> udp6 will force only udp on IPv6, at least that is how I read it.

Not on the server side. It is one of the quirks that we need to fix at
some point. See the ipv6only option of --bind for more details

> 
>> +
>> +    # The ip address the server will distribute
>> +    server 192.168.234.0 255.255.255.0
>> +    server-ipv6 fd00:6f76:706e::/64
>> +
>> +    # A tun-mtu of 1400 avoids problems of too big packets after VPN encapsulation
>> +    tun-mtu 1400
>> +
>> +    # The fingerprints of your clients. After adding/remvoing one here restart the
> 
> remvoing -> removing
> 
> 
>> +    # server
>> +    <peer-fingerprint>
>> +    </peer-fingerprint>
>> +
>> +    # Notify clients when you restart the server to reconnect quickly
>> +    explicit-exit-notify 1
>> +
>> +    # Ping every 60s, restart if no data received for 5 minutes
>> +    keepalive 60 300
> 
> I presume you are all sure that this is suitable for consumer grade routers.

I think 60 300 is a good starting point but we might later modify it if
this becomes a problem.

Thanks for spell/grammar checking it!

Arne

