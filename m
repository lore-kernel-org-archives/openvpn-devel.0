Message-ID: <21963270-a013-9cdd-fc21-569e366c6e19@...1227...>
Date: Sun, 26 Feb 2023 15:10:07 +0100
MIME-Version: 1.0
References: <20230130172936.3444840-1-arne@...1227...>
 <20230130172936.3444840-2-arne@...1227...> <Y/suKJIyDKICDxXu@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <Y/suKJIyDKICDxXu@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 2/5] Fix unaligned access in
 macOS/Solaris hwaddr
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


Am 26.02.2023 um 11:02 schrieb Gert Doering:
> Hi,
>
> On Mon, Jan 30, 2023 at 06:29:33PM +0100, Arne Schwabe wrote:
>> The undefined behaviour USAN clang checker found this.
>>
>> This fix is a bit messy but so are the original structures.
> I wonder...
>
>> +                    struct sockaddr_dl sdl = { 0 };
>> +                    memcpy(&sdl, &ifr.ifr_addr, sizeof(ifr.ifr_addr));
>> +                    memcpy(rgi->hwaddr, LLADDR(&sdl), 6);
>>                       rgi->flags |= RGI_HWADDR_DEFINED;
> ... why you keep the "sockaddr_dl" intermediate - this was useful
> for "we use it as a pointer", but doing two memcpy() with a huge
> explanation above looks weird.
>
> LLADDR on FreeBSD is
>
> #define LLADDR(s) ((caddr_t)((s)->sdl_data + (s)->sdl_nlen))
>
> (to operate on a "struct sockaddr_dl")
>
> struct ifaddr has
>
> struct ifaddr {
>          struct  sockaddr *ifa_addr;     /* address of interface */
>          struct  sockaddr *ifa_dstaddr;  /* other end of p-to-p link */
>          struct  sockaddr *ifa_netmask;  /* used to determine subnet */
>
> ... so the first memcpy() isn't actually copying the MAC address around,
> just a bunch of pointers, and then we dereference the first of them
> for the second memcpy(), using the dereferencing macro for a
> "sockaddr_dl" structure.

The problem is that LLVM ASAN does not like access to an unaligned 
struct. Even if it just accessing a member to deference it. So you are 
right that it is just copying a bunch of pointers, to not triggers the 
warning, we have to do this nonsense. The compiler will even optimise 
this then away again on platforms that have no problem with unaligned 
accesses.


> FreeBSD also has
>
> #define IF_LLADDR(ifp)                                                  \
>      LLADDR((struct sockaddr_dl *)((ifp)->if_addr->ifa_addr))
>
> which sounds like "feed in an *ifr, out comes a pointer for the
> memcpy() to rgi->addr".

Yes but you will still get warning about casting a smaller struct to a 
larger struct and that being a bad idea.


Arne


