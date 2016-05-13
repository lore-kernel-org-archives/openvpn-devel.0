References: <1463122492-701-1-git-send-email-steffan@...1856...>
	<201605130732.u4D7Wg3R033181@...2054...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <57364A87.1000608@...68...>
Date: Fri, 13 May 2016 23:43:35 +0200
MIME-Version: 1.0
In-Reply-To: <201605130732.u4D7Wg3R033181@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix polarssl / mbedtls
	builds
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
To: openvpn-devel@lists.sourceforge.net

Am 13.05.2016 um 09:32 schrieb Gert Doering:
> ACK.  Tested on FreeBSD 9.3, all 3 tests in "make check", works.
> 
> It is in line with the much better tested code in master, and with the 
> man page:
> 
>  "The default for --tls-cipher is to use PolarSSL's default cipher
>   list when using PolarSSL or (...) when using OpenSSL"
> 
> Your patch has been applied to the release/2.3 branch.
> 
> commit 629baad8f89af261445a2ace03694601f8e476f9 (release/2.3)
> Author: Steffan Karger
> Date:   Fri May 13 08:54:52 2016 +0200
> 
>      Fix polarssl / mbedtls builds
> 
>      Signed-off-by: Steffan Karger <steffan@...1856...>
>      Acked-by: Gert Doering <gert@...1296...>
>      Message-Id: <1463122492-701-1-git-send-email-steffan@...1856...>
>      URL: http://article.gmane.org/gmane.network.openvpn.devel/11647
>      Signed-off-by: Gert Doering <gert@...1296...>


Thanks to both of you.  The FreeBSD ports' POLARSSL option is now fixed,
and I have removed the BROKEN mark.



