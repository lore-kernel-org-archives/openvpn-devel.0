MIME-Version: 1.0
In-Reply-To: <567AB995.70204@...1147...>
References: <1450123758-31641-1-git-send-email-steffan@...1856...>
	<566F5B01.8020109@...2080...>
	<20151215075312.GN24952@...1296...>
	<5670890D.7050501@...1147...>
	<CAA1AbxJbKeLqeDgBVLJ4HB22NPv+rbL=nB6bXiTqv+d_BLuRbg@...278...>
	<567AB995.70204@...1147...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 23 Dec 2015 17:26:01 +0100
Message-ID: <CAA1AbxKP-QTtGZT4DW+52qJs1wX8XnNX1XYcKa0UD-8tuHKE=w@...278...>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Dec 23, 2015 at 4:11 PM, Jan Just Keijser <janjust@...1147...> wrote:
> Steffan Karger wrote:
>>
>> [...]
>> Just use mbedtls ;-)
>>
>> OpenSSL 1.0.2 has been released almost a year ago, so upcoming distro
>> releases will probably contain 1.0.2+ (e.g. Ubuntu 15.10 already has
>> it, 16.04 LTS will have it too).  Should not take too long, right?
>>
>> As you've probably noticed in the other thread, I don't particularly
>> like the idea of adding that extra code.  But I won't actively oppose
>> such a patch either.
>
> I justed wanted to get back to this one one more time: attached is a patch
> to ssl_openssl.c that works in combination with Steffan's patch to check for
> expired certificates. This new patch-patch works on my CentOS 6 (openssl
> 1.0.1e) box :)  This patch was done against the v2.3.9 code base and I have
> no clue how to get it into proper git formatting ;)

This looks very promising!  Thanks.  Do you have any clue if this will
work on pre-1.0.1 too?  (If not, I can test, but if you do, I can save
myself the trouble.)

-Steffan

