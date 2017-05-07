References: <1494016221-21268-1-git-send-email-steffan.karger@...1435...>
	<9130e0b4-73ca-5307-dda8-7f1451b459c5@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <1664a9e5-12f1-116f-5515-deec2d8392dc@...1856...>
Date: Sun, 7 May 2017 11:50:13 +0200
MIME-Version: 1.0
In-Reply-To: <9130e0b4-73ca-5307-dda8-7f1451b459c5@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Document tls-crypt security
 considerations in man page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 07-05-17 11:39, Magnus Kroken wrote:
> Non-crypto geek here, comments inline.
> 
> On 05.05.2017 22:30, Steffan Karger wrote:
>> +control channel messages.  A typical initial negotiation is about 10 packets
>> +in each direction.  Assuming both initial negotation and renogatiations are
>> +at most 2^16 (65536) packets, and (re)negotiations happen each minute for
>> +each user (24/7)
> 
> Does 10 and 65536 represent the same actual thing here, where 10 is a 
> practical real-world estimate, and 65536 is an extremely conservative 
> estimate?

Exactly.

> Or does it mean that each user will cause a total of 65536
> (re)negotiation packets in his lifetime? I think using a conservative 
> estimate is a good idea, but the large difference is somewhat confusing 
> (and I'm not entirely sure I get the correct meaning myself).

Good point, I'll try to make this more clear.

Maybe useful as background information:  I am really trying to keep this
section short, because I fear otherwise people will just "TL;DR" and
skip it.  But that does result in a high information density.

>> this limits the tls\-crypt key lifetime to 8171 year divided
> 
> 8171 years (just a typo I suppose, but it's significant to the meaning 
> of the sentence).

Ah, yes.  This is a Dutch-English mixup - the Dutch (mostly) don't use
plural for more-then-one years.  Will fix too.

-Steffan

