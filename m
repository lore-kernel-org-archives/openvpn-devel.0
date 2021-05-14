References: <20210512131511.1309914-1-arne@...1227...>
 <20210512131511.1309914-10-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c21f848a-adb1-88b3-7d7f-b8fb3152f617@...2080...>
Date: Fri, 14 May 2021 15:27:10 +0200
MIME-Version: 1.0
In-Reply-To: <20210512131511.1309914-10-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 9/9] Add detailed man page section to
 setup a OpenVPN setup with peer-fingerprint
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 12/05/2021 15:15, Arne Schwabe wrote:
> This is meant to give new users a quickstart for a useable OpenVPN
> setup. Our own documentation is lacking in this regard and many often
> tutorials that can be found online are often questionable in some
> aspects.
> 
> Linking the invidiaul RST file on github also give a tutorial
> in a nicely formatted way.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   Changes.rst                              |   4 +
>   doc/Makefile.am                          |   1 +
>   doc/man-sections/example-fingerprint.rst | 194 +++++++++++++++++++++++
>   3 files changed, 199 insertions(+)
>   create mode 100644 doc/man-sections/example-fingerprint.rst
> 
> diff --git a/Changes.rst b/Changes.rst
> index 9185b55f7..f1c739f99 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -25,6 +25,10 @@ Certificate pinning/verify peer fingerprint
>       fingerprint of the peer. The option takes use a number of allowed
>       SHA256 certificate fingerprints.
>   
> +    See the man page section "Small OpenVPN setup with peer-fingerprint"
> +    for a tutorial how to use this feature. This is also available online
> +    under https://github.com/openvpn/openvpn/blob/master/doc/man-sections/example-fingerprint.rst
> +
>   TLS mode with self-signed certificates
>       When ``--peer-fingerprint`` is used, the ``--ca`` and ``--capath`` option
>       become optional. This allows for small OpenVPN setups without setting up
> diff --git a/doc/Makefile.am b/doc/Makefile.am
> index e411f5f9d..e7022c085 100644
> --- a/doc/Makefile.am
> +++ b/doc/Makefile.am
> @@ -25,6 +25,7 @@ dist_noinst_DATA = \
>   	man-sections/connection-profiles.rst \
>   	man-sections/encryption-options.rst \
>   	man-sections/examples.rst \
> +	man-sections/examples.rst \

I suspect you intended to add doc/man-sections/example-fingerprint.rst 
instead of adding examples.rst twice.

To make this file appear in the openvpn(8) man page, you also need to 
include it from doc/openvpn.8.rst.

Maybe we should also consider moving all these configuration examples 
out of the main openvpn(8) man page and into a openvpn-examples(7) man 
page.  This can be done after this change, though.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


