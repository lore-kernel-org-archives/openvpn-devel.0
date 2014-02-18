Message-ID: <53031BAD.8020407@...1856...>
Date: Tue, 18 Feb 2014 09:37:01 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <5302AADC.80801@...277...>
In-Reply-To: <5302AADC.80801@...277...>
Subject: Re: [Openvpn-devel] ECDH support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi Piotr,

On 18-02-14 01:35, pietrek -- wrote:
> It's my first contribution, so I could make some mistakes ;)

Thank you!

> In attached patch I added ECDH support to openvpn with openssl.
> Eliptic Curves generation is, in contrast to Diffie-Hellman very fast,
> so I do it on every server initialization.

Nice to see someone is willing to touch the crypto parts of OpenVPN!
I've been hacking on ECDH support myself too, based on a patch of Jan
Just Keijser of about a your ago. I've pushed my work to a public branch
on github:
https://github.com/syzzer/openvpn/commits/ecdh-squashed

I haven't sent this to the mailing list yet, because some of the
ECDH/ECDSA cipher modes didn't work and I wanted to investigate further,
but then life got in the way.

Right now I'm a bit in a hurry, but I'll definitely take a better look
at your patches later. Let's see if we can get all the EC stuff working!

Regards,
-Steffan

