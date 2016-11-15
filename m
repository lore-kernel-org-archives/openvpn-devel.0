References: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
	<1478636302-9678-3-git-send-email-steffan.karger@...1435...>
	<e5e524cb-1b41-2dab-8204-a4e0f49334c7@...1227...>
	<61283c80-0326-8584-5097-c3f31e84d120@...1856...>
	<36376702-ce12-a462-0b34-1b547683de67@...1227...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <4c09184d-76b7-bcfc-727f-2b957be490a6@...1435...>
Date: Tue, 15 Nov 2016 10:45:08 +0100
MIME-Version: 1.0
In-Reply-To: <36376702-ce12-a462-0b34-1b547683de67@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/5] Add control channel encryption
 (--tls-crypt)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 15-11-16 03:13, Arne Schwabe wrote:
> I think that
> 
>     cipher_ctx_reset (ctx->cipher, tag);
> 
> belongs into the encrypt block instead of the auth block.

Yes and no.  It's part of the encryption, but SIV uses the auth tag as
the IV, so this function needs to be called within the scope where the
tag pointer is available.  I will add a comment to make this more clear.

I'll send a v2 with your comments addressed in a few minutes.

Thanks again!

-Steffan


