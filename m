MIME-Version: 1.0
References: <20220420233148.2384208-1-heiko@...2662...>
 <866053733.106111.1650528089348@...2642...>
 <YmESwwvWq/IwpMg+@greenie.muc.de>
In-Reply-To: <YmESwwvWq/IwpMg+@greenie.muc.de>
From: David Schneider <schneidav81@...277...>
Date: Thu, 21 Apr 2022 13:41:58 +0200
Message-ID: <CAF465zq8R9fEXL+1PAO2-x48D6PPJt05WSe5KYSRukfT8NVtUg@...278...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi all,

Did you consider to use the pre-commit framework [1] written in
Python? There is a maintained hook for uncrustify [2].
This would allow it to easily integrate other linters/checks. See the
list of supported hooks [3].

I would understand if you don't like to add yet another dependency,
but in the case of Python, it's already part of the development
environment.

[1] https://pre-commit.com/
[2] https://github.com/pocc/pre-commit-hooks
[3] https://pre-commit.com/hooks.html

David

On Thu, 21 Apr 2022 at 10:17, Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Thu, Apr 21, 2022 at 10:01:29AM +0200, Frank Lichtenheld wrote:
> > Definitive NACK due to licensing concern mentioned below.
>
> Streams crossed here, but I saw your NAK before pushing.
>
> So, yes, all valid concerns and I withdraw my ACK.
>
> > [...]
> > > +# create a filename to store our generated patch
> > > +prefix="ovpn-fmt"
> > > +suffix="$(date +%C%y%m%d%H%M%S)"
> > > +patch="/tmp/$prefix-$suffix.patch"
> >
> > Are insecure tmp files still a concern? Because this is definitely an insecure tmp file...
>
> Especially this one is something I only noticed after I sent my mail -
> so this definitely needs to to mktemp-style temp files, or a private
> tmp directory (in the local repo?)
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh Mistress
>
> Gert Doering - Munich, Germany                             gert@...1296...
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

