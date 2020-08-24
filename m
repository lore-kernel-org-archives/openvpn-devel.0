References: <20200821062443.69245-1-eric@...1918...>
 <bd154015-3f5f-6035-c4ff-fae5abc7857c@...1227...>
From: Eric Thorpe <eric@...1918...>
Message-ID: <3df6fedd-f30a-4e08-0e82-b31a7728f21d@...1918...>
Date: Mon, 24 Aug 2020 17:59:08 +1000
MIME-Version: 1.0
In-Reply-To: <bd154015-3f5f-6035-c4ff-fae5abc7857c@...1227...>
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

The main scenario this addresses is 2FA authentication which needs to 
transmit very long responses such as those requiring keys. In these 
cases, the responses can be upwards of 1500 bytes. Management is 
restricted (currently) to 256 bytes and the control channel I believe to 
1024, however the larger problem is low MTU connections or poorly 
configured connection with fragmentation problems would refuse to 
transmit packets of this size over the control channel, so we need the 
ability to break these up.

At the moment I'm experimenting with the following layout which has 
shown success:

client-auth-pending <CID> CR_TEXT:R,C:2
client-auth-pending-extra <CID> CR_TEXT:CN,1:<data>
client-auth-pending-extra <CID> CR_TEXT:CN,2:<data>

Where flag C=Chunked data and 2 is the number of chunks to expect. Then 
CN,<chunk number>:<data>.

The other issue this addresses is there are scenario where more than one 
challenge reply is required. A simple example of this is resident key 
registration, where the username is pulled from the clients certificate, 
a password is queried, then attestation is queried, and then 
authentication is queried.

client-auth-pending-extra is a bit of a catch-all addition where it 
effectively opens up the client-auth-pending spec to allow the control 
channel to be used without having to constantly drop the connection like 
the current AUTH_DENY method pre-2.5, but without spamming the user with 
AUTH_PENDING notifications, and allows a connected management script to 
handle it without adding further complexity internally to OpenVPN.

Cheers,
Eric

---
Eric Thorpe
SparkLabs Developer
https://www.sparklabs.com
https://twitter.com/sparklabs
support@...1918...

On 22/08/2020 7:12 pm, Arne Schwabe wrote:
> Am 21.08.20 um 08:24 schrieb Eric Thorpe:
>> This allows extra INFO_PRE mesasges to be sent to a client during an
>> authentication stage. This may be required to send additional challenges,
>> or allow longer messages to be sent by breaking them up and sending in parts.
> Could you describe for what feature you need this? If we are extending
> the protocol for some multiline AUTH_PENDING feature, we should document
> how this works etc...
>
> Arne
>

