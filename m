MIME-Version: 1.0
In-Reply-To: <20161225105919.25792-1-gert@...1296...>
References: <20161225105919.25792-1-gert@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 25 Dec 2016 13:22:04 +0100
Message-ID: <CAA1Abx+tEMPEEr1OviS-nH1Wq6qikVyJ0BfUnNfqCEs6eOR3mA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Remove IV_RGI6=1 peer-info signalling.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 25 December 2016 at 11:59, Gert Doering <gert@...1296...> wrote:
> This is no longer needed, as anything 2.4 or later is known to have
> this functionality, and IV_VER can be used to detect this on the server.
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/ssl.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 15f62f2..cff4052 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -2270,9 +2270,6 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
>          comp_generate_peer_info_string(&session->opt->comp_options, &out);
>  #endif
>
> -        /* support for redirecting IPv6 gateway */
> -        buf_printf(&out, "IV_RGI6=1\n");
> -
>          if (session->opt->push_peer_info_detail >= 2)
>          {
>              /* push mac addr */
> --
> 2.10.2

ACK

(I even think this should go into 2.4.0, to prevent officially
releasing a version that advertises IV_RGI6.)

-Steffan

