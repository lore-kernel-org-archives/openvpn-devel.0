MIME-Version: 1.0
References: <20230322113249.2039-1-lstipakov@...277...>
 <CAKuzo_iT15pQgAOVmr-00Jn4c7Yb_H-j28_S=GZ4_xKaFwLvaw@...278...>
In-Reply-To: <CAKuzo_iT15pQgAOVmr-00Jn4c7Yb_H-j28_S=GZ4_xKaFwLvaw@...278...>
From: Lev Stipakov <lev@...515...>
Date: Wed, 22 Mar 2023 15:13:22 +0200
Message-ID: <CAEUTVqR-S8fZkCh6JRrO5ZzeYAq+GiP4qFx5d7vhPDpXfjnUeg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Print DCO client stats on SIGUSR2
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
To: Selva Nair <selva.nair@...277...>
Cc: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

> While this is expedient, adding dco dependence to parts of code which should be independent of such inner details look wrong style to me. Finding a way to keep struct context a const here will lead to a better logic, I think.

We have the same approach in multi_print_status(). Not saying that
"that's why this is right", but we should at least be consistent.

> Can't we have a coarse timer that keeps the stats updated? It doesn't have to be frequent as this is just for information.

I don't think that "purity" would justify the complexity of adding an
additional timer for fetching dco-specific stats.

>> +    status_printf(so, "TCP/UDP read bytes," counter_format, c->c2.link_read_bytes + c->c2.dco_read_bytes);
>> +    status_printf(so, "TCP/UDP write bytes," counter_format, c->c2.link_write_bytes + c->c2.dco_write_bytes);
>
> Same here --  have a place to read the total count from independent of dco.

But what is wrong in fetching dco stats when we need them? What is the
advantage of timer?

-Lev

