Message-ID: <567ACFDE.8060102@...1147...>
Date: Wed, 23 Dec 2015 17:46:22 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1450123758-31641-1-git-send-email-steffan@...1856...>
	<566F5B01.8020109@...2080...>
	<20151215075312.GN24952@...1296...>
	<5670890D.7050501@...1147...>
	<CAA1AbxJbKeLqeDgBVLJ4HB22NPv+rbL=nB6bXiTqv+d_BLuRbg@...278...>
	<567AB995.70204@...1147...>
	<CAA1AbxKP-QTtGZT4DW+52qJs1wX8XnNX1XYcKa0UD-8tuHKE=w@...278...>
In-Reply-To: <CAA1AbxKP-QTtGZT4DW+52qJs1wX8XnNX1XYcKa0UD-8tuHKE=w@...278...>
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Steffan Karger wrote:
> Hi,
>
> On Wed, Dec 23, 2015 at 4:11 PM, Jan Just Keijser <janjust@...1147...> wrote:
>   
>> Steffan Karger wrote:
>>     
>>> [...]
>>> Just use mbedtls ;-)
>>>
>>> OpenSSL 1.0.2 has been released almost a year ago, so upcoming distro
>>> releases will probably contain 1.0.2+ (e.g. Ubuntu 15.10 already has
>>> it, 16.04 LTS will have it too).  Should not take too long, right?
>>>
>>> As you've probably noticed in the other thread, I don't particularly
>>> like the idea of adding that extra code.  But I won't actively oppose
>>> such a patch either.
>>>       
>> I justed wanted to get back to this one one more time: attached is a patch
>> to ssl_openssl.c that works in combination with Steffan's patch to check for
>> expired certificates. This new patch-patch works on my CentOS 6 (openssl
>> 1.0.1e) box :)  This patch was done against the v2.3.9 code base and I have
>> no clue how to get it into proper git formatting ;)
>>     
>
> This looks very promising!  Thanks.  Do you have any clue if this will
> work on pre-1.0.1 too?  (If not, I can test, but if you do, I can save
> myself the trouble.)
>   

works on CentOS 5 too:
Wed Dec 23 17:44:40 2015 OpenVPN 2.3.9 x86_64-unknown-linux-gnu [SSL 
(OpenSSL)] [LZO] [EPOLL] [MH] [IPv6] built on Dec 23 2015
Wed Dec 23 17:44:40 2015 library versions: OpenSSL 0.9.8e-fips-rhel5 01 
Jul 2008, LZO 2.06
Wed Dec 23 17:44:40 2015 WARNING: Your certificate has expired!


however, I just realized there's a memory leak in my patch: I do an 
"SSL_free(ssl)" and then access the X509 cert - this X509 cert struct is 
(possibly) freed by the SSL_free() call . I/we should split the patch so 
that the SSL_free is done after all access to the X509 struct are done.

HTH,

JJK


