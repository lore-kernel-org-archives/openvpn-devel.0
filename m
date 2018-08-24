From: Arne Schwabe <arne@...1227...>
Message-ID: <149619ba-265f-1a7a-6403-f99c6f4b7eac@...1227...>
Date: Fri, 24 Aug 2018 13:11:44 +0200
MIME-Version: 1.0
Content-Language: en-GB
Subject: [Openvpn-devel] Discussion: Moving forward with compression and
 voracle
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hey,

with this mail I would like to discuss the way forward for compression.

When compression was added to OpenVPN, a lot of Internet traffic was
still unencrypted and encryption+compression was thought to be good
thing. With recent attack like CRIME, BEAST and VORACLE, the general
consensus in the crypto community is that compression should be avoided.
On top of that, a lot of the traffic that the VPN carry today is either
already compressed or encrypted and cannot be compressed any more. So
benefits are diminishing.

Our default configuration has not compression enabled. So our default
configuration is safe from Voracle. Nevertheless, a lot of configuration
examples are using compression and compression is wildly used because a
lot of people think it is a good idea.

Our current state is sane but I still we should try to change our
implementation to have a minimal attack and encourage safe configuration.

Outright removing compression is not an option as it would break
connection to existing client/servers that have compression enabled.

OpenVPN compression has always been opportunistic compression. I.e. we
only send compressed payload if compression actually has a benefit. So
even with compression enabled, most of the packets that are send might
actually be not compressed for incompressible content.

While we cannot (ignoring pushing option for the moment) change the
behaviour of the other side, we can change our own behaviour to always
send uncompressed packets but still accept compressed packets. Basically
asymmetrically compression. This allows to mitigate VORACLE in one
direction. If both sides are using this behaviour VORACLE is mitigated.

So my proposal for OpenVPN is:

- Introduce compress-direction asym|full This will control if we
actively try to compress or just allow receiving of compressed packets
- change the default mode to be asymmetrical.
- If compress-direction is missing from the config but comp-lzo/compress
are present inform the user "WARN: Compression mode set to assymetrical
to avoid VORACLE like attacks. See the man page on compress-direction
for more details".

Open Points:

- Gert strongly thinks that some people might want to continue having
full compression despite the risks. I think it is reasonable to expect
them to add 'compress-direction full' and push "compress-direction full"
 to the server configuration, so touching clients is not needed.

- Wording is pretty important here to not scare users too much. So the
message of the warning and compress-direction are not final and might
require some more thoughts.

I would like to have some feedback what the rest of you thinks

Arne

