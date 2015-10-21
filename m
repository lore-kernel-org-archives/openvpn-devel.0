From: Arne Schwabe <arne@...1227...>
References: <1444383559-15788-1-git-send-email-janjust@...1147...>
	<1444948995-18720-1-git-send-email-steffan@...1856...>
	<1444948995-18720-2-git-send-email-steffan@...1856...>
Message-ID: <56274F00.6050501@...1227...>
Date: Wed, 21 Oct 2015 10:38:24 +0200
MIME-Version: 1.0
In-Reply-To: <1444948995-18720-2-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] polarssl: fix
 --client-cert-not-required
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



Am 16.10.15 um 00:43 schrieb Steffan Karger:
> PolarSSL 1.3 determines whether to use a client key/cert based on the
> private key and/or certificate structs being allocated or not.  We
> previously would always allocate the structs in
> tls_ctx_{client,server}_new(), which made polarssl clients without a
> client key/cert (can also be mgmt-external-key or pkcs11) fail to connect.
>
> Note that this bug is not present in OpenVPN 2.3, because PolarSSL 1.2
> does not contain the 'pk' abtraction layer and therefore behaves slightly
> different.
>
ACK. The code does exactly what the commit message says.

Arne

