MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <4F4C6A50.5070103@...1550...>
References: <4F4BE07E.70603@...1550...>
	<CAP+U6tJFjY8g3bNTcjCKoU+W2hg3=kaPfYS2XGp4Lc1BUNTbAA@...278...>
	<4F4C6A50.5070103@...1550...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Tue, 28 Feb 2012 08:39:57 +0100
Message-ID: <CAP+U6t+d3ZJPdTMAH7d==HzJUmW3o=bPGRKJ4b0hGwT8KyDsRA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 01/02] Add support for PolarSSL 1.1.x
	branch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Igor Novgorodov <igor@...1550...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Igor,

2012/2/28 Igor Novgorodov <igor@...1550...>:
> On 28.02.2012 1:37, Fabian Knittel wrote:
>> Your patch removes the code that causes havege_init() to only be
>> called once. You never want to initialise your PRNG more than once,
>> otherwise you increase the risk that your randomness is predictable.
>> So please revert that part of your patch.
>
> Yes, my fault. I didn't notice that the variable was static, so i though
> that it was local-scope only and removed the check... The fixed patch is attached

Thanks!

>> ([...], although I haven't tested it and don't have any
>> experience with PolarSSL.)

Maybe Adriaan or someone else can take a quick peek and give a full-hearted ACK?

Cheers
Fabian

