Message-ID: <53752c1d-6d18-a50b-b3d1-a92fe43263cc@...1227...>
Date: Thu, 11 Aug 2022 19:00:25 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220808143424.65924-1-kprovost@...2661...>
 <20220808143424.65924-3-kprovost@...2661...>
 <YvPdlCSxQ6wvfIna@...1296...>
 <2DCBB302-1FB4-4EC0-8B4A-8D6EA075B0FD@...2661...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <2DCBB302-1FB4-4EC0-8B4A-8D6EA075B0FD@...2661...>
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Kristof Provost <kprovost@...2661...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 11.08.22 um 17:25 schrieb Kristof Provost via Openvpn-devel:
> On 10 Aug 2022, at 18:32, Gert Doering wrote:
>> as promised, here's test results and code review.
>>
>> Test results:
>>
>>   - running openvpn over TCP gives me a kernel panic - this is not so
>>     nice... (see attached .png from the vmware console) - userland seems
>>     to assume "kernel can do TCP", kernel panics on "if !udp, panic()"
>>     (so intentional panic, not corruption panic).
>>
>>     This is on freebsd git FreeBSD 14.0-CURRENT #1 main-n257130-c0665d5c824
>>
> I’ve pushed a fix for this panic in fd6b3bede5a5c210f327e5c9bd3e415ee905048b.
> I simply didn’t think that user space might give us a non-UDP socket, so checking for that and rejecting the peer in that case fixes the panic. Thanks for finding that.

You should probably also modify the check for dco incompatible in 
OpenVPN so that using TCP disables DCO on FreeBSD.

Arne

