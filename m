Message-ID: <544EA791.60002@...1227...>
Date: Mon, 27 Oct 2014 21:14:09 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1414269324-14102-1-git-send-email-steffan@...1856...>
	<1414269324-14102-4-git-send-email-steffan@...1856...>
In-Reply-To: <1414269324-14102-4-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 3/6] polarssl: don't ignore failed
 ssl_init(), but ASSERT() on failure
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 25.10.14 22:35, schrieb Steffan Karger:
> Since key_state_ssl_init() returns void, it *must* succeed. By changing the
> 'if(a) { success } else ignore' into 'ASSERT(a); success', we make sure we
> don't fail (which we in practice don't do, because otherwise we would have
> had complaining users with hard to trace errors).
>
> This patch just changes the if() to an ASSERT(), but that causes a lot of
> indenting changes, making this patch look a lot bigger than it really is.
>
>
ACK. Bailing out on these kind of crypto errors seems better than to
continue in an unknown state.

Arne

