Message-ID: <c6ac46c6-53a4-4b20-9e73-98b7be5bce51@...2525...>
Date: Mon, 12 Feb 2024 10:52:14 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20240209155109.110542-1-juliusz@...2525...>
 <ZcZVUp9R6l0WWpDb@...2685...>
From: Juliusz Sosinowicz <juliusz@...2525...>
In-Reply-To: <ZcZVUp9R6l0WWpDb@...2685...>
Subject: Re: [Openvpn-devel] [PATCH] wolfssl: include "ssl.h" by
 "src/openvpn/ssl.h"
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Frank,

thank you for the explanation. I did not test out-of-tree builds before 
submitting the patch. I'll try to implement Gert's solution and write a 
Makefile patch instead.

Sincerely
Juliusz Sosinowicz

On 09/02/2024 17:39, Frank Lichtenheld wrote:
> On Fri, Feb 09, 2024 at 04:51:09PM +0100, Juliusz Sosinowicz wrote:
>> Including "ssl.h" conflicts with the wolfSSL ssl.h header file. The include/wolfssl directory is included before openvpn/src. include/wolfssl needs to be included so that openvpn can pick up wolfSSL compatibility headers instead of OpenSSL headers without changing the paths.
> This breaks out-of-tree builds. Currently we only add top_buildir to CFLAGS
> (for config.h) but NOT top_srcdir. For in-tree builds these are identical
> so the patch might appear to work. But it breaks otherwise. Further changes
> to buildsystem configuration would be required.
>
> Regards,

