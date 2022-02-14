Date: Mon, 14 Feb 2022 13:41:04 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1861531709.22186.1644842464872@...2642...>
In-Reply-To: <0a5d28d1-af6e-5720-554b-7a08f89ea251@...2080...>
References: <20211209171138.8589-1-frank@...2641...>
 <20211209171138.8589-3-frank@...2641...>
 <c240bc99-0fb6-0400-5280-2f1c13955025@...2080...>
 <1155495853.307825.1644488506153@...2642...>
 <0a5d28d1-af6e-5720-554b-7a08f89ea251@...2080...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 3/3 v2] doc/options: clean up
 documentation for --proto and related options
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
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net

> David Sommerseth <openvpn@...2080...> hat am 11.02.2022 21:39 geschrieben:
> 
>  
> On 10/02/2022 11:21, Frank Lichtenheld wrote:
> > The family specific options were generally omitted.
> > 
> > Signed-off-by: Frank Lichtenheld <frank@...2641...>
> > ---
> >   doc/man-sections/client-options.rst |  5 +++++
> >   doc/man-sections/link-options.rst   |  5 ++++-
> >   src/openvpn/options.c               | 17 +++++++++--------
> >   3 files changed, 18 insertions(+), 9 deletions(-)
> > 
> > v2: move #define around
> > 
> > diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
> > index 73f1ea51..4c4a8707 100644
> > --- a/doc/man-sections/client-options.rst
> > +++ b/doc/man-sections/client-options.rst
> > @@ -198,6 +198,11 @@ configuration.
> >     When iterating through connection profiles, only consider profiles using
> >     protocol ``p`` (:code:`tcp` \| :code:`udp`).
> > 
> > +  Note that this specifically only affects the protocol, not the inet
> > +  family (i.e. IPv4 vs. IPv6). While the option actually accepts
> > +  values like :code:`udp6`, there is no difference to specifying
> > +  :code:`udp`.
> > +
> 
[...]
> Perhaps something like the suggestion below might be somewhat clearer?
> 
>     Note that this specifically only affects the TCP/IP transport layer
>     protocol (UDP/TCP), not the TCP/IP network layers (IPv4/IPv6).  In
>     practice it means it will only consider connection profiles using
>     either TCP or UDP.  This does not affect whether IPv4 or IPv6 is used
>     as IP protocols. In this context, :code:`udp`, :code:`udp4` and
>     :code:`udp6` are all considered the same. And similar with
>     :code:`tcp`, :code:`tcp4` and :code:`tcp6`
> 

Thanks, I hate it ;)

Seriously though, I find this too clunky. Yes, TCP/IP is
technically the correct name, but isn't that even more confusing?

Maybe we can find a compromise:

     Note that this specifically only filters by the transport layer
     protocol, i.e. UDP or TCP.  This does not affect whether IPv4 or
     IPv6 is used as IP protocol.

     For implementation reasons the option accepts the :code:`4` and :code:`6`
     suffixes when specifying the protocol
     (i.e. :code:`udp4` / :code:`udp6` / :code:`tcp4` / :code:`tcp6`).
     However, these behave the same as without the suffix and should be avoided
     to prevent confusion.

Regards,
--
Frank Lichtenheld

