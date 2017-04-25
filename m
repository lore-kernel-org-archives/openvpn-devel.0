References: <20170413172609.29093-1-davids@...515...>
	<20170424143910.20118-1-davids@...515...>
	<20170424205738.GM30424@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <130a26d6-9af4-fb2f-eb7c-cc3211a1167e@...1856...>
Date: Tue, 25 Apr 2017 19:19:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170424205738.GM30424@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v5] Fix broken ./configure on systems
 without openssl.pc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 24-04-17 22:57, Gert Doering wrote:
> On Mon, Apr 24, 2017 at 04:39:10PM +0200, David Sommerseth wrote:
>> This patch have been tested on Scientic Linux 7.3 (RHEL clone) and
>> FreeBSD 10.3-RELEASE-p11.
>>
>> v5 - Remove the right OPENSSL_LIBS and preserve the old one
>>    - In PKG_CHECK_MODULES(), check for openssl instead of libssl
>>      + libcrypto
>>    - Fix tab/space issues once again
> [..]
> 
> This looks good for me.
> 
> FreeBSD 10.3, no pkg-config               -> works
> Gentoo, pkg-config                        -> works
> FreeBSD 7.3, no pkg-config, openssl 0.9.8 -> fails (as it should)
> 
>    checking for OPENSSL... no
>    checking additionally if OpenSSL is available and version >= 1.0.1... configure: error: OpenSSL version too old
> 
> NetBSD 7.0.1, pkg-config, openssl 1.0.1t  -> works
> OpenBSD 6.0, pkg-config, LibreSSL 2.4.2 (OPENSSL_VERSION_NUMBER 0x20000000L)
>                                           -> works
> 
> 
> I'd like to see a review from Steffan whether we've anything left that
> I didn't see in my setups (I run without setting env vars, with openssl
> installed "in the default places"), but for my machines, this is good to 
> go (=ACK).

This works fine with my OPENSSL_LIBS and OPENSSL_CFLAGS build setup too.
 Patch looks good.  So, ACK :)

-Steffan

