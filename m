Date: Fri, 29 Apr 2022 14:54:11 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <438682166.690352.1651236851846@...2642...>
In-Reply-To: <2127738744.675772.1651228104970@...2642...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220427223419.241904-1-arne@...1227...>
 <20220427223419.241904-2-arne@...1227...>
 <2127738744.675772.1651228104970@...2642...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] Implement stateless,
 HMAC basedsesssion id three way handshake
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

> Frank Lichtenheld <frank@...2641...> hat am 29.04.2022 12:28 geschrieben:
> > Arne Schwabe <arne@...1227...> hat am 28.04.2022 00:34 geschrieben:
[...]
> > +
> > +        }
> > +        else
> > +        {
> > +            msg(D_MULTI_DEBUG, "Reset packet from client (%s), "
> > +                "sending HMAC based reset challenge", peer);
> 
> Huh? This is not a reset packet? Also we're not sending a reset challenge, we just completed it?
> Should this message say something different?

Note: the fix for this is already in 22/28.

Regards,
--
Frank Lichtenheld

