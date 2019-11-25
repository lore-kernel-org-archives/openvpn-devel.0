References: <20191114102205.22429-1-juliusz@...2525...>
 <fb18ba3c-7ee6-46ba-04e0-5a9a14b955d0@...2080...>
From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <2fe81cc4-783c-41af-0423-d3ade1025940@...2525...>
Date: Mon, 25 Nov 2019 20:29:31 +0100
MIME-Version: 1.0
In-Reply-To: <fb18ba3c-7ee6-46ba-04e0-5a9a14b955d0@...2080...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL with OpenVPN v2.4.8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net
Cc: David Garske <david@...2525...>

Hi David,

I apologize for the delayed response. I will rebase our OpenVPN work off 
of the master branch this week in anticipation for a possible inclusion 
in version 2.5.

Regarding your question "What kind of commitment will we see from the 
WolfSSL organization?":
We have a large customer driving the use of wolfSSL with OpenVPN. We've 
done the initial porting and testing. We will update the port when 
needed and continue to support this effort.
We will also be making public marketing posts and annoucements for 
OpenVPN support on our blog (https://www.wolfssl.com/blog/) and 
subscribed mailing lists.

We understand your concern about the intrusiveness of this patch. The 
majority of insertions occur in the configure and try to follow the 
structure of how other cryptographic backends are compiled against. The 
"Emulate XXXXX since these are defined as macros" additions are 
unfortunately necessary as these functions are defined as macros in our 
library. AC_CHECK_FUNCS will not check if the function exists behind a 
macro. Defining these macros in the configure script allows for minimal 
interference in the rest of OpenVPN code. The rest of the changes in the 
patch are library inclusions as some things are defined in slightly 
different locations than OpenSSL. The file <wolfssl/options.h> holds the 
configure options for the wolfSSL library. It is necessary to include so 
that the header files know what should be included and defined.

I hope this email clears things up as to why some changes were necessary.

Sincerely
Juliusz

On 14/11/2019 12:25, David Sommerseth wrote:
> On 14/11/2019 11:22, Juliusz Sosinowicz wrote:
>> From: David Garske <david@...2525...>
>>
>> wolfSSL:
>>
>> Support added in: https://github.com/wolfSSL/wolfssl/pull/2503
>>
>> ```sh
>> git clone https://github.com/wolfSSL/wolfssl.git
>> cd wolfssl
>> ./autogen.sh
>> ./configure --enable-opensslall --enable-des3 --enable-crl --enable-certgen --enable-certext --enable-aesctr --enable-sessioncerts CFLAGS="-DWOLFSSL_DES_ECB -DHAVE_EX_DATA"
>> make
>> sudo make install
>> ```
>>
>> OpenVPN:
>>
>> ```sh
>> autoreconf -i -v -f
>> ./configure --with-crypto-library=wolfssl
>> make
>> make check
>> sudo make install
>> ```
> NAK.
>
> This patch adds a new feature to the 2.4 branch.  We don't really want to do
> that, especially if the change is intrusive (13 files changed, 108 insertions
> << that is intrusive).  WolfSSL support will at best see the light in the
> coming 2.5 release (At the hackathon we aim for late 2020Q1 or 2020Q2)
>
> In previous rounds we have asked a lot of questions; there has been no real
> responses to those.  This has not even been touched in the relation to this patch.
>
> One good thing I do see, is that it seems to try to use an OpenSSL support
> layer in WolfSSL - which is good.  But then I wonder why we see additions like
> this all over.
>
> +#ifdef ENABLE_CRYPTO_WOLFSSL
> +#include <wolfssl/options.h>
> +#endif
>
> In addition, the change in configure.ac with all the AC_DEFINE lines, tagged
> with "Emulate XXXXX since these are defined as macros" is also making a lot of
> mess.
>
> And then comes the most critical point to all of this:  Who will maintain
> WolfSSL support in OpenVPN once this has been applied?  What kind of
> commitment will we see from the WolfSSL organization?
>
> The OpenVPN developers community will have an IRC meeting next Thursday (Nov
> 21 @ 20:00 CET, #openvpn-meeting on FreeNode [1]).  I strongly recommend you
> to attend this meeting to follow up your request.
>
>
> [1] You need to have your nick registered to join
>      <https://freenode.net/kb/answer/registration>
>
>

