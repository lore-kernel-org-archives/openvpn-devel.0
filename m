MIME-Version: 1.0
In-Reply-To: <4A13BBB4.8020101@...41...>
References: <4A13BBB4.8020101@...41...>
Date: Wed, 20 May 2009 13:45:49 +0300
Message-ID: <9e0cf0bf0905200345w3d0f7314m75cabed0b6220653@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.1_rc16 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: Openvpn-devel@lists.sourceforge.net, OpenVpn-Users <openvpn-users@lists.sourceforge.net>

On 5/20/09, James Yonan <jim@...41...> wrote:
>    5. In cryptoapi.c, renamed CryptAcquireCertificatePrivateKey to
>       OpenVPNCryptAcquireCertificatePrivateKey to work around
>       a symbol conflict in MinGW-5.1.4.

Too much rename.
Please revert at GetProcAddress and ERR_PACK.

