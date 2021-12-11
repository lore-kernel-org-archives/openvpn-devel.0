Message-ID: <59d7ff32-d7b3-6139-702b-a0a2895c7b4c@...68...>
Date: Sat, 11 Dec 2021 13:58:35 +0100
MIME-Version: 1.0
Content-Language: en-US
From: Matthias Andree <matthias.andree@...68...>
Subject: [Openvpn-devel] Licensing questions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Greetings,

I am seeking clarification on licensing, judging from OpenVPN 2.5.X
(meaning latest 2.5).

1. mbedTLS licensing compatibility. AFAICS, mbedTLS is currently under
dual Apache License 2.0 and GPLv2, https://tls.mbed.org/download - while
OpenVPN is under GPLv2-only license (not the "or any later version")
clause, as of 2.5.4, where the mbedTLS future license will be Apache
License 2.0 only - this will be incompatible with GPLv2 but not GPLv3.
https://www.gnu.org/licenses/license-list#apache2

2. LZO vs. LibreSSL. As far as I can see, Markus FXJ Oberhumer granted a
license to link LZO with OpenSSL, but not any other library under the
OpenSSL license, so I take it that LibreSSL and LZO cannot be combined
into one OpenVPN link, unless LibreSSL ships as part of the operating
system (that's a coarse rewording of the GPLv2 clause 3).

Are there any further licenses or permissions (=3D restriction exceptions)
granted to OpenVPN that I have missed and am unaware of?

Any other license incompatibilities that the public should be aware of?

TIA
Matthias Andree


