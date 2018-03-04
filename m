References: <f2QLEJM1WzOC1xj4piTlsJBomEfPUdWmlThT__H6xyGvqxgyw4KunQ0wTkM-JAVhB0oHDaqI3J5ls6QggiH6jwAzrxHWKtR5ck9vnpwQLVo=@protonmail.com>
From: Steffan Karger <steffan@...1856...>
Message-ID: <c4c34c19-7b23-b673-5dd3-b04cb876ebc3@...1856...>
Date: Sun, 4 Mar 2018 23:40:13 +0100
MIME-Version: 1.0
In-Reply-To: <f2QLEJM1WzOC1xj4piTlsJBomEfPUdWmlThT__H6xyGvqxgyw4KunQ0wTkM-JAVhB0oHDaqI3J5ls6QggiH6jwAzrxHWKtR5ck9vnpwQLVo=@protonmail.com>
Content-Language: en-US
Subject: Re: [Openvpn-devel] LibreSSL support in OpenVPN 2.4.5
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
To: openvpn-devel@lists.sourceforge.net

Hi,

Most has been said, so I won't reiterate that.  Gert++, Selva++.

On 04-03-18 13:43, Mina Barret via Openvpn-devel wrote:
> Ok, bummer, the (german) wikipedia experience again - rejected. The
> second and third read of the well distributed Changelog(s) and release
> note(s) does not bring up a 'We do no longer support LibreSSL' note. The
> sourcecode contains ifdefs that already take care about LibreSSL.

Exactly this is the reason why I've been reluctant to accept LibreSSL
patches in the past.  It might give people the idea that we ever
supported it.  We never claimed to support LibreSSL.  Even more, we've
broadcasted more than once [0,1,2] that we do *not* support libressl.

But I can't really blame you for assuming we did.  We can't expect
everyone to follow the mailing list.  In hindsight, we should have
immediately added a patch like I recently submitted, to leave no doubt
about the state of our LibreSSL support.  (Though I'd also like to
defend ourselves a bit, LibreSSL lured us into this mess by pretending
to be OpenSSL-compatible.)

> Steffan Karger: When the introduced block
> in 0e8a30c0b05c1e2b59a1dea0a6eab5daa1d9d9a1 really is 'not really
> needed', can we add a additional ifdef arround it to make it build
> with libressl?

This block is needed if the linked crypto lib does not support the API
we expect, namely the OpenSSL 1.1 API.  If LibreSSL claims to implement
the OpenSSL API, they should do so.  I don't have time to figure out how
they subtly broke the build this week.  (Yes, I think OpenSSL's choice
to use macro's is bad design.  But that is the API we do support.)

-Steffan

[0]
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg09221.html

[1]
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg11272.html

[2]
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15295.html

