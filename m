References: <20200821062443.69245-1-eric@...1918...>
 <bd154015-3f5f-6035-c4ff-fae5abc7857c@...1227...>
 <3df6fedd-f30a-4e08-0e82-b31a7728f21d@...1918...>
 <446bb2a7-7597-1c89-b4eb-543abf4e6e3f@...1227...>
From: Eric Thorpe <eric@...1918...>
Message-ID: <2f192d4f-fa69-20d3-f9a2-90329d308b53@...1918...>
Date: Tue, 25 Aug 2020 09:58:22 +1000
MIME-Version: 1.0
In-Reply-To: <446bb2a7-7597-1c89-b4eb-543abf4e6e3f@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Adds client-auth-pending-extra
 management functionality.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi Arne,

> - to avoid the 256 byte management limit and multiple commands use maybe
> the same approach as client-auth that allows a longer frame, you can
> still limit that to 1024.
To be clear here, it isn't so much the limitation of the management or 
control channel, it's situations where a tun-mtu may be set to say 750 
for example, meaning the data size can only realistically be about 730 
minus INFO_PRE, flags, etc, or OpenVPN or the network will drop the 
control channel message. I would not recommend making any changes to 
management or the control channel here, simply just have the ability to 
send the data in smaller parts.

> CR_TEXT is challenge response text and those clients that currently
> implement it only allow a single line. I would suggest the following to
> get the patch in a acceptable state:
>
> - Document your authentication method also in management.txt and also
> what IV_SSO flag indicates this authentication method.
Are you suggesting that I do not use CR_TEXT, and instead introduce a 
new Challenge Response type (CR_DATA for example)?

Cheers,
Eric

---
Eric Thorpe
SparkLabs Developer
https://www.sparklabs.com
https://twitter.com/sparklabs
support@...1918...

On 25/08/2020 1:02 am, Arne Schwabe wrote:
> Am 24.08.20 um 09:59 schrieb Eric Thorpe:
>> Hi Arne,
>>
>> The main scenario this addresses is 2FA authentication which needs to
>> transmit very long responses such as those requiring keys. In these
>> cases, the responses can be upwards of 1500 bytes. Management is
>> restricted (currently) to 256 bytes and the control channel I believe to
>> 1024, however the larger problem is low MTU connections or poorly
>> configured connection with fragmentation problems would refuse to
>> transmit packets of this size over the control channel, so we need the
>> ability to break these up.
>>
>> At the moment I'm experimenting with the following layout which has
>> shown success:
>>
>> client-auth-pending <CID> CR_TEXT:R,C:2
>> client-auth-pending-extra <CID> CR_TEXT:CN,1:<data>
>> client-auth-pending-extra <CID> CR_TEXT:CN,2:<data>
>>
>> Where flag C=Chunked data and 2 is the number of chunks to expect. Then
>> CN,<chunk number>:<data>.
>>
>> The other issue this addresses is there are scenario where more than one
>> challenge reply is required. A simple example of this is resident key
>> registration, where the username is pulled from the clients certificate,
>> a password is queried, then attestation is queried, and then
>> authentication is queried.
> Depends on if these should asked sequentially, the  you just send
> another CR_TEXT challenge after the first is answer or in parallel.
>
>> client-auth-pending-extra is a bit of a catch-all addition where it
>> effectively opens up the client-auth-pending spec to allow the control
>> channel to be used without having to constantly drop the connection like
>> the current AUTH_DENY method pre-2.5, but without spamming the user with
>> AUTH_PENDING notifications, and allows a connected management script to
>> handle it without adding further complexity internally to OpenVPN.
> CR_TEXT is challenge response text and those clients that currently
> implement it only allow a single line. I would suggest the following to
> get the patch in a acceptable state:
>
> - Document your authentication method also in management.txt and also
> what IV_SSO flag indicates this authentication method.
>
> - to avoid the 256 byte management limit and multiple commands use maybe
> the same approach as client-auth that allows a longer frame, you can
> still limit that to 1024.
>
> Otherwise I think this the right direction.
>
> Arne
>

