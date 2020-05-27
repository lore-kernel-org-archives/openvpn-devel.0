References: <20200519220004.25136-1-arne@...1227...>
 <20200519220004.25136-4-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <1e25ab16-e90a-7e19-c0a4-be79497363e3@...2080...>
Date: Wed, 27 May 2020 23:00:32 +0200
MIME-Version: 1.0
In-Reply-To: <20200519220004.25136-4-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 3/5] Implement sending response to
 challenge via CR_RESPONSE
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

On 20/05/2020 00:00, Arne Schwabe wrote:
> When a client announces its support to support text based
> challenge/response via IV_SSO=crtext,the client needs to also
> be able to reply to that response.
> 
> This adds the "cr-response" management function to be able to
> do this. The answer should be base64 encoded.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/management-notes.txt | 14 ++++++++++++++
>  src/openvpn/init.c       | 39 +++++++++++++++++++++++++++++++++++++++
>  src/openvpn/manage.c     | 39 ++++++++++++++++++++++++++++++++++++++-
>  src/openvpn/manage.h     |  1 +
>  4 files changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
> index e54e1082..a7ae84e3 100644
> --- a/doc/management-notes.txt
> +++ b/doc/management-notes.txt
> @@ -806,6 +806,20 @@ To accept connecting to the host and port directly, use this command:
>  
>    proxy NONE
>  
> +COMMAND -- cr-response (OpenVPN 2.5 or higher)
> +-------------------------------------------------
> +Provides support for sending responses a challenge/response
> +query via INFOMSG,CR_TEXT. The response should be base64 encoded:
> +
> +  cr-response SGFsbG8gV2VsdCE=
> +
> +The document is intended to be used after the client received a
> +CR_TEXT challenge (see send-pending-auth section). The answer is
> +the answer to the challenge and depends on the challenge itself
> +for a TOTP challenge this would the number encoded as base64 or
> +just a string for a challenge like what "day is it today?".

The quoting should probably start before "what" instead of after.  This can be
fixed during commit time if we care enough about that typo.

I've only glared at this patch, as I tested the previous version quite a bit.
 Changes requested are added to this.

Arne and I have discussed the IV_SSO naming a bit, I realize we need to keep
at least the IV_SSO as changing that would be an incompatible protocol change
with OpenVPN Access Server (already in production) and OpenVPN Cloud (recently
released).  This is something we can consider change later on, then in
cooperation with OpenVPN Access Server and OpenVPN Cloud.

Acked-By: David Sommerseth <davids@...515...>

-- 
kind regards,

David Sommerseth
OpenVPN Inc


