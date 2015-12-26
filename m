References: <1450123758-31641-1-git-send-email-steffan@...1856...>
	<566F5B01.8020109@...2080...>
	<20151215075312.GN24952@...1296...> <5670890D.7050501@...1147...>
	<CAA1AbxJbKeLqeDgBVLJ4HB22NPv+rbL=nB6bXiTqv+d_BLuRbg@...278...>
	<567AB995.70204@...1147...> <20151226091900.GU24952@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <567E60A9.6020006@...1856...>
Date: Sat, 26 Dec 2015 10:40:57 +0100
MIME-Version: 1.0
In-Reply-To: <20151226091900.GU24952@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Warn user if their certificate has
 expired
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 26-12-15 10:19, Gert Doering wrote:
> On Wed, Dec 23, 2015 at 04:11:17PM +0100, Jan Just Keijser wrote:
>> I justed wanted to get back to this one one more time: attached is a
>> patch to ssl_openssl.c that works in combination with Steffan's patch to
>> check for expired certificates. This new patch-patch works on my CentOS
>> 6 (openssl 1.0.1e) box :)  This patch was done against the v2.3.9 code
>> base and I have no clue how to get it into proper git formatting ;)
>
> Great discovery :-) - and it nicely works for me:
>
> Sat Dec 26 10:11:14 2015 OpenVPN 2.3_git [git:ssl-expire/0f7319906a9dff58+] amd64-unknown-freebsd7.4 [SSL (OpenSSL)] [LZO] [LZ4] [MH] [IPv6] built on Dec 26 2015
> Sat Dec 26 10:11:14 2015 library versions: OpenSSL 0.9.8q 2 Dec 2010, LZO 2.04
> Sat Dec 26 10:11:16 2015 WARNING: Your certificate has expired!
>
> this is about as old as it gets - thanks a lot.  Mogrified into a patch
> against git master with the SSL_free() moved to the right place attached
> below, for Steffan to ACK.

ACK, much wanted functionality and code looks good.

-Steffan

