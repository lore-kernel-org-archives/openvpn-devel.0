References: <5c4e3f93-c584-4a19-4081-9bf4adaf417a@...277...>
	<502e093a-cb39-c76d-27b5-ab86fd4bcfd6@...515...>
	<73352d7f-521e-b968-2990-8783955da5c9@...2080...>
	<04516948-204e-57c2-fb57-f355157ed5af@...515...>
	<CAKuzo_gRDm566EwD_qtrYNM5AOYHF8xgCzsi1FQ3emjYGDeGmw@...278...>
	<43094758-efda-c613-c51d-e7980dfa6b24@...2080...>
	<CAKuzo_iaEhhrVhRr_zPATsFHinFi=ECtDFofEB2_8zP7Z2+zSg@...278...>
	<90baad6a-25c5-2ecc-1ea8-b5a1febf1521@...2080...>
	<cadcd4fa-701e-2d35-4fe0-66707dae8b5b@...277...>
	<9ba106aa-7dc7-753b-d662-6a75c6d16314@...2080...>
	<20161101111010.GH28918@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <17b0a8f9-ebc5-d46a-b024-eb0bf57bafe2@...515...>
Date: Tue, 1 Nov 2016 14:20:24 +0200
MIME-Version: 1.0
In-Reply-To: <20161101111010.GH28918@...1296...>
Subject: Re: [Openvpn-devel] trac 757 --auth-user-pass up + GUI 2.3 vs 2.4
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

Il 01/11/2016 13:10, Gert Doering ha scritto:
> Hi,
>
> On Mon, Oct 31, 2016 at 11:55:08PM +0100, David Sommerseth wrote:
>> How long will users be willing to wait?  I'd be really surprised if 2.4
>> is out the door before Christmas 2016.  When also considering we've said
>> that 2.4_alpha was soon ready for about 1 year or so before it really
>> got released, I'd even say I am overly optimistic.
>
> If we could spend our time on a somewhat focused work on 2.4, instead
> of exhausting ourselves discussing feature backports to 2.3, this could
> happen faster.
>
> And more *focused* work: less rounds of review, buildbot explosions, etc.,
> which eats up everyone else's precious time.

It would be good to:

1) Catch the issues before buildbot

In my recent INSTALL-win32.txt removal patch the breakage could have=20
been avoided if I had been less sloppy and had actually tried to build=20
the thing before sending in the patch.

A basic "make check" goes a long way, but I intend to de-bashify the=20
Vagrant integration soonish, so that we can merge it. This should make=20
it easier for developers to catch runtime errors before sending in patches:

<https://github.com/OpenVPN/openvpn/pull/45>

2) Have buildbot catch issues before code is in Git "master"

This could be solved by tracking an "experimental" or "buildslave"=20
branch in Git, which would be basically Git "master" preview with forced=20
update (history rewrite) option. Normal people should never use this=20
branch, as the history would get rewritten whenever a patch would have=20
to be rolled back. This would help ensure that Git "master" is always in=20
a good shape.

That said, doing 1) properly should help mitigate the risk of Git=20
"master" breaking often. The less trivial issues will not be found on a=20
single developer machine anyways.

>
>
> Grumbling aside, our feature page for 2.4 sees us in reasonably good
> shape - all the major work has been done, Samuli has done some amazing
> work on automated windows testing, and all the test reports we've received
> so far have been "yeah, it works".
>
> So, what is missing for 2.4 (please update the page as you go)?
>

This is one that I have to fix, unless xkjyeah responds soonish:

<https://github.com/xkjyeah/openvpnserv2/issues/10>

I can also provide a documentation patch for Trac 757. I added both of=20
these tasks here:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn24>

> I see TLS record splitting, which I have no idea how invasive this is
> going to be, and how much time is needed to make that happen (and to
> test it).  A number of trac tickets for specific corner cases (like,
> FreeBSD 11 with topology subnet).
>
>
> I still think the timeline "end of 2016" should be doable - there's
> some reasoning to meet that: it will make the next Debian release.

If Debian 9 is frozen by the end of the year, then that is a good goal.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

