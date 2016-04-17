References: <1460910186-7175-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5713C4DE.50701@...1227...>
Date: Sun, 17 Apr 2016 19:16:14 +0200
MIME-Version: 1.0
In-Reply-To: <1460910186-7175-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH (2.3)] Restrict default TLS cipher list
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

Am 17.04.16 um 18:23 schrieb Steffan Karger:
> In the past years, the internet has been moving forward wrt deprecating
> older and less secure ciphers.  Let's follow this example in OpenVPN and
> also restrict the default list of negotiable TLS ciphers in 2.3.x.
> 
> This disables the following:
>  * Export ciphers (these are broken on purpose...)
>  * Ciphers in the LOW and MEDIUM security cipher list of OpenSSL
>    The LOW suite will be completely removed from OpenSSL in 1.1.0,
>    the MEDIUM suite contains ciphers like RC4 and SEED.
>  * Ciphers that are not supported by OpenVPN anyway (cleans up the list)
> 
> Note that users are able to override this default, using --tls-cipher, if
> they for some reason need ciphers that are now disabled by default.

ACK (like in master)
Changing this in 2.3.x might break some configs. In my Android client
the last change broke various config, a few broken OpenSSL installations
but mainly custom "hardening" by specifying a very small cipher list
with tls-cipher.

Arne


