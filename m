Date: Thu, 19 May 2022 10:06:31 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1269254504.17688.1652947591399@...2642...>
In-Reply-To: <1476138134.1141343.1652872343570@...2642...>
References: <20220518093212.2802495-1-arne@...1227...>
 <20220518093212.2802495-4-arne@...1227...>
 <1476138134.1141343.1652872343570@...2642...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 3/4] Implement AUTH_FAIL,
 TEMP message support
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

Found one mistake in my previous review:

> Frank Lichtenheld <frank@...2641...> hat am 18.05.2022 13:12 geschrieben:
> Documentation-only review.
> > Arne Schwabe <arne@...1227...> hat am 18.05.2022 11:32 geschrieben:
[...]
> > +  are comma separated keys/values. Currently defined are:
> > +
> > +  - ``backoff s`` - instructs the client to wait at least s seconds before the
> > +                    next connection attempt. If the client has already a higher
> 
> "has already" -> "already uses" ?
> 
> > +                    delay before reconnecting, the delay will not be
> > +                    shortened.
> > +  - ``advance addr`` - Instructs the client to reconnect to the (IP)
> 
> "to the" -> "to a specific"

After reading the code I see that I was mistaken. I thought that you would
specify an actually address here. But it is literaly the string "addr".
So the correct fix seems to be "to the" -> "to the next".

I wonder whether there would be some good way to make clear that "s" above
is a placeholder but "addr" is a literal string. "backoff <s>" maybe? Not sure.
 
> > +                       address of the current server.
> > +  - ``advance remote`` - Instructs the client to skip the remaining IP
> > +                         addresses of the current server and instead connect to
> > +                         the next server specified in the configuration file
> 
> Missing full stop.
> 
> > +  - ``advance no`` - Instructs the client to retry connecting to the same server
> > +                    again.
> > +
> > +  For example, the message ``TEMP[backoff 42,advance no]: No free IP addresses``
> > +  to indicates that the VPN connection can currently not succeed and instructs
> 
> Remove "to"
> 
> > +  the client to retry in 42 seconds again.
> > +
> >    When deferred authentication is in use, the script can also request
> >    pending authentication by writing to the file specified by the
> >    :code:`auth_pending_file`. The first line must be the timeout in

--
Frank Lichtenheld

