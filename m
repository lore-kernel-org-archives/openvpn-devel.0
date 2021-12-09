Date: Thu, 9 Dec 2021 11:47:03 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <392549583.725462.1639046823523@...2642...>
In-Reply-To: <20211207170211.3275837-7-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
 <20211207170211.3275837-7-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 06/21] Remove post_open_mtu code
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



> Arne Schwabe <arne@...1227...> hat am 07.12.2021 18:01 geschrieben:
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 8cbb129d2..303e3fe8f 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1897,7 +1897,7 @@ tls_session_update_crypto_params_do_work(struct tls_session *session,
>      frame_print(frame, D_MTU_INFO, "Data Channel MTU parms");
>  
>      /*
> -     * mssfix uses data channel framing, which at this point contains
> +     * mssfix uses data channel framing, which at this poipnt contains

Spurious change

Regards,
  Frank
--
Frank Lichtenheld

