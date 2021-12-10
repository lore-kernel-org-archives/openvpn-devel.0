Date: Fri, 10 Dec 2021 17:10:25 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <349475353.849108.1639152625293@...2642...>
In-Reply-To: <20211207170211.3275837-6-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
 <20211207170211.3275837-6-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 05/21] Document frame related function
 and variables a bit more
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

Acked-by: Frank Lichtenheld <frank@...2641...>

> Arne Schwabe <arne@...1227...> hat am 07.12.2021 18:01 geschrieben:
> @@ -246,6 +262,8 @@ static inline int
>  frame_headroom(const struct frame *f)
>  {
>      const int offset = FRAME_HEADROOM_BASE(f);
> +    /* These two lines just pad offset to next multiple of PAYLOAD_ALIGN in
> +     * a complicated and confusing way */
>      const int delta = ((PAYLOAD_ALIGN << 24) - offset) & (PAYLOAD_ALIGN - 1);

The 24 is completely arbitrary, right? As long as the result is always bigger than
offset, you can use any other number.
I wonder whether it might be possible to replace it with something slightly less
confusing (IMHO, anyway), like 

delta = (PAYLOAD_ALIGN - (offset % PAYLOAD_ALIGN)) & (PAYLOAD_ALIGN - 1);

But my C-foo is not strong enough to judge potential corner cases.

Regards,
  Frank

--
Frank Lichtenheld

