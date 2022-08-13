From: Kristof Provost <kprovost@...2661...>
Date: Sat, 13 Aug 2022 10:24:40 +0200
Message-ID: <70EE7DE3-3625-48F1-AD5D-DA76EAC27EB9@...2661...>
In-Reply-To: <Yvdcec3CsvyYUKUx@...1296...>
References: <20220808143424.65924-1-kprovost@...2661...>
 <20220808143424.65924-3-kprovost@...2661...>
 <YvPdlCSxQ6wvfIna@...1296...>
 <2DCBB302-1FB4-4EC0-8B4A-8D6EA075B0FD@...2661...>
 <Yvdcec3CsvyYUKUx@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 1/2] ovpn-dco: introduce FreeBSD
 data-channel offload support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 13 Aug 2022, at 10:10, Gert Doering wrote:
> On Thu, Aug 11, 2022 at 05:25:05PM +0200, Kristof Provost via Openvpn-devel wrote:
>>>  - running openvpn over TCP gives me a kernel panic - this is not so
>>>    nice... (see attached .png from the vmware console) - userland seems
>>>    to assume "kernel can do TCP", kernel panics on "if !udp, panic()"
>>>    (so intentional panic, not corruption panic).
>>>
>>>    This is on freebsd git FreeBSD 14.0-CURRENT #1 main-n257130-c0665d5c824
>>>
>> I???ve pushed a fix for this panic in fd6b3bede5a5c210f327e5c9bd3e415ee905048b.
>> I simply didn???t think that user space might give us a non-UDP
>> socket, so checking for that and rejecting the peer in that case
>> fixes the panic. Thanks for finding that.
>
> JFTR, I have tested "main-n257320-3a3af6b2a16" with the old DCO userland
> patch, and it no longer crashes.  Of course the TCP tests failed, because
> userland only sees "mmmh, it fails!" but has no idea it should fall back
> to non-DCO  (with the new userland patches, this works).
>
Thanks!

> In case you plan to include kernel TCP support, it would be good to
> have this "soonish" - like, before FreeBSD 14 and OpenVPN 2.6.0 release,
> because otherwise this will be a bit painful to synchronize.
>
There’s not plan to add TCP support at the moment.

Best regards,
Kristof

