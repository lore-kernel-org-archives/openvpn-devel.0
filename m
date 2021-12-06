Date: Mon, 6 Dec 2021 13:30:43 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1262628405.421906.1638793843153@...2642...>
In-Reply-To: <20211206010007.3072528-1-arne@...1227...>
References: <20211202125455.2593763-1-arne@...1227...>
 <20211206010007.3072528-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] Make --nobind default for --pull
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

Acked-By: Frank Lichtenheld <frank@...2641...>

> Arne Schwabe <arne@...1227...> hat am 06.12.2021 02:00 geschrieben:
> 
> Patch v2: add more commments

I feel they help a lot :)

> +    /* If binding is not forced by an explicit options and we have (at least)

typo: "options" should be "option". Or "an" is wrong.

> +     * one of --tcp-client, --pull (or --client), or socks we do not bind
> +     * locally to have "normal" IP client behaviour of a random source port */
> +    if (!need_bind && (ce->proto == PROTO_TCP_CLIENT || uses_socks || o->pull))
>      {
>          ce->bind_local = false;
>      }

Regards,
  Frank

--
Frank Lichtenheld

