MIME-Version: 1.0
In-Reply-To: <1422042761-10014-1-git-send-email-steffan@...1856...>
References: <1422042761-10014-1-git-send-email-steffan@...1856...>
Date: Fri, 23 Jan 2015 22:43:14 +0200
Message-ID: <CAGyAFMX_OZfns4wS0UU2U1vptavjUrHO2Z-5kh8frJAYT6bq0g@...278...>
From: Lev Stipakov <lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Account for peer-id in frame size
	calculation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

ACK

Reproduced the problem with ping -s 1500 (also no compression) and
patch on both sides have fixed it.

2015-01-23 21:52 GMT+02:00 Steffan Karger <steffan@...1856...>:
> Data channel packet using P_DATA_V2 will use three bytes extra for the
> peer-id. This needs to be accounted for, otherwise OpenVPN will throw
>
>   TCP/UDP packet too large on write to [AF_INET]10.1.1.1:1194
>
> warnings.
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  src/openvpn/ssl.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 0bca28d..80293ef 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -264,16 +264,14 @@ tls_get_cipher_name_pair (const char * cipher_name, size_t len) {
>    return NULL;
>  }
>
> -/*
> - * Max number of bytes we will add
> - * for data structures common to both
> - * data and control channel packets.
> - * (opcode only).
> +/**
> + * Max number of bytes we will add for data structures common to both data and
> + * control channel packets (1 byte opcode + 3 bytes peer-id).
>   */
>  void
>  tls_adjust_frame_parameters(struct frame *frame)
>  {
> -  frame_add_to_extra_frame (frame, 1); /* space for opcode */
> +  frame_add_to_extra_frame (frame, 1 + 3); /* space for opcode + peer-id */
>  }
>
>  /*
> --
> 1.9.1
>
>
> ------------------------------------------------------------------------------
> New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
> GigeNET is offering a free month of service with a new server in Ashburn.
> Choose from 2 high performing configs, both with 100TB of bandwidth.
> Higher redundancy.Lower latency.Increased capacity.Completely compliant.
> http://p.sf.net/sfu/gigenet
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



-- 
-Lev

