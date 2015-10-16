Message-ID: <56211876.3050801@...515...>
Date: Fri, 16 Oct 2015 18:32:06 +0300
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <562103AD.1090907@...1114...>
In-Reply-To: <562103AD.1090907@...1114...>
Subject: Re: [Openvpn-devel] The OpenVPN git repositories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net


Hi,

> The whole time we have had a fairly strict regime for accepting patches.
>   This we do not want to change much at all.  We do need to improve the
> review process, but among the developers there is a mutual agreement
> that all reviewed patches *MUST* go to the mailing list.  No exceptions.
>   But we will discuss better arenas for reviewing patches; that's
> something will be brought up at a later point.

Sorry, I could not resist to bring this up now instead of later :). We=20
will need to think about these things anyways when OpenVPN 3 is=20
published in GitHub, which should happen Real Soon(tm). Having a similar=20
review / patch management process for both 2.x and 3.x would make sense=20
in my opinion.

Imho using the mailing list for patch review breaks down when we can't=20
review patches immediately/very soon after they arrive. More often than=20
not patches are _not_ reviewed immediately and then get forgotten about=20
or otherwise linger on the mailing list for a long time. As there is=20
currently no real-time centralized source of information for patch=20
status, every developers needs to track status individually, which adds=20
to everyone's workload.

Afaics there are two benefits to using the mailing list for review=20
discussion. First, one can fairly easily see most of the discussion=20
around a patch. I say most, because oftentimes patch discussions happen=20
on IRC, too, and these often leave no visible traces. Second, the mails=20
get propagated to several mailing list archives, so we don't lose patch=20
history very easily. say, GitHub, goes offline or commit URLs are=20
arbitrarily changed.

In Delft it was suggested to start using GitHub for patch reviews. I'm=20
not very familiar with the GitHub review system, but I'm in favor of=20
anything that saves developer resources for productive work. So I think=20
we should give GitHub reviews a go and figure out a process where we=20
don't loose the good what's good in current mailing list-based reviews.=20
Probably much of the information what's now in review mails could be=20
merged to the commit message and to inline comments in the code. I=20
believe the idea of sending the final(?) reviewed patch to the=20
openvpn-devel mailing list was also brought up.

And just to be clear: I fully agree that patch acceptance criteria=20
should _not_ be relaxed. That part of the current review system has=20
worked very well.

>
> So what want to propose is to get rid of the openvpn-testing.git
> repository and merge it into the stable openvpn.git and github repositori=
es.

+1. I don't see the need for openvpn-testing.git in SF.net either.

> On the other hand, we do not want to have just a single git repository.
>   That is to better safe-guard us against situations similar to what the
> Linux kernel community experienced a few years ago, where a public git
> tree got manipulated by an outsider.  By having several publicly
> available git repositories, it will hopefully be easier to discover if
> something bad has happened - especially for those not necessarily
> directly involved in the developers community.

Agreed. The stunts SourceForge has been pulling off lately make me happy=20
for having the repositories in GitHub also.

> As a side note, both Gert and I have commit access to the public
> repositories, and we also do pushes to private git repositories as well
> - as an extra layer of repository validation.

I believe Git itself should complain loudly if someone has been=20
rewriting history of a (remote) repository maliciously.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

