References: <1494016221-21268-1-git-send-email-steffan.karger@...1435...>
From: Magnus Kroken <mkroken@...277...>
Message-ID: <9130e0b4-73ca-5307-dda8-7f1451b459c5@...277...>
Date: Sun, 7 May 2017 11:39:12 +0200
MIME-Version: 1.0
In-Reply-To: <1494016221-21268-1-git-send-email-steffan.karger@...1435...>
Content-Language: en-US
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
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Steffan

Non-crypto geek here, comments inline.

On 05.05.2017 22:30, Steffan Karger wrote:
> +control channel messages.  A typical initial negotiation is about 10 packets
> +in each direction.  Assuming both initial negotation and renogatiations are
> +at most 2^16 (65536) packets, and (re)negotiations happen each minute for
> +each user (24/7)

Does 10 and 65536 represent the same actual thing here, where 10 is a 
practical real-world estimate, and 65536 is an extremely conservative 
estimate? Or does it mean that each user will cause a total of 65536 
(re)negotiation packets in his lifetime? I think using a conservative 
estimate is a good idea, but the large difference is somewhat confusing 
(and I'm not entirely sure I get the correct meaning myself).

> this limits the tls\-crypt key lifetime to 8171 year divided

8171 years (just a typo I suppose, but it's significant to the meaning 
of the sentence).

/Magnus

