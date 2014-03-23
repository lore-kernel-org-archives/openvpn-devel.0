Message-ID: <532EE33A.50103@...1227...>
Date: Sun, 23 Mar 2014 14:35:54 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1393684575-28112-1-git-send-email-steffan@...1856...>
	<1393684575-28112-3-git-send-email-steffan@...1856...>
In-Reply-To: <1393684575-28112-3-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Disable unsupported TLS cipher
 modes by default, cleans --show-tls output.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

On 01.03.2014 15:36, Steffan Karger wrote:
> This explicitly disables a number of tls ciphers that OpenVPN has currently
> no support for. OpenSSL will automatically detect this during negotiation,
> but --show-tls would erroneously show a number of unsupported ciphers.
>
>
ACK.

Arne

