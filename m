Message-ID: <52C6B86D.6070503@...1227...>
Date: Fri, 03 Jan 2014 14:17:33 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <20131230205032.GH226@...1296...>	<1388607026-12297-1-git-send-email-steffan@...1856...>
	<1388607026-12297-7-git-send-email-steffan@...1856...>
In-Reply-To: <1388607026-12297-7-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 6/6] Disable export ciphers by default
 for OpenSSL builds.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 01.01.14 21:10, schrieb Steffan Karger:
> Export ciphers are deliberately weak ciphers, and not fully supported by
> OpenVPN since ephemeral RSA support has been removed a few commits ago.
> This commit removes them from the default cipher list to avoid confusion.
>
> PolarSSL does not support export ciphers, so no action required there.
>
ACK. But isn't is better to use good to do the !EXP just in case and for
consistency for PolarSSL as well.

Arne


