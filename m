MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <20170622160805.GD31123@...2287...>
References: <62da7142-d087-7d89-5974-7533b1be0713@...1856...>
	<20170621211043.6490-1-steffan@...1856...>
	<20170622133102.GC31123@...2287...>
	<CAKh=nwF7UfzoDaUWM1RNfx8tULmMVyP_wn69ZGORztx6qMYWWQ@...278...>
	<20170622160805.GD31123@...2287...>
From: Emmanuel Deloget <logout@...260...>
Date: Thu, 22 Jun 2017 19:32:16 +0200
Message-ID: <CAKh=nwEnZrmC0UzsJLm79HedR9__MsBGcH+4oJQPXXxu+PTavA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Move adjust_power_of_2() to integer.h
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
To: Antonio Quartulli <a@...2181...>
Cc: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

On Thu, Jun 22, 2017 at 6:08 PM, Antonio Quartulli <a@...2181...> wrote:
>
> On Thu, Jun 22, 2017 at 05:33:44PM +0200, Emmanuel Deloget wrote:
> > Hi Antonio, Steffan,
> >
> > On Thu, Jun 22, 2017 at 3:31 PM, Antonio Quartulli <a@...2181...> wrote:
> >
> > > Thanks for sending v2 Steffan,
> > >
> > > On Wed, Jun 21, 2017 at 11:10:43PM +0200, Steffan Karger wrote:
> > > > From: Steffan Karger <steffan.karger@...1435...>
> > > >
> > > > misc.c is a mess of incoherent functions, and is therefore included by
> > > > virtually all our source files.  That makes testing harder than it should
> > > > be.  As a first step of cleaning up misc.c, move adjust_power_of_2() to
> > > > integer.h, which is a more suitable place for a function like this.
> > > >
> > > > This allows us to remove the duplicate implementation from test_argv.c.
> > > >
> > > > Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> > >
> > >
> > > This change is quite simple and passes basic tests.
> > > Thanks also for adding explicit #include statements.
> > >
> > > Acked-by: Antonio Quartulli <antonio@...515...>
> > >
> > >
> > Since the code is moved, would it be interesting to use a less greedy
> > algorithm to do the same thing? I know the function is not used very often,
> > so it does not look like it's necessary (it's a suggestion, not a
> > commentary on your patch Steffan :))
>
> My personal opinion: *never* mix code refactoring with functional changes (like
> what you are suggesting).
>
> Therefore we'd still need another patch.

Fair enough :)

> >
> > <snip>
> >
> > Again, the function is not used extensively, so you can ignore this
> > suggestion as it will not speed up openvpn at all :)
>
> yeah...not sure we need to make some code a bit "obscure" if there is really no
> need.
>
> Still, I'd suggest to prepare a second patch and propose it over the list.
>

I'll wait until I see Steffan's patch on master . But as you said,
/coda obscura est/ so the commit message will make that very clear.

>
> Cheers,
> --
> Antonio Quartulli

BR,

-- Emmanuel Deloget

