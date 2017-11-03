From: Jan Just Keijser <janjust@...1147...>
Message-ID: <cc3981e2-742c-37b1-e8fc-fa32f64b7d11@...1147...>
Date: Fri, 3 Nov 2017 15:03:16 +0100
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] Possible bug: AEAD Decrypt error: cipher final
 failed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

hi all,

whilst testing some new hardware with OpenVPN I ran into the following mess=
ages which keep popping up from time to time:

 =A0AEAD Decrypt error: cipher final failed


Config:

server running OpenVPN 2.4.3, basic config, Ubuntu 17, kernel 4.14, openssl=
 1.0.2g
client running OpenVPN 2.4.4, basic config, CentOS 7.4, kernel 3.10, openss=
l 1.0.2k

it's the client that is throwing the above message during heavy load (900 M=
bps VPN traffic). It happens only with NCP ciphers ,=20
I am not seeing any cipher messages with 'ncp-disable' set.

as soon as I add 'verb 5' or higher, the message goes away, because perform=
ance drops to below 500 Mbps due to excessive output.
Any idea how to tackle this?

TIA,

JJK



