From: Heiko Hund <heiko@...2662...>
Date: Thu, 21 Apr 2022 14:41:18 +0200
Message-ID: <2899105.Ihd2bCoRom@...2664...>
In-Reply-To: <YmESwwvWq/IwpMg+@greenie.muc.de>
References: <20220420233148.2384208-1-heiko@...2662...>
 <866053733.106111.1650528089348@...2642...>
 <YmESwwvWq/IwpMg+@greenie.muc.de>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Add git pre-commit hook script to
 uncrustify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi

On Donnerstag, 21. April 2022 10:16:03 CEST Gert Doering wrote:
> On Thu, Apr 21, 2022 at 10:01:29AM +0200, Frank Lichtenheld wrote:
> > Definitive NACK due to licensing concern mentioned below.
> 
> Streams crossed here, but I saw your NAK before pushing.
> So, yes, all valid concerns and I withdraw my ACK.

Will post a v2 with the license inline .

> > > +# create a filename to store our generated patch
> > > +prefix="ovpn-fmt"
> > > +suffix="$(date +%C%y%m%d%H%M%S)"
> > > +patch="/tmp/$prefix-$suffix.patch"
> > 
> > Are insecure tmp files still a concern? Because this is definitely an
> > insecure tmp file...
> Especially this one is something I only noticed after I sent my mail -
> so this definitely needs to to mktemp-style temp files, or a private
> tmp directory (in the local repo?)

I don't really see the need for secure tmp files here, as there's no chance to 
exploit anything by racing for the file(name). Or am I just not creative 
enough?

Cheers,
Heiko



