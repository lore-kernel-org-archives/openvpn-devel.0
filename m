Message-ID: <4D2D8440.2040303@...68...>
Date: Wed, 12 Jan 2011 11:36:48 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <4D2C3D0A.2060607@...1114...> <4D2D68E0.9080702@...68...>
	<4D2D7FDA.50900@...1114...>
In-Reply-To: <4D2D7FDA.50900@...1114...>
Subject: Re: [Openvpn-devel] OpenVPN documentation (man page) review
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net, OpenVPN List <openvpn-users@lists.sourceforge.net>

Am 12.01.2011 11:18, schrieb David Sommerseth:

> But if we could manage to produce, say chm files (or whatever is the
> standard nowadays) for windows, that would be a big improvement as well.
>  Otherwise, a HTML file (like now, I believe) is better than nothing.

I don't personally care much for the Windows Help fad of the day.

You can use doclifter or manserver or an up-to-date groff to convert the roff
man format to HTML, and htmldoc to further convert this to PDF.  No need to
change anything.

> In the -users mailing list and on the #openvpn IRC channel, it is
> obviously that many struggle to find/understand the available
> documentation.  OpenVPN is very extensive and flexible, but with that
> comes complexity, especially when describing it all at once (like the
> man page does).  So this is an area where we should improve.

Well, roff-based manual pages support sectioning through .SH and .SS for what
you'd call H1 and H2 in HTML.

It's a shortcoming in man(1) if that's not supported properly; and it's a
shortcoming of the documentation as a whole (not necessarily the manual page) if
there's nothing that takes a new user by the hand to show him how to get started.

Adding more documentation, or duplicating information, however, makes it more
difficult to maintain -- and see below for a fully-fledged overview.  You'll
probably want to assemble a full manpage with all the options rather sooner than
later if you split.

Plus, the manual page is mostly a reference, and should be kept as such.  I have
no objections to adding howto or intro or overview manpages, or mode-specific
takeouts, if they are generated automatically (probably a few lines of awk or
perl suffice if you agree on comment mark-up in the manpage).  Don't duplicate
information!

> I believe one of the issues is that a lot of this comprehensive
> information is compressed into to few separate files, which can make it
> daunting and intimidating really reading the documentation.  Further,

The issue isn't reading the manual page (virtually nobody reads it all through
from a to z), but finding the right pieces for the desired application at hand.

> the usage of specific terms might make it more difficult to understand
> the document they are reading.  Parts of the documentation do take it
> for granted that the reader knows a lot to start with, which often is
> not the reality.

Target group check please.  The reference must not paraphrase or describe but
needs to be concise, precise, and use the proper terms, to avoid ambiguities.
Explanations of the specific technical terms belong into a glossary and possibly
an introductory document.

> Second, maintaining the current man document is a hassle and can be
> intimidating for people not having written man pages before.  In
> addition, the size of the current man page makes it even more difficult
> to make sure it is up-to-date.  Which is also a reason I would like to
> split it up into more pieces and a different format than a raw man page
> file.

As though that would make things more concise for the editor and thus
maintenance easier.  If you think it does, let me know how I should structure my
workflow for that to become true.

> I've taken some of the ideas for categorisation splits from the git man
> pages.  It is quite easy to know where to look when you don't know where
> to look, and where to look when you know what you are looking for.
> That's kind of my main idea.  Further, take out the more advanced things
> (like plug-ins) and put the gory details in a separate place, which must
> be referenced in the server/client man pages.  This way users will not
> be distracted too much with options which are not necessarily related to
> what they need or are looking for.

And I've seen users complain that Postfix (the Mail Transfer Agent,
<http://www.postfix.org/>) didn't have one single manual page to collect *all*
options; now there is one. :-)

> The reason for splitting client and server options is also to avoid
> confusion about which options can be used in which mode.  It grouped
> correctly in the man page today, but when you scroll up and down in the
> man page it is easy to loose overview of which "mode" you are reading about.

An issue of the man(1) tool that doesn't show a breadcrumb trail or a sidebar
with bookmarks like many PDF viewers can do, and easily rectified by converting
the roff manpage into a proper PDF document.

> If the "entry" man page also would cover a little bit generic VPN and
> networking with VPN basics, referencing other man pages to tools like
> ip, ifconfig, route, brctl, etc, it might help new users to understand a
> little bit more as well.

And needs to be system-specific in that very instant because the tools are.

> Another thing, just as a side note, easy-rsa could really use a man page
> as well.

True enough, but better placed in a separate thread on the lists, and I suppose
you'll collect volunteers much more easily for this much smaller project :)

-- 
Matthias Andree

