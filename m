Message-ID: <53627F26.1060208@...515...>
Date: Thu, 01 May 2014 20:06:46 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <536262FD.1090105@...1901...>
In-Reply-To: <536262FD.1090105@...1901...>
Subject: Re: [Openvpn-devel] IRC & Community...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Timothe Litt <litt@...1901...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Timothe,

> http://community.openvpn.net/openvpn/wiki/IrcMeetings says:
> "=E2=80=8BComplete logs <http://secure-computing.net/logs/%23openvpn-deve=
l.log>
> (updated every 3 hours) of the openvpn-devel channel are also available".
>
> The last entry at that URL is Tue Dec 03 2013. Looks like the logger is
> broken, as I'm told that
> the IRC channel is "very active."
You should poke ecrist or krzee regarding the IRC logger (#openvpn or
#openvpn-devel).

>
> The meeting logs of the 'usually weekly meetings' seem to be every 3-6
> months, not weeks.
> So either the meetings don't happen, or the logs aren't posted.
The IRC meetings are nowadays held quite rarely. We  used to have
frequent meetings earlier because the community developers needed more
input from OpenVPN's "father", James Yonan, and the meetings seemed to
be best venue for that. As the community developers have gained more
experience there has been less need for James, and thus less need for
formal IRC meetings. Basically what happened around the time of OpenVPN
2.1.3 release and ending around 2.3.0 release is that the project moved
from being a one-man (James) project into a community project, with
James remaining a significant contributor.

Every single meeting is announced in advance and a summary sent to the
mailing list. That said, the IRC meeting page should be fixed because
the meeting are definitely not weekly anymore.

>
> I have one item for discussion*:
> http://community.openvpn.net/openvpn/wiki/DeveloperDocumentation
> *suggests that community patches are welcome. I'm not getting that
> impression.
Community patches are indeed welcome, but the core developers do much of
the patch review at their free time. If your patch does not get a quick
review, you should either poke somebody on the IRC (#openvpn-devel) or
reply to your own patch mail with "could someone review this" or
similar. This is suboptimal, but that's what we now have, and which
definitely should be fixed if possible.

Much of the patch discussion happens on IRC simply because that's
easiest. That is somewhat problematic in that IRC is synchronous and
people in some timezones can't easily participate.
>
>
> This isn't the first open source project I've been involved with; I do
> understand the dynamics.
> Here is the basis for my concern:
>
> There appear to be quite a few patches listed on
> http://community.openvpn.net/openvpn/wiki/Patches
> that have been "under review" for months to over a year. So I guess I
> shouldn't be surprised that the
> one I sent to this list 3 days ago (to close a 2-year old ticket) got no
> response (and isn't on the
> 'under review' list). The response to the ticket said 'patch welcome'.
> (I provided V1 via Trac two
> weeks ago, and an enhanced version via this list 3 days ago. It wasn't
> clear which mechanism to
> use.)
>
> Yet work from the core developers seems to get ACK'd and applied in a
> day or two.
> Or at least, promptly discussed.
I believe the fact that core devs get their patches ACKed more easily
than "non-core" devs is primarily because much of the patch discussion
happens in the IRC where they are hang around, and using which rapid
patch iteration is much easier.
>
> I also looked at a couple of 'Rejected' patches, and to my surprise saw
> that the end of their
> e-mail chain was that they had been merged.
I would not read into the patchlist too literally. It's basically a tool
used by the core devs to get _some_ idea of what patches have been
merged, what are in the queue and what were rejected. Arne ("plaisthos"
on IRC) has a script to keep that updated, and I believe his script is
attached to that page.

The rejected patches have almost certainly been modified (v2, v3, etc.)
before being merged. Rejected means rejected.

>
>
> So it's quite difficult for an outsider to determine whether it's worth
> contributing; a black hole
> is not welcoming...neither is inability to look at the IRC log.
> Especially for those of us in other
> time zones.
You should talk to ecrist and/or krzee about everything IRC. I know next
to nothing about the IRC logging thing they have. It could be that the
link has changed, or that the logger is really offline.

Typically people just hang around (idle) in the IRC and thus have no
real need for web-based IRC logs.
>
> A couple of suggestions:
>
> 1) There should be a commitment to ack (not necessarily ACK) community
> patches within a
> reasonable timeframe, where "ack" means:
> a) someone says "saw it, thanks" and either:
> i) ACKs (feature or final)
> ii) NAKs
> iii) indicates what action is required and who needs to do it for
> progress to occur
> e.g. "I will test later this week" or "you need to address these
issues", or
> "a review period has started that will end on (date)" (See (c,d))
> iv) asks someone else to screen for disposition
> b) it gets listed on the wiki as 'under review'
> c) under normal circumstances (not in crisis mode, patch not massive) a
> NAK, ACK, or discussion
> will happen within a fixed time period. I've worked on several busy
> projects where a 14-day
> rule exists: no objection in 14 days automatically accepts a proposal.
> Any objection or concern
> stops the clock and discussion continues until consensus is reached.
> d) under abnormal circumstances, an extension of time for review is
> defined and posted.
> e) there will be a definite response (along the lines of (1a i-iii)) at
> the end of the review period.
>
> 2) The wiki patch status page should have a couple of additional fields:
> a) Dates: original submission & last update
> b) Status (waiting for team update, waiting for submitter update/response,
> needs testing on platform x, review open until (date), etc..)
> It's one thing if the submitter drops a submission; it's something else
> if it's
> not being reviewed by the project.
>
> 3) The date column on the status page seems to be semi-random order;
> sometimes
> newest first, sometimes oldest first.
>
> 4) The status page needs to be kept up-to-date.
>
> 5) You need to clarify whether you want community patches submitted on
> Trac tickets, or
> to the mailing list. More documents point at the list than Trac, but
> it's not clear what a
> non-core developer should do.
>
> The volume of submissions doesn't seem to be so large as to make
> adopting these suggestions
> impractical - assuming that community submissions are actually wanted.
> As a newcomer, my
> impression is that "the words say 'yes', but the actions say 'no'". I
> don't think that's a good thing...
>
> I know that everyone is busy and most have 'real' jobs. And it's natural
> to respond quickly to people
> you know. But the current culture of 'it's OK to leave submissions in
> limbo for months' won't get
> the project much help from "the community".

These are all good policies and ideas and you're more than welcome to
help us implementing them.

Lack of developer time is the biggest issue for us, and that lack of
time results in unnecessary work having to be done later; like having
and maintaining a patch tracking page instead of just handling the
patches immediately as they are sent to the list.

In addition to patches the bug reports are an issue because too little
time can be allocated to weeding out the clearly invalid reports so that
devs could concentrate on fixing the real bugs. This is something which
non-developers could also help, provided they have enough knowledge of
OpenVPN. What we have not been able to do is "sell" the idea of patch
review as a useful form of contribution to our non-developer userbase.

A few notes about where we get our patches from... in the documentation
we do say that "post the patch to openvpn-devel list". That was a
decision that was reached some years ago. However, we, in practice, do
accept patches from Trac, GitHub and IRC. We should probably change the
documentation to reflect this.

Best regards,

- --=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock
=20
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNifyYACgkQwp2X7RmNIqM5FACgu5yBrkCgqQ6+KvBEFwVKcLji
XGcAoMTG3g/3vC7feC8sb4A+LkzMw9K+
=3DFyyv
-----END PGP SIGNATURE-----


