Date: Tue, 26 Apr 2022 11:42:37 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1483518003.412269.1650966157885@...2642...>
In-Reply-To: <20220422142953.3805364-4-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-4-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 13/28] Change FULL_SYNC macro to
 no_pending_reliable_packets function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

> Arne Schwabe <arne@...1227...> hat am 22.04.2022 16:29 geschrieben:
> 
>  
> This changes this macro to a better named inline function. This
> introduces a slight whitespace problem but the next refactoring will
> move the incorrectly intended block to its own function anyway.

Could it be that you forgot to update the commit message when you squashed
this commit? Looking at the diff this already moves the block to its
own function?

Apart from that and a small whitespace oddity noted below the changes
look good (in the sense that they shouldn't change behavior and just
move code around).

> ---
>  src/openvpn/ssl.c | 100 ++++++++++++++++++++++++++--------------------
>  1 file changed, 57 insertions(+), 43 deletions(-)
> 
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index bad59f2a1..4ca093243 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
[...]
> @@ -2428,6 +2430,54 @@ session_move_pre_start(const struct tls_session *session,
>      return true;
>  
>  }
> +
> +/**
> + * Moves the key to state to S_ACTIVE and also advances the multi_state state
> + * machine if this is the initial connection. 

Spurious whitespace at the end of the line

Regards,
--
Frank Lichtenheld

