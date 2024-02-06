Message-ID: <99807c33-46f1-4f96-8a69-bde36748d6d3@...1227...>
Date: Tue, 6 Feb 2024 15:29:02 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20240206141057.46249-1-frank@...2641...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20240206141057.46249-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] documentation: Update and fix
 documentation for --push-peer-info
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
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Am 06.02.24 um 15:10 schrieb Frank Lichtenheld:
> - description of IV_PROTO was outdated, missing a lot
>    of flags
> - complete list of compression flags, but separate them out
> - various other style/grammar/typo fixes
> 
> Change-Id: I7f854a5a14d2a2a391ebb78a2a92b3e14cfd8be6
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>   doc/man-sections/client-options.rst | 44 ++++++++++++++++++++---------
>   1 file changed, 31 insertions(+), 13 deletions(-)
> 
> This patch should be applied to release/2.6 and master.
> 
> diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
> index 54c4ec63..cd3e565f 100644
> --- a/doc/man-sections/client-options.rst
> +++ b/doc/man-sections/client-options.rst
> @@ -339,31 +339,31 @@ configuration.
>     :code:`IV_PLAT=[linux|solaris|openbsd|mac|netbsd|freebsd|win]`
>           The client OS platform
>   
> -  :code:`IV_LZO_STUB=1`
> -        If client was built with LZO stub capability
> -
> -  :code:`IV_LZ4=1`
> -        If the client supports LZ4 compressions.
> -
>     :code:`IV_PROTO`
>       Details about protocol extensions that the peer supports. The
> -    variable is a bitfield and the bits are defined as follows
> -    (starting a bit 0 for the first (unused) bit:
> +    variable is a bitfield and the bits are defined as follows:
>   
> +    - bit 0: Reserved, should always be zero
>       - bit 1: The peer supports peer-id floating mechanism
>       - bit 2: The client expects a push-reply and the server may
>         send this reply without waiting for a push-request first.
>       - bit 3: The client is capable of doing key derivation using
>         RFC5705 key material exporter.
>       - bit 4: The client is capable of accepting additional arguments
> -      to the `AUTH_PENDING` message.
> +      to the ``AUTH_PENDING`` message.
> +    - bit 5: The client supports doing feature negotiation in P2P mode
> +    - bit 6: The client is capable of parsing and receiving the ``--dns`` pushed option
> +    - bit 7: The client is capable of sending exit notification via control channel using ``EXIT`` message. Also, the client is accepting the protocol-flags pushed option for the EKM capability
> +    - bit 8: The client is capable of accepting ``AUTH_FAILED,TEMP`` messages
> +    - bit 9: The client is capable of dynamic tls-crypt
>   



> +    :code:`IV_COMP_STUB=1` and :code:`IV_COMP_STUBv2=1`
> +        If the client supports stub compression.
> +

Maybe add a note that IV_COMP_STUB and IV_LZO_STUB are *not* identical 
or compatible. (byte swap)


>   
>     :code:`IV_PLAT_VER=x.y`
>           The version of the operating system, e.g. 6.1 for Windows 7.
> +        This is only sent on Windows operating systems.


This is wrong. My android client also send this as setenv IV_PLAT_VER is 
allowed. And openvpn3 based clients also send this iirc.

Arne

