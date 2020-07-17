References: <20200717170948.227787-1-matthias.andree@...68...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <813dc84e-1330-5626-fdcf-31e90025aaca@...68...>
Date: Fri, 17 Jul 2020 19:22:18 +0200
MIME-Version: 1.0
In-Reply-To: <20200717170948.227787-1-matthias.andree@...68...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Fix stack buffer overruns in NEXTADDR()
 macro:
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 17.07.20 um 19:09 schrieb Matthias Andree:
> @@ -3727,6 +3727,7 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
>          msg(M_WARN, "GDG6: socket #1 failed");
>          goto done;
>      }
> +    errno = 0;
>      if (write(sockfd, (char *)&m_rtmsg, l) < 0)
>      {
>          msg(M_WARN, "GDG6: problem writing to routing socket");

This line escaped, so NAK on the first version of the patch.

New patch was sent.


