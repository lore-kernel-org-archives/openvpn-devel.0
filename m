Message-ID: <52BC659F.6040402@...1227...>
Date: Thu, 26 Dec 2013 18:21:35 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <52ADF633.8040003@...1856...>
In-Reply-To: <52ADF633.8040003@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Use RSA_generate_key_ex() instead of
 deprecated, RSA_generate_key()
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

Am 15.12.13 19:34, schrieb Steffan Karger:
> Hi,
>
> Attached a patch that should close issue #197. This patch moves from
> using the deprecated RSA_generate_key() to the 'new'
> RSA_generate_key_ex() to generate ephemeral RSA keys. This patch does
> not change OpenVPN's behaviour.
>
> One note on the implementation though; the code generates one ephemeral
> RSA key that is used during the entire lifetime of an OpenVPN process.
> If OpenSSL requests a new (ephemeral) key, it will keep on returning the
> same (usually rather small) key. Not the best solution.
>
>
ACK from me. This is code is *very* similar to the actual
RSA_generate_key key function which is also a compatbility layer around
RSA_generate_key_ex. I used to include a copy of RSA_generate_key in the
Android openvpn version since Android's openssl library is build without
depracted interfaces.

Arne


