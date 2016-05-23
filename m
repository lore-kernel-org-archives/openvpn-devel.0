References: <1463822525-2532-1-git-send-email-openvpn-devel@...2127...>
	<1463822525-2532-2-git-send-email-openvpn-devel@...2127...>
	<20160521095424.GQ53051@...1296...>
	<BF0BE230-3DDA-4CF6-A8DB-CABBE0825CF4@...2127...>
	<20160521111016.GS53051@...1296...>
	<9715E28C-0B26-4EAE-907A-B8A326BF98A7@...2127...>
	<20160522124546.GA53051@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <5742C2E1.2060407@...515...>
Date: Mon, 23 May 2016 11:44:17 +0300
MIME-Version: 1.0
In-Reply-To: <20160522124546.GA53051@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Refactor t_client.sh
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
To: Gert Doering <gert@...1296...>, Jens Neuhalfen <openvpn-devel@...2127...>
Cc: openvpn-devel@lists.sourceforge.net


> Hi,
>
> On Sun, May 22, 2016 at 02:38:05PM +0200, Jens Neuhalfen wrote:
>> [???]
>>
>>> My buildbots test on "all the BSDs" (Free, Net, Open, and they have a
>>> /bin/sh which is "It only supports features designated by POSIX plus a =
few
>>> Berkeley extensions") and OpenSolaris 11 (ksh93).  Samuli's buildbot
>>> test on various Linux variants, so "dash" should work.
>>
>> Are these buildbots available vor the general public? Being able to easi=
ly test
>> lowers the bar for new contributors considerable.
>
> Right now, not for "general public".  They auto-build (+test) every relea=
se
> that gets commited to "master" - which, of course, means "it is too late
> if it breaks platform <x>".
>
> We have discussed building from test branches (on-demand), and widening t=
he
> access to these branches - but nothing specific has been decided yet.  Ma=
ybe
> we should put that on the agenda for the monday meeting on May 30...
>
>   - addition of new branches (at github), with more liberal commit rights
>   - having the buildbots pull from github (right now they use sf, AFAIR)
>   - opening the buildbot "build revision <x> on platform <y>" API for
>     a wider circle (right now, I think only Samuli, David and I have acce=
ss
>     to that host, it's on private addresses in Samuli's VPN)
>
> I'm a bit reluctant giving "full user account" access rights to developers
> I have not met in person yet - but with the approach outlined above, at
> least sanity checking "I think the patch is good, will it break one of the
> more esoteric platforms?" will be possible.
>
> Samuli, are you listening? ;-)
>
> gert

Yes. I think a separate testing branch with more liberal commit rights=20
combined with pulling from GitHub makes sense. I'm not sure what happens=20
at the buildslaves if we decide rewind history - rewinding would be=20
quite useful when working with pure testing branches in that we could=20
make "testing" track master and whenever a bad patch is found, simply=20
rewind back to the last known-good state.

I'd prefer to keep the actual buildslave infrastructure private, with=20
access granted to only a select few. We already get email notifications=20
to a public list for each build failure.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

