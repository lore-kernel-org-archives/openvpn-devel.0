Date: Fri, 24 Jun 2022 10:38:50 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YrV4GkLwPbEiV0XU@...2678...>
References: <20220621161649.2872985-1-arne@...1227...>
 <20220621161649.2872985-5-arne@...1227...>
 <YrV3TEqU1KF0Q+AB@...2678...>
MIME-Version: 1.0
In-Reply-To: <YrV3TEqU1KF0Q+AB@...2678...>
Subject: Re: [Openvpn-devel] [PATCH 5/6] Change default MTU in server mode
 to 1420 and push it to client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Jun 24, 2022 at 10:35:24AM +0200, Frank Lichtenheld wrote:
> Code changes look fine to me, but several documentation suggestions.

Hmm, after reading the next patch might I suggest to move the
change to push.c actually to the next patch? Both references
to IV_MTU and tun-max-mtu only make sense then, right?
 
> On Tue, Jun 21, 2022 at 06:16:48PM +0200, Arne Schwabe wrote:
> > diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> > index 63257348a..463957a82 100644
> > --- a/src/openvpn/push.c
> > +++ b/src/openvpn/push.c
> > @@ -603,6 +603,22 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
> >      {
> >          push_option_fmt(gc, push_list, M_USAGE, "key-derivation tls-ekm");
> >      }
> > +
> > +    /* Push our mtu to the peer if it supports pushable MTUs */
> > +    int client_max_mtu = 0;
> > +    const char *iv_mtu = extract_var_peer_info(tls_multi->peer_info, "IV_MTU=", gc);
> > +
> > +    if (iv_mtu &&  sscanf(iv_mtu, "%d", &client_max_mtu) == 1)
> 
> random space before sscanf
> 
> > +    {
> > +        push_option_fmt(gc, push_list, M_USAGE, "tun-mtu %d", o->ce.tun_mtu);
> > +        if (client_max_mtu < o->ce.tun_mtu)
> > +        {
> > +            msg(M_WARN, "Warning reported maximum MTU from client (%d) is lower "
> 
> Missing colon after "Warning".
> 
> > +                "than MTU used on the server (%d). Add tun-max-mtu %d "
> > +                "to client configuration.", client_max_mtu,
> > +                o->ce.tun_mtu, o->ce.tun_mtu);
> > +        }
> > +    }
> >      return true;
> >  }
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

