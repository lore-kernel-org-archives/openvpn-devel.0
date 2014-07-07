Message-ID: <53BA6876.2050307@...1227...>
Date: Mon, 07 Jul 2014 11:29:26 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1404424065-24787-1-git-send-email-steffan@...1856...>
In-Reply-To: <1404424065-24787-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Don't issue warning for 'translate to
 self' tls-ciphers
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

Am 03.07.14 23:47, schrieb Steffan Karger:
> All cipher suite names supplied through --tls-cipher are translated by
> OpenVPN to IANA names, to get OpenSSL and PolarSSL configuration files
> compatible. OpenSSL however supports cipher suite group names, like
> 'DEFAULT', 'HIGH', or 'ECDH'. To make OpenVPN not complain about these,
> entries translating these to themselves were added to the translation
> table. However, to make OpenVPN not still complain, the deprecated-name
> check has to be reversed from 'if this is a deprecated name then complain'
> to 'if this is not a iana name, then complain'. Which this commit does.
>
>
ACK

