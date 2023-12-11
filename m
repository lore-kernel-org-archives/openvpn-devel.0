Message-ID: <b3e0a162-f0e2-4d76-bd15-02db44443346@...1227...>
Date: Mon, 11 Dec 2023 13:31:06 +0100
MIME-Version: 1.0
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
Subject: [Openvpn-devel] OpenVPN data channel format using 64bit IV
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Leon Dang <ldang@...2661...>, Kristof Provost <kp@...1249...>

Hey,

with DCO and possible future hardware assisted OpenVPN acceleration we 
are approaching the point where 32 bit IVs are not cutting it any more.


To illustrate the problem, some back of the envelope math here:

If we want to keep the current 3600s renogotiation interval and have a 
safety margin of 30% we have about 3 million packets (2*32 * 0.7) to 
work with. That translates to about 835k packets per second.

With 1300 Byte packets that translates into 8-9 Gbit/s. That is from 
unrealistic any more. Current DCO implementations are already in 
spitting distance to that or might even reach (for a single client 
connection) that if you have extremely fast single core performance CPU.

So I think we need to consider adding 64bit IV now rather than later.

So the proposal is the following:

- add IV_PACKET_FORMAT_AEAD_V2 flag to the protocol flags. This signal 
that the other side supports the new AEAD data channel packet format 
that supports 64 bit IVs.

I don't think we need to extend this feature to the CBC data channel 
format. I just don't see a use case where people would be able to 
upgrade to a new OpenVPN version to use 64 bit IVs but not to also 
change to use AEAD ciphers.

- add protocol-flag aead-packet-format-v2 This signals the client to 
switch to the new data channel format.


And finally have the data channel format. Since this format is 
negotiated like the cipher, there is no need to use another opcode if 
keep the peer id to just 24 bit. But we might want to extend the format 
to have it 8 byte aligned to also allow peer-id to be extended in the 
future.

Regardless of what choice we take, this is a good opportunity to rectify 
the position of the AEAD tag in our packet. Especially for hardware 
implementations it is quite advantageous to have the AEAD at the end of 
the packet instead of the beginning and since we need to have a new data 
format, there is no reason to keep the tag at the start of the packet.


So the choice is basically

Variant A:

Bytes

          1          234        5-13      13- (n+13)     (n+14) - (n+30)

[OP_CODE_DATA_V2][peerid]   [64 bit IV] [  payload  ][ 16 byte auth tag]


Variant B:

        1            3-8
[OP_CODE_DATA_V3] [ peer-id/padding] [rest identical]

Arne

