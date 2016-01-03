MIME-Version: 1.0
In-Reply-To: <1451842066-13475-1-git-send-email-arne@...1227...>
References: <CAA1AbxKJwx5fckOpDMA7=9UB6NKtCET_ajkMav65YKNy791eOw@...278...>
	<1451842066-13475-1-git-send-email-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 3 Jan 2016 19:34:42 +0100
Message-ID: <CAA1Abx+SgbnSrXORaKXkeXhbDZU4gX1J37X-KOE3x8AGGsEnVg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v6] Implement the compression V2 data
 format for stub and lz4.
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Sun, Jan 3, 2016 at 6:27 PM, Arne Schwabe <arne@...1227...> wrote:
> +  /* did compression save us anything?  Include 2 byte compression header
> +     in calculation */
> +  {
> +    if (compressed && work.len + 2 < buf->len)
> +      {
> +       ASSERT(buf_prepend(&work, 2));
> +       uint8_t *head = BPTR (&work);
> +       head[0] = COMP_ALGV2_INDICATOR_BYTE;
> +       head[1] = COMP_ALGV2_LZ4_BYTE;
> +       *buf = work;
> +      }
> +    else
> +      compv2_escape_data_ifneeded(buf);
> +  }

I almost don't dare to say it - but I meant the outer braces
surrounding this entire if () {} else {}-block, not the braces of the
else-block (which I consider good practice).  But, as just discussed
on IRC, Gert could just take that when applying :)

So, ACK for everything except the braces ;)

-Steffan

