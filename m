From: Arne Schwabe <arne@...1227...>
References: <56CB1220.5040803@...1227...>
	<1456151046-16047-1-git-send-email-steffan@...1856...>
Message-ID: <56CB2256.3090507@...1227...>
Date: Mon, 22 Feb 2016 15:59:34 +0100
MIME-Version: 1.0
In-Reply-To: <1456151046-16047-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 2/2 v2] Clean up get_tls_handhake_key()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net



Am 22.02.16 um 15:24 schrieb Steffan Karger:
> This function has *much* more code than required.  This commit cleans up
> the function:
>  * Merge the handling of inline and non-inline code.
>  * Don't double-check key.2, since must_have_n_keys() already does that
>    (but keep the message about dropped passphrase support in 2.4).
>  * Remove stale references to 'passphrase' - we no longer support those
>
> This commit should not change any behaviour except for log messages.
>
> v2: Leave message about dropped passphrase support in place - this option
>     was dropped in 2.4, so it is indeed better to be clear about it.

ACK. Thanks for keeping the log message.

Arne



