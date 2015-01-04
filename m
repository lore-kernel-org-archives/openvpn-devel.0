Message-ID: <54A92960.1000408@...1227...>
Date: Sun, 04 Jan 2015 12:52:00 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1408810901-24715-1-git-send-email-steffan@...1856...>
	<1420141569-11773-1-git-send-email-steffan@...1856...>
In-Reply-To: <1420141569-11773-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add option to disable Diffie Hellman
 key exchange by setting "--dh none"
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

On 01.01.2015 20:46, Steffan Karger wrote:
> As requested on the mailing list and in trac ticket #410, add an option to
> disable 'traditional' Diffie Hellman key exchange. People want to be able
> to create ecdh-only configurations.
>
> This patch also disables RSA key exchange by default for OpenSSL builds, to
> prevent that people who set "--dh none" but have an OpenSSL version that
> doesn't support ECDH end up with a less secure connection. Note that users
> that specify their own --tls-cipher override these defaults and thus can
> still use whatever OpenSSL supports (and might thus end up with less secure
> connections).
>
> PolarSSL does not allow to easily disable RSA key exchange during runtime,
> but its default compile options do not include RSA key exchange based
> cipher suites.
>
> Finally update the manpage to reflect the new behaviour, and while touching
> it change the text to motivate users towards a more secure configuration.
>
> v2 - disable RSA key exchange by default
>
>
ACK. On a side note we should document the default of tls-cipher
(DEFAULT:!EXP:!PSK:!SRP:!kRSA) in the man page.

Arne

