MIME-Version: 1.0
References: <CAKuzo_gy_xHzy8Tscb8xJ7QKN5+OZZksG7o_0eYkao8FDDJ5WA@...278...>
 <20220117094917.178-1-lstipakov@...277...>
 <16f083eb-67cc-8238-34ff-a22fc704afd2@...2181...>
In-Reply-To: <16f083eb-67cc-8238-34ff-a22fc704afd2@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 17 Jan 2022 11:56:51 +0200
Message-ID: <CAGyAFMVTetuKrY5aw+0FPu-C_rmpU9AUUPbHCCb=GMLbdJ5HLQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] tun: remove tun_finalize()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

This is probably something committer (looks at cron2) could fix on the
fly, unless there are more issues which would require v4?

ma 17. tammik. 2022 klo 11.53 Antonio Quartulli (a@...2181...) kirjoitti:
>
> Hi,
>
> On 17/01/2022 10:49, Lev Stipakov wrote:
> [cut]
> > -
> > -static inline int
> > -read_tun_buffered(struct tuntap *tt, struct buffer *buf)
> > -{
> > -    return tun_finalize(tt->hand, &tt->reads, buf);
> > -}
> > +int
> > +tun_write_win32(struct tuntap *tt, struct buffer *buf);
>
> for prototypes we put the return type on the same line as the function
> name (unless we have line length issues, but not in this case).
>
> Cheers,
>
>
> --
> Antonio Quartulli



-- 
-Lev

