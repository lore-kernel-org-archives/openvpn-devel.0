References: <1456016892-8671-1-git-send-email-steffan@...1856...>
	<1456016892-8671-2-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56CB1220.5040803@...1227...>
Date: Mon, 22 Feb 2016 14:50:24 +0100
MIME-Version: 1.0
In-Reply-To: <1456016892-8671-2-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Clean up get_tls_handhake_key()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net



Am 21.02.16 um 02:08 schrieb Steffan Karger:
> This function contained *much* more code than required.  This commit
> cleans up the function:
>  * Merge the handling of inline and non-inline code.
>  * Don't double-check key.2, must_have_n_keys() already checks that
>  * Remove stale references to 'passphrase' - we no longer support those
>
> This commit should not change any behaviour except for log messages.
>
>
I would like to keep that error message about free-form files in 2.4
since 2.4 is the first version not to warn but also to bail out on this
change with an error message.
We can change the error message not have the filename in it, something
like "tls-auth option does have not static key format ... "
                     
Otherwise it gets an ACK from me.

Arne

