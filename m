Date: Tue, 28 Oct 2008 14:19:39 +0100
From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20081028131939.GA8489@...33...>
References: <48EDBFC7.9040301@...41...>
	<20081017165431.GA20687@...1139...>
	<20081024063656.GA3920@...33...>
	<20081027202236.GA8154@...1143...>
MIME-Version: 1.0
In-Reply-To: <20081027202236.GA8154@...1143...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc13 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Mon, 27 Oct 2008, Felix Kronlage wrote:

> On Fri, Oct 24, 2008 at 08:36:56AM +0200, Matthias Andree wrote:
> 
> > This particular change looks a lot like "feature missing for
> > deployment/integration/...".
> 
> but why add features in a 'release candidate'? what speaks
> against releasing small releases with stuff like this?
> 2.1.x ?

Note I'm not speaking on behalf of the OpenVPN maintainers.

The objection for me would be because it makes no difference if you
change a RC or a release. Features in point releases are usually frowned
upon as well...

> If the RC is good enough to have features added, why not get

What does "good enough" mean? Does this imply only release versions can
get features added? (I'd beg to differ there, particularly the
*releases* should not get features added unless absolutely required.)

Who gets to determine what is needed for the final release, if not the
maintainer?

> it out of the door? For us, we're still stuck with 2.0.9 regarding
> what we can ship to customers, since they will confront us with
> the question "why are you deploying not-released-software" if
> shit hits the fan...

This is indeed hard to comprehend. As though...

> It is a bullshit-argumentation, I'm aware for that, but regarding
> liability, it is a matter :/

...there were any warranties attached to the release that the RC has
not. Neither has any kind of warranty, so these are just non-arguments,
so why would it differ from a liability POV? "Due diligence?" a response
along the lines of "no better solution available" should waive possible
arguments... IANAL, but liability is a matter of contracts and possibly
laws restricting what you can effectively negotiate...

And if your customers know the *solution* better than you do rather than
their *requirements*, it's about time to rethink the relationship...

Sorry, but this is the usual whining striving to compromise product
quality in the end. Either it's "it's finished when it's finished", or
it's "release at certain point in time no matter what quality".

If you're not happy with the development process, you're free to fork.
That's what open source software is all about.

-- 
Matthias Andree

