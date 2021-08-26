References: <20210826061725.22169-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <82b343b9-63e7-d069-05ac-dea44a39f193@...1227...>
Date: Thu, 26 Aug 2021 13:39:44 +0200
MIME-Version: 1.0
In-Reply-To: <20210826061725.22169-1-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] route.c: pass the right parameter to
 IN6_IS_ADDR_UNSPECIFIED
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 26.08.21 um 08:17 schrieb Antonio Quartulli:
> IN6_IS_ADDR_UNSPECIFIED on most systems is defined as a macro that
> expects a struct in6_addr* argument.
> 
> In one instance we are passing the right address but using a wrong type.
> Fix this invocation by properly passing the right pointer.
> 
> This issue might become more critical on systems implementing
> IN6_IS_ADDR_UNSPECIFIED as a function rather than a macro.

This happens if you try to compile openvpn with the Android NDK but
without TARGET_ANDROID but with TARGET_LINUX.



#define IN6_IS_ADDR_UNSPECIFIED(a) \
  ((((a)->s6_addr32[0]) == 0) && \
   (((a)->s6_addr32[1]) == 0) && \
   (((a)->s6_addr32[2]) == 0) && \
   (((a)->s6_addr32[3]) == 0))


So you get


/Users/arne/oss/android-sdk-macosx/ndk/23.0.7599858/toolchains/llvm/prebuilt/darwin-x86_64/sysroot/usr/include/netinet/in6.h:38:9:
note: expanded from macro 'IN6_IS_ADDR_UNSPECIFIED'
     (((a)->s6_addr32[1]) == 0) && \
       ~~~^ ~~~~~~~~~

/Users/arne/software/icsopenvpn/main/src/main/cpp/openvpn/src/openvpn/route.c:3375:14:
error: member reference base type '__u8' (aka 'unsigned char') is not a
structure or union
          if (!IN6_IS_ADDR_UNSPECIFIED(rgi6->gateway.addr_ipv6.s6_addr))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Acked-By: Arne Schwabe <arne@...1227...>

