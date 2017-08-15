References: <20170812040546.8439-1-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <7f21e47a-5d35-7fff-eed7-cc29e9d0bfcb@...1856...>
Date: Tue, 15 Aug 2017 22:15:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170812040546.8439-1-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] ntlm: avoid breaking anti-aliasing rules
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 12-08-17 06:05, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
> 
> The problem is visible when compiling with -O2:
> 
> ntlm.c: In function ‘ntlm_phase_3’:
> ntlm.c:305:9: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>          if ((*((long *)&buf2[0x14]) & 0x00800000) == 0x00800000)
> 
> The spec suggests to interpret those 4 bytes as a long, but
> this needs to be done carefully.
> 
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
> 
> I have tried to make the statement more clear and "aliasing safe" at the same
> time. However, this is only compiled tested as I have no way to test the whole
> NTLM thing. Sorry :(
> 
> Cheers,
> 
>  src/openvpn/ntlm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
> index 65c1cbf5..a251c11d 100644
> --- a/src/openvpn/ntlm.c
> +++ b/src/openvpn/ntlm.c
> @@ -302,7 +302,8 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2,
>          /* Add target information block to the blob */
>  
>          /* Check for Target Information block */
> -        if ((*((long *)&buf2[0x14]) & 0x00800000) == 0x00800000)
> +        unsigned long *flags = (unsigned long *)(buf2 + 0x14);
> +        if ((*flags & htonl(0x00800000)) == htonl(0x00800000))
>          {
>              tib_len = buf2[0x28];            /* Get Target Information block size */
>              if (tib_len > 96)
> 


I *think* this will break the functionality.  Consider the following
test code:

#include <arpa/inet.h>
#include <stdio.h>

int main(char *argv[], int argc)
{
    unsigned char buf[4] = {0, 0, 0x80, 0};

    if ((*((long *)&buf[0]) & 0x00800000) == 0x00800000)
        printf("old: true\n");
    else
        printf("old: false\n");

    unsigned long *flags = (unsigned long *)(buf);
    if ((*flags & htonl(0x00800000)) == htonl(0x00800000))
        printf("new: true\n");
    else
        printf("new: false\n");

    return 0;
}

On amd64, this prints:

old: true
new: false

I'd expect some 'ntohl' call in this code somewhere, but that assumes
that the NTLM spec was designed somewhat sane and uses network byte order...

For now, I'd suggest to stick to just fixing the type-punned dereference
and leave out any htonl/ntohl calls.

-Steffan

