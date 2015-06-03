MIME-Version: 1.0
In-Reply-To: <556E9FA7.7090703@...1227...>
References: <CAEsd45RvRfmqetu-EoFjSdyBk5F9X1K5muPGu-+_+30TMNOU_A@...278...>
	<556E9FA7.7090703@...1227...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 3 Jun 2015 06:21:31 -0400
Message-ID: <CAEsd45SekuKKq70e2v88ohUxhDkoUqvE4G7qS9N_HpQ4CEV0Pw@...278...>
Subject: Re: [Openvpn-devel] [Patch] Version 2: Fail if options have extra
	parameters
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
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wed, Jun 3, 2015 at 2:33 AM, Arne Schwabe <arne@...1227...> wrote:
> ACK. But some things I noticed (should go into separate patch)
>
> We do not catch
>
> --connection foo, it is silently ignored

I noticed a few such problems, mostly in options that I couldn't find
consistent documentation for. I didn't want to risk introducing
problems until I understood them better. I expect to submit individual
patches for each one at some point.

