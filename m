MIME-Version: 1.0
In-Reply-To: <1465388443-15484-1-git-send-email-steffan@...1856...>
References: <1465388443-15484-1-git-send-email-steffan@...1856...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 8 Jun 2016 14:32:49 +0200
Message-ID: <CAA1AbxJ0MQH6UL-b1Y+n_nE74Jw1C7fZeNqpsFkYyjt_UFBVXw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add support for cipher negotiation
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Wed, Jun 8, 2016 at 2:20 PM, Steffan Karger <steffan@...1856...> wrote:
> Please test and provide comments.  I ran the 'make check' test suite, including
> t_client tests, and performed manual testing.  But, as Gert eloquently puts it,
> this is likely to 'break stuff in interesting ways', so more testing (and
> review) is very welcome!

For those of you that rather check out a github branch instead of
applying patches, I pushed my branch - plus some extra debug commits -
to https://github.com/syzzer/openvpn/tree/nego-squashed

-Steffan

