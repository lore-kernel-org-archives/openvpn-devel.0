References: <20190613144113.6418-1-arne@...1227...>
 <20190613144113.6418-2-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <31cf4ffb-adab-ec1d-b8e6-87bbb73c3b01@...2080...>
Date: Tue, 22 Oct 2019 22:36:57 +0200
MIME-Version: 1.0
In-Reply-To: <20190613144113.6418-2-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 1/5] Implement parsing and sending INFO
 and INFO_PRE control messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 13/06/2019 16:41, Arne Schwabe wrote:
> OpenVPN out of band and auth pending authentication implements these
> messages to send information during the authentication to the UI,
> implement these message also in OpenVPN 2.x to be able to be piked up
> by the UI
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/forward.c |  8 ++++++++
>  src/openvpn/push.c    | 33 +++++++++++++++++++++++++++++++++
>  src/openvpn/push.h    |  3 +++
>  3 files changed, 44 insertions(+)
> 
[...snip...]
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 8befc6f5..8632a9bb 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -176,6 +176,39 @@ server_pushed_signal(struct context *c, const struct buffer *buffer, const bool
>      }
>  }
>  
> +void
> +server_pushed_info(struct context *c, const struct buffer *buffer,
> +                   const int adv)
> +{
> +    const char *m = "";
> +    struct buffer buf = *buffer;
> +
> +    if (buf_advance(&buf, adv) && buf_read_u8(&buf) == ',' && BLEN(&buf))
> +    {
> +        m = BSTR(&buf);
> +    }
> +
> +    #ifdef ENABLE_MANAGEMENT

This looks good, but the indenting of the #ifdef above is wrong; it should be
at the beginning of the line.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


