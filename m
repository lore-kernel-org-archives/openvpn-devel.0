Date: Mon, 21 Feb 2022 22:02:06 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1268050470.99712.1645477326639@...2642...>
In-Reply-To: <d87c452e-adf2-2635-f7cb-ae0844e3e483@...1227...>
References: <20220221111933.1314-1-frank@...2641...>
 <d87c452e-adf2-2635-f7cb-ae0844e3e483@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] doc: cleanup for --data-ciphers and
 related
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



> Arne Schwabe <arne@...1227...> hat am 21.02.2022 21:23 geschrieben:
> Am 21.02.22 um 12:19 schrieb Frank Lichtenheld:
> > @@ -191,7 +191,8 @@ configured in a compatible way between both the local and remote side.
> >   
> >     For servers, the first cipher from ``cipher-list`` that is also
> >     supported by the client will be pushed to clients that support cipher
> > -  negotiation.
> > +  negotiation. (That feature is also called ``Negotiable crypto parameters``
> > +  or ``NCP`` for short).
> 
> That was actually a decision to leave out NCP out of this document. NCP 
> is an internal thing and the documentation does not need to introduce it 
> and can just talk about cipher negotitation in a non-specific way.

Yeah, the problem is that the document mentions NCP a lot, so we at least need
to explain what it is. I considered removing it completely, but decided to keep
some of the mentions since they make the sentences much shorter than if I would
add "cipher negotiation" every time. But if you prefer I can certainly do that.

Regards,
--
Frank Lichtenheld

