MIME-Version: 1.0
References: <20210525173838.3969-1-selva.nair@...277...>
 <202105270711.14R7BOiW072533@...2054...>
 <CAKuzo_j8+Kp_89t=wxQMtNbav+FuDnzooh=Vt3FtTBUOH8WMng@...278...>
 <20210529094423.GC976@...1296...>
In-Reply-To: <20210529094423.GC976@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 30 May 2021 16:12:37 -0400
Message-ID: <CAKuzo_j6pwqyv=mx2v+-_cFP94Rqzf1i6wjHiBY24R_-WPRQLQ@...278...>
Subject: Re: [Openvpn-devel] RfD: Windows code, UNICODE and ansi
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi

On Sat, May 29, 2021 at 5:44 AM Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Thu, May 27, 2021 at 11:40:59AM -0400, Selva Nair wrote:
> > > (I do wonder if "support ansi builds" is really something we want, if
> > > that makes the code so complicated - "always UNICODE" seems to be much
> > > simpler.  What is the drawback of not supporting "ansi" builds?)
> >
> > I prefer to write all new Windows code as unicode without any dependency on
> > the defines UNICODE and  _UNICODE --- i.e no TCHARs, explicit API calls,
> > no _tprintfs.
> >
> > For old code, an easy option would be to retain the TCHARs, but assume
> > we only build with UNICODE (TCHAR=WCHAR) and going forward don't care
> > to support ANSI builds. As we did with the service.
>
> I'm not the person who writes and debugs most of the windows code, I just
> see patches pass by, and some bits are "more readable" and others less
> so :-)
>
> So my "vote" would be towards what you propose - always build unicode,
> and for older code, assume (or force-#define) UNICODE.
>
> Plus, document this somewhere.  On our styleguide page, maybe?

I have added a section named "Windows specific" to the codestyle in
the wiki. Not very polished -- please take a look and feel free to
pull it apart.

https://community.openvpn.net/openvpn/wiki/CodeStyle#Windowsspecific

Selva

