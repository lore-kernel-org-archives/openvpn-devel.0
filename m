Date: Thu, 9 Dec 2021 17:08:37 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <276512336.758552.1639066117011@...2642...>
In-Reply-To: <150254504.743723.1639057792357@...2642...>
References: <20211207170211.3275837-1-arne@...1227...>
 <20211207170211.3275837-14-arne@...1227...>
 <150254504.743723.1639057792357@...2642...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 13/21] Implement optional mtu parameter
 for mssfix
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

> Frank Lichtenheld <frank@...2641...> hat am 09.12.2021 14:49 geschrieben:
> > Arne Schwabe <arne@...1227...> hat am 07.12.2021 18:02 geschrieben:
> > diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
> > index b1ae4e75a..f41c0c4f1 100644
> > --- a/doc/man-sections/link-options.rst
> > +++ b/doc/man-sections/link-options.rst
> > @@ -110,19 +110,25 @@ the local and the remote host.
> >    (:code:`p2p`). OpenVPN 2.0 introduces a new mode (:code:`server`) which
> >    implements a multi-client server capability.
> >  
> > ---mssfix max
> > +--mssfix max [mtu]
> 
> If you want to denote optional paramters (which I think makes sense, but is not
> consistently done in the documentation so far), then I think it needs to be
> --mssfix [max [mtu]]

It turns out that the reason we do not use [] in the option list is that it breaks the
rst formatting. Option lists do not seem to have any support for formatting optional
arguments (see https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#option-lists).
I have verified that this visibly breaks the formatting, both for HTML and man page
output.

This seems to be the reason that many options use a generic "args" and then specify the
actual syntax in the description block instead.

Regards,
  Frank
--
Frank Lichtenheld

