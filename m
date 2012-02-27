MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <4F4BE07E.70603@...1550...>
References: <4F4BE07E.70603@...1550...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Mon, 27 Feb 2012 22:37:00 +0100
Message-ID: <CAP+U6tJFjY8g3bNTcjCKoU+W2hg3=kaPfYS2XGp4Lc1BUNTbAA@...278...>
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

2012/2/27 Igor Novgorodov <igor@...1550...>:
> The attached patch adds checking for PolarSSL version on crypto_polarssl.c
> and depending on which version we are using (1.0.x or 1.1.x) chooses a new
> shiny havege_random() function, or an old ugly while{} loop hack to generate
> randomness.

Your patch removes the code that causes havege_init() to only be
called once. You never want to initialise your PRNG more than once,
otherwise you increase the risk that your randomness is predictable.
So please revert that part of your patch.

(The rest looks fine, although I haven't tested it and don't have any
experience with PolarSSL.)

Cheers
Fabian

