MIME-Version: 1.0
In-Reply-To: <830a17f8babbca92e21d64c1324a15b1.squirrel@...2257...>
References: <4e9ea26fee7e606cdb0636dd377bf1bc.squirrel@...2257...>
 <20171111134758.7373-1-steffan@...1856...>
 <830a17f8babbca92e21d64c1324a15b1.squirrel@...2257...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 15 Nov 2017 10:13:24 +0100
Message-ID: <CAA1AbxLEEDgqOwbz4ZmoQmXCsh-S68c3HvG0D541CLw4vtXUrw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Add per session pseudo-random jitter
 to --reneg-sec intervals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Simon Matter <simon.matter@...2249...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 15 November 2017 at 07:50, Simon Matter <simon.matter@...2249...> wrote:
> Hi Steffan,
>
> While running your v3 version of the patch I found an issue with the
> modified logging. It gives the following error while building
>
> gcc -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../../include
> -I../../src/compat       -DPLUGIN_LIBDIR=\"/usr/lib64/openvpn/plugins\"
> -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
> -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
> -m64 -mtune=generic -std=c99 -c -o ssl.o ssl.c
> ssl.c: In function 'tls_process':
> ssl.c:2735:9: warning: format '%lld' expects argument of type 'long long
> int', but argument 3 has type 'time_t' [-Wformat=]
>          msg(D_TLS_DEBUG_LOW, "TLS: soft reset sec=%lld/%d bytes="
> counter_format
>          ^
> and the log output is also corrupted
>
> TLS: soft reset sec=14774687501680/336605974
> bytes=18446744069414584320/581335 pkts=0/0
> TLS: soft reset sec=14787572403571/77375 bytes=18446744069414584320/885
> pkts=0/-1080308296
> TLS: soft reset sec=14164802145506/6746662
> bytes=18446744069414584320/86778 pkts=0/0
> TLS: soft reset sec=15264313773538/186529 bytes=18446744069414584320/1108
> pkts=0/13935244
>
> Please have a look at the attached v4 patch which fixes it for me. The
> output is now
>
> TLS: soft reset sec=3474/3474 bytes=8470454/-1 pkts=108673/0
> TLS: soft reset sec=3489/3489 bytes=429623769/-1 pkts=656033/0
> TLS: soft reset sec=3517/3517 bytes=89365/-1 pkts=877/0
> TLS: soft reset sec=3537/3537 bytes=206142/-1 pkts=1123/0
>
> which seems reasonable to me.
> In the patch I've modified the lines below:
>
>          msg(D_TLS_DEBUG_LOW,
> -            "TLS: soft reset sec=%d bytes=" counter_format "/%d pkts="
> counter_format "/%d",
> -            (int)(ks->established + session->opt->renegotiate_seconds -
> now),
> +            "TLS: soft reset sec=%d/%d bytes=" counter_format "/%d pkts="
> counter_format "/%d",
> +            (int)(now - ks->established), session->opt->renegotiate_seconds,
>              ks->n_bytes, session->opt->renegotiate_bytes,
>
> I'm not a developer and not a git user, so please accept my hand crafted
> patch work :-)

Uch.  Good find.  Since we recently decided that the right way to
print a time_t is to cast to long long and use the %lld format
specifier, I wanted to do that here too. I did the latter, but forgot
the first and didn't notice because on my x64 system time_t actually
*is* a long long (so no compiler warnings).

I'll send a follow-up version that incorporates the comments of both
Simon's, probably tomorrow.

-Steffan

