Message-ID: <2c2e97a4-af8e-6c3d-2abc-45ab865cc496@...1227...>
Date: Sun, 12 Dec 2021 16:45:25 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <59d7ff32-d7b3-6139-702b-a0a2895c7b4c@...68...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <59d7ff32-d7b3-6139-702b-a0a2895c7b4c@...68...>
Subject: Re: [Openvpn-devel] Licensing questions
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
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

Am 11.12.21 um 13:58 schrieb Matthias Andree:
> Greetings,
> 
> I am seeking clarification on licensing, judging from OpenVPN 2.5.X
> (meaning latest 2.5).
> 
> 1. mbedTLS licensing compatibility. AFAICS, mbedTLS is currently under
> dual Apache License 2.0 and GPLv2, https://tls.mbed.org/download - while
> OpenVPN is under GPLv2-only license (not the "or any later version")
> clause, as of 2.5.4, where the mbedTLS future license will be Apache
> License 2.0 only - this will be incompatible with GPLv2 but not GPLv3.
> https://www.gnu.org/licenses/license-list#apache2

Ouch. That is also something that Fox IT needs to be aware of. I have no 
problem with changing OpenVPN license to something that is more friendly 
to Apache 2 but having/adding any small change to license requires all 
(or least all significant) contributers to agree to that change which 
can be quite difficult. Looking at 
https://github.com/OpenVPN/openvpn/graphs/contributors and excluding 
trivial contributions we probably need an Okay from 20-25 people, which 
is overall not that bad.
> 2. LZO vs. LibreSSL. As far as I can see, Markus FXJ Oberhumer granted a
> license to link LZO with OpenSSL, but not any other library under the
> OpenSSL license, so I take it that LibreSSL and LZO cannot be combined
> into one OpenVPN link, unless LibreSSL ships as part of the operating
> system (that's a coarse rewording of the GPLv2 clause 3).

That seems to be true. James has written a decompress only 
implementation of lzo for OpenVPN3 that we could use if this really 
becomes a problem. That being said, I only see LibreSSL really being 
used on OpenBSD [1] where it definitively would count as system library.

> Are there any further licenses or permissions (= restriction exceptions)
> granted to OpenVPN that I have missed and am unaware of?

Not that I am aware of. LZ4 is BSD, for dco support in the future we add 
libnl (LGPL 2.1)

On Linux we link against systemd that has a confusing mess of licenses 
(https://github.com/systemd/systemd/tree/main/LICENSES) and they have 
this extra line:

OpenSSL Notes
Note that building the systemd project with OpenSSL does not affect the 
libsystemd.so shared library, which is not linked with the OpenSSL library.

We can of course pull the "system library" card but that seems something 
that we might need to look into.

libselinux is public domain, so no problem.



[1] macOS technically also has libreSSL as system library and ssh uses 
but you cannot link to it as you get errors for using a private library 
that you should not link against.

Arne

