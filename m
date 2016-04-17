References: <1460910164-7044-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5713C473.7070206@...1227...>
Date: Sun, 17 Apr 2016 19:14:27 +0200
MIME-Version: 1.0
In-Reply-To: <1460910164-7044-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH (master)] Further restrict default TLS
 cipher list
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

Am 17.04.16 um 18:22 schrieb Steffan Karger:
> In the past years, the internet has been moving forward wrt deprecating
> older and less secure ciphers.  Let's follow this example in OpenVPN and
> further restrict the default list of negotiable TLS ciphers.
> 
> Compared to earlier, this disables the following:
>  * Ciphers in the LOW and MEDIUM security cipher list of OpenSSL
>    The LOW suite will be completely removed from OpenSSL in 1.1.0,
>    the MEDIUM suite contains ciphers like RC4 and SEED.
>  * Ciphers that do not provide forward secrecy (static DH/ECDH keys)
>  * DSA private keys (rarely used, and usually restricted to 1024 bits)


ACK from me. The code looks good and the change makes sense to me.

Arne

