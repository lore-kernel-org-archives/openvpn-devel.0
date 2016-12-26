References: <1482705505-20302-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4aed63c9-de83-1e09-6d98-394d7f5bd705@...1227...>
Date: Mon, 26 Dec 2016 09:36:34 +0000
MIME-Version: 1.0
In-Reply-To: <1482705505-20302-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Document that RSA_SIGN can also request
 TLS 1.2 signatures
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

Am 25.12.16 um 22:38 schrieb Steffan Karger:
> Ever since we support TLS 1.2 (OpenVPN 2.3.3+), the RSA_SIGN might not
> only request MD5-SHA1 'TLS signatures', but also other variants.
> Document this by updating the implementation hints, and explicitly
> stating that we expect a PKCS#1 1.5 signature.

ACK. I ran into this. ;)

Arne

