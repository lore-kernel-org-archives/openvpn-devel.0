References: <1465388443-15484-1-git-send-email-steffan@...1856...>
	<1465388443-15484-4-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <b3f65c74-2b47-2a1b-1cab-c084e636a1ae@...1227...>
Date: Wed, 8 Jun 2016 16:23:23 +0200
MIME-Version: 1.0
In-Reply-To: <1465388443-15484-4-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 3/5] Add client-side support for cipher
 negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net


> +#ifdef ENABLE_CRYPTO
> +  if (c->options.pull)
> +    {
> +      /* If we use --pull, we don't know the crypto overhead yet. */
> +      msg (M_WARN, "*** Account for max crypto overhead ***");

That message will surely confuse users.

Arne


