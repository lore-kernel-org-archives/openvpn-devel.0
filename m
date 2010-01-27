Message-ID: <4B60C881.7060404@...1114...>
Date: Thu, 28 Jan 2010 00:13:05 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B4DBCE6.2010500@...515...>	<20100113174945.12137.qmail@...1287...>	<4B56DD56.6000804@...515...>	<C9D1AE76-F7C2-4913-8F8D-0C0718922538@...1286...>
	<4B571019.7040506@...515...>
In-Reply-To: <4B571019.7040506@...515...>
Subject: Re: [Openvpn-devel] Summary of the "OpenVPN development
	model"	meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 20/01/10 15:15, Samuli Sepp=E4nen wrote:
>=20
>> On Jan 20, 2010, at 04:39:18, Samuli Sepp=E4nen wrote:
>>
>>  =20
>>> Hi all,
>>>
>>> I dug a little deeper into Trac and to Redmine, which was another
>>> candidate for the (developer) site. I took a look at Git support which
>>> we need (if we need to start using Git later on). Trac has had some
>>> _serious_ performance problems when using the GitPlugin to browse Git
>>> repositories. These problems are apparently due to the architecture of
>>> the GitPlugin. It seems they have not yet been fixed. However, one "fix"
>>> may be to integrate GitWeb with Trac using the GitWebPlugin. Redmine, on
>>> the other hand, seems to support Git better, but has it's share of minor
>>> Git problems, too. Also, Redmine does not yet seem to support multiple
>>> Git branches without dirty hacks. Trac has a very wide array of actively
>>> developed plugins available. Redmine has quite a few, but not as many as
>>> Trac. Trac was also the clear favorite among everyone in the community
>>> site meeting. We also have in-house expertise with Trac and Python,
>>> which makes it easier for us to deploy and maintain.
>>>
>>> I've used both Trac and Redmine, and I think the main advantage of
>>> Redmine is better support for multiple projects. As the links Peter
>>> provided show there are several ways to host multiple projects using
>>> Trac. None of these are 100% solutions, but I'd put them in the "good
>>> enough" category. Also, better support for multiple projects should be
>>> coming in next release (0.12). It's not clear, however, when that
>>> release will be made (see http://trac.edgewall.org/roadmap).
>>>
>>> I suggest we choose Trac for our developer site. I think we should still
>>> have a simpler, less development-oriented site for casual users and for
>>> general, non-developer content (wiki, forums, etc.). I think both Trac
>>> and Redmine sites feel too developer-oriented, no matter how much the
>>> themes are customized. What do you think?
>>>    =20
>>
>> As I suggested during the IRC meetings, there is not yet a need for git =
and the features of git, or another VCS, as SVN is meeting the current need=
s.  I think the developer community would not be 'upset' by a change later =
if it was deemed appropriate, and so a lot of time is unnecessarily being w=
asted on researching this.
>>
>> Until SVN is failing the organization, just keep using it. =20
>> ---
>> Eric Crist
>>  =20
> We agreed in the meeting that having _support_ for Git was important
> because we _may_ need it. Therefore it would be unwise to blindly select
> an application (say, Trac) without checking if Git is supported - at
> least on some level. I don't think the ~1 hour I spent verifying this
> was wasted time. Also, nobody is moving to Git, but we need to be able
> to do it, if necessary.
>=20
> Agreed?

I'm back from a short weeks holiday, so I'm catching up now.  But I
agree with you Samuli.  It's not needed to move over to git now, but we
must be sure to not limit ourselves in the future to only SVN.  It's
plenty of git/SVN wars around, it's plenty of arguments of why or why
not to move, and all of the arguments can be right or wrong - all
depending on the roles of those involved in the discussions and their
preferences.

Another thing to be aware of is that a lot of projects are moving from
CVS and SVN (which are the most commonly used centralised VCSes) over to
distributed ones, like Mercurial, Bazar or git.  In all those moves,
it's always been a lot of noisy discussions about why/why-not and
how/how-not questions.  We might need to really dig into that one as
well some point.  But, I don't think the timing is right now.  And the
discussion should really be among those persons who are directly touched
by such changes.

But this is not the discussion we need right now, IMHO.

On the other hand, it is important to also be aware of that git can do
everything SVN can do, but not the other way around - as SVN is
centralised and git is distributed.  Of course pro-svn people will argue
that there are solutions for that as well, but that's another discussion
as then we move the discussion over to how SVN was designed to work.
But that git (or other distributed VCSes, for that matter) have a
broader feature-set than SVN, also speaks for looking at web modules
which are flexible and can support a broader range of VCSes.

And to be honest, the VCS discussion is a discussion which primarily
should go between the developers who are more heavily involved the
development processes, as a VCS will hit their work directly and make it
easier or more annoying to work together.  For those of us not being
heavily involved in development processes from day-to-day, we can
probably survive with whatever VCS is being used.

Anyhow! First, a development model needs to be settled, IMHO.  When we
see how that model works, and gets some more hands-on experiences on how
it works and what does not work well - then we can discuss which tools
to use.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAktgyH0ACgkQDC186MBRfrpqOACgoHdvbX+HapTOcgwxIoTzrQdX
kRcAn2+8f1Lo5Vl6AF+cxJ3uW6z7fmnr
=3DiiHD
-----END PGP SIGNATURE-----

