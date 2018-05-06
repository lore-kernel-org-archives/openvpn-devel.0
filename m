References: <CAJY0qZKNO_aamQfi56BG_XK2vrOCyPAQf-My1N56qqV7TsUG7A@...278...>
 <eaae68e6-e30d-f63b-59c5-64515c8f8bcd@...1147...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <e4a2d28a-ff8d-4797-e0af-3bcf98828cb3@...1856...>
Date: Sun, 6 May 2018 10:04:40 +0200
MIME-Version: 1.0
In-Reply-To: <eaae68e6-e30d-f63b-59c5-64515c8f8bcd@...1147...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Does the OpenVPN protocol itself handle
 windowing?
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

On 04-05-18 17:45, Jan Just Keijser wrote:
> On 04/05/18 16:41, Derek Zimmer wrote:
>> What conclusions can we draw from this?
>>
> My main conclusion has always been that OpenVPN is limited by the number
> of user-to-kernel space transitions , not by anything else.

Same here. I guess this interacts with other properties, like the delay
OpenVPN itself adds.  And that is where AES-GCM, with it's blazingly
fast hardware acceleration, outperforms AES-CBC + HMAC-SHA in orders of
magnitude (at the crypto level).

Some while ago, I looked a bit into this, and started at looking to
improve the user/kernel interfaces.  I posted a proof-of-concept patch
that might be interesting to check out if you're doing performance testing:
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13699.html

I'd be very interested to know if using recvmmsg() improves the
performance in you measurements.  (I never got to picking this up again,
because dayjob, bug reports and life in general got in the way...)

-Steffan

