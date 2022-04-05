Date: Tue, 5 Apr 2022 12:00:49 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <922985778.595013.1649152849318@...2642...>
In-Reply-To: <20220402070902.30282-6-a@...2181...>
References: <20220402070902.30282-1-a@...2181...>
 <20220402070902.30282-6-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 5/7] tun: extract close_tun_handle into
 its own fucntion and print correct type
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Acked-by: Frank Lichtenheld <frank@...2641...>

Seems trivial.

> Antonio Quartulli <a@...2181...> hat am 02.04.2022 09:09 geschrieben:
[...]
> +    if (tt->hand != NULL)
> +    {
> +        dmsg(D_WIN32_IO_LOW, "Attempting CloseHandle on %s adapter", adaptertype);
> +        if (!CloseHandle(tt->hand))
> +        {
> +            msg(M_WARN | M_ERRNO, "Warning: CloseHandle failed on %s adapter", adaptertype);
> +        }
> +        tt->hand = NULL;

Setting hand to NULL is a slight behavior change, it wasn't there before.
It might be nice to acknowledge it in the commit message just to confirm that
it was a deliberate change.

Regards,
--
Frank Lichtenheld

