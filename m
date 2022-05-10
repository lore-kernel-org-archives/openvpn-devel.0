Date: Tue, 10 May 2022 11:33:48 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <466809680.552694.1652175228160@...2642...>
In-Reply-To: <0efb5969-6d9c-cef7-704f-d76a909501b3@...2181...>
References: <20220402070902.30282-5-a@...2181...>
 <20220411133528.27279-1-a@...2181...>
 <2078542256.353074.1649759630031@...2642...>
 <0efb5969-6d9c-cef7-704f-d76a909501b3@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 4/7] ovpn-dco: introduce linux
 data-channel offload support
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

> Antonio Quartulli <a@...2181...> hat am 09.05.2022 20:06 geschrieben:
> On 12/04/2022 12:33, Frank Lichtenheld wrote:
> > Honestly still not sure one would start reviewing the actual code but here
> > are at least a few minor things I noticed while browsing through it:
> > 
> >> Antonio Quartulli <a@...2181...> hat am 11.04.2022 15:35 geschrieben:
[...]
> > [...]
> >> diff --git a/README.dco.md b/README.dco.md
> >> new file mode 100644
> >> index 00000000..e73e0fc2
> >> --- /dev/null
> >> +++ b/README.dco.md
> > [...}
> >> +DCO and P2P mode
> >> +----------------
> >> +DCO is also available when running OpenVPN in P2P mode without --pull/--client option.
> >> +The P2P mode is useful for scenarios when the OpenVPN tunnel should not interfere with
> >> +overall routing and behave more like a "dumb" tunnel like GRE.
> >> +
> >> +However, DCO requires DATA_V2 to be enabled. This requires P2P with NCP capability, which
> >> +is only available in OpenVPN 2.6 and later.
> > 
> > Changes.rst doesn't mention this change, should it?
> 
> how does this sound:
> 
> Note that DCO will use DATA_V2 packets in P2P mode, therefore,
> this implies that peers must be running 2.6.0+ in order to have P2P-NCP
> which brings DATA_V2 packet support.

I think you misunderstood my point? I wasn't actually criticizing your text, I was wondering
whether we should add an additional point in Changes.rst, because I see no mention of this
new feature.

8c72d7981c32c43d1c7967a312bb439e13fc5b40 did add this feature without any changes
to documentation or Changes.rst.

> > Should we mention here what "NCP" stands for?
> 
> to be honest I barely know what it stands for :-D I just know it is 
> "cipher negotiation", but the actual definition I think is expected to 
> be found elsewhere. no?

FWIW, src/openvpn/options.h:#define OPT_P_NCP             (1<<12) /**< Negotiable crypto parameters */

In general, I would think in this context using "cipher negotiation" as you
already mentioned would be better than using an opaque acronym. Or at least use
both so that users who are not intimately familiar with our nomenclature still
know what you're talking about.

Regards,
--
Frank Lichtenheld

