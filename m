References: <CAAUX2SVQRn4zuDC947HE9M38nDNK1oNqyUv0GKeAw2dasHo62Q@...278...>
 <82bd7803ae854e39f170a11e84446e70.squirrel@...2556...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <58495bcc-13b8-c239-20a0-6b66a0802c0d@...2181...>
Date: Wed, 31 Mar 2021 08:31:04 +0200
MIME-Version: 1.0
In-Reply-To: <82bd7803ae854e39f170a11e84446e70.squirrel@...2556...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [ovpn-dco] sudden network disconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Simon Matter <simon.matter@...2249...>, Tony He <huangya90@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 31/03/2021 07:21, Simon Matter wrote:
>> Hi Antonio,
>>
>> As you know I am porting opvn-dco to my router whose kernel is V4.14.76.
>> After solving AF_NETLINK group issue we discussed
>> yesterday.  It finally works. But I encounter another issue :-( .  When
>> testing the performance with iperf3, disconnection occurs
>> and recovers after a few seconds and then again.
> 
> Just a guess, could it have something to do with missing entropy?
> 
> Maybe for such tests a passthrough mode in the kernel module without
> encryption could help to debug. Or, as a second option, a non encryption
> mode in OpenVPN to test. I think this is or was available.

There is really not much entropy involved in the encryption/decryption
routine.
Randomness is mainly used during session key generation (at negotiation
time) and that's all.

Cheers,


-- 
Antonio Quartulli

