MIME-Version: 1.0
References: <20200205124615.15758-1-domagoj@...2540...>
 <20200205124615.15758-2-domagoj@...2540...>
 <CAGyAFMU_L4d2KuzefFRLRiZ=j6_qJKPtmE9hk_p1Qf2Xqk9i+g@...278...>
In-Reply-To: <CAGyAFMU_L4d2KuzefFRLRiZ=j6_qJKPtmE9hk_p1Qf2Xqk9i+g@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 5 Feb 2020 10:47:20 -0500
Message-ID: <CAKuzo_i2MDomrwoF4TxsdrtjCVVsOi7xu0YB_no3=Nf8YOUCLA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Skip DNS address validation
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
To: Lev Stipakov <lstipakov@...277...>
Cc: Domagoj Pensa <domagoj@...2540...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Feb 5, 2020 at 10:28 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> Hi,
>
> Built and tested with msvc, works as expected - "validate=no" is added to netsh command line.
>
> There is a similar commit in Simon's repo (not yet sent to ml) : https://github.com/rozmansi/openvpn/commit/6b746cb0bf72a75e9963cc1a037c18cfb856702a
>
> I haven't noticed any slowness on my machine, but since fix has been implemented separately
> by two persons and there is similar code for ipv6, I am ok with that.

>
> Acked-by: Lev Stipakov <lstipakov@...277...>

We explicitly added validate=no for IPv6 in
commit 786e06ade9f5dfad8ac360499187fa8e536d15cb
for the same reason as in this patch. The ipv4 DNS code belongs to an
era when this
option was not available.

ACK from me too.


Selva

>
> Acked-by: Lev Stipakov <lstipakov@...277...>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

