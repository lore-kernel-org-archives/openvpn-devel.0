From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <596f0202-4908-6657-373e-ce6b7346b8e5@...515...>
Message-ID: <624cb998-25f2-600a-b6e8-58010cf3dc9c@...515...>
Date: Fri, 30 Aug 2019 10:39:50 +0300
MIME-Version: 1.0
In-Reply-To: <596f0202-4908-6657-373e-ce6b7346b8e5@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ukef75y3d5jMpjMf0jaXkxdgc1qdaRICe"
Subject: [Openvpn-devel] Summary of the community meeting (29th August 2019)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ukef75y3d5jMpjMf0jaXkxdgc1qdaRICe
Content-Type: multipart/mixed; boundary="e3LknkoHY4lIYkylBvQVKz9yeqy72HbuW";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <624cb998-25f2-600a-b6e8-58010cf3dc9c@...515...>
Subject: Summary of the community meeting (29th August 2019)
References: <596f0202-4908-6657-373e-ce6b7346b8e5@...515...>
In-Reply-To: <596f0202-4908-6657-373e-ce6b7346b8e5@...515...>

--e3LknkoHY4lIYkylBvQVKz9yeqy72HbuW
Content-Type: multipart/mixed;
 boundary="------------A86036905A26C4515D3035F9"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A86036905A26C4515D3035F9
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thursday 29th August 2019
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-08-29>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2 and mattock participated in this meeting.

---

Briefly touched on HLK testing. It looks like there is something wrong
with the underlying network (or drivers) the physical HLK nodes use -
there are lots of TCP-related errors during the E2EPerf test. This would
help explain why the less aggressive two-machine tests pass, but E2EPerf
does not.

Mattock has downloaded the Virtual HLK and will convert it to Virtualbox
format in the footsteps of rozmansi. With hopefully a successful e2eperf
run under his belt mattock will be better equipped to figure out the
issues in the physical environment.

This task unfortunately progresses at a snail's pace because mattock is
being stretched thin by requests from multiple groups of people.

Mattock's physical HLK lab is now isolated from the rest of the office
network, which will eventually (if needed) allow other people to connect
to it for debugging purposes.

--

Discussed the Fedora 29 connectivity issue revealed by t_client tests a
couple of weeks ago. Mattock planned on separating his buildslaves,
including Fedora 29, into a separate network at his home, so that access
could be provided to others. However, actually placing the buildslaves
to AWS EC2 would be better, as existing community VPN could then be used
to provide access. Buildslave and t_client.sh setup is almost completely
automated so this would not be a particularly big task.

--

Noted that this Friday's mini-hackathon may have fairly limited
audience. Cron2 won't make it and it is unclear if lev, dazo, ordex or
arne can make it. Mattock will regardless try to move the "builder" task
forward; that VM is composed of:

- sbuild_wrapper: Debian/Ubuntu package builder
- openvpn-build: Windows release package generation
- openvpn-windows-buildtest: the "Windows buildslave"

He'll also work on setting up the Virtual HLK (see above).

--

Full chatlog attached.

---

--------------A86036905A26C4515D3035F9
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-08-29.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-08-29.txt"

20:38 < cron2> I won't make the meeting in time either - dinner will be r=
eady around 20:05 and $wife will kill me if I prefer a meeting to "eat wi=
th family"
20:38 < cron2> mattock1: no, ordex, dazo, lev__, and plaisthos
20:38 < mattock1> $wives can be challenging :)
20:38 < mattock1> mattock3 is living inside a tmux session in irssi
20:38 < cron2> ordex sent a note at 19:25 that they want to go partying a=
nd not meet
20:38 < mattock1> are they in the same place?
20:39 < cron2> dunno, but it reads like it
20:39 < mattock1> ok, maybe they're drinking cheap beer in ukraine
20:39 < cron2> so we could have a short meeting at 20:30 or so, if you ha=
ve something to report (or questions to discuss)
20:40 < mattock1> I can give that report now
20:40 < mattock1> so, having looked at packet capture logs for e2eperf te=
st I think there's something wonky in the physical network / windows driv=
ers
20:41 < mattock1> I downloaded the Virtual HLK and will convert that to V=
irtualbox format so that I can see if I can reproduce the success of rozm=
ansi there
20:42 < mattock1> if so, I will see what a successful run should look lik=
e, then figure out how to fix the problem in the physical HLK environment=

20:43 < cron2> sounds like a plan
20:43  * cron2 needs to help $wife with dinner now, will be back
20:43 < mattock1> unfortunately I'm being pulled from all directions to o=
ther tasks
20:43 < mattock1> so things progress at a snail pace
20:44 < mattock1> I started work on the Windows buildslave but it is not =
yet in production
20:44 < mattock1> I'll try to move that forward tomorrow in the mini-hack=
athon
20:45 < mattock1> plus try to convert and launch the virtual HLK thing in=
 Virtualbox
20:56 -!- mattock2 [~mattock@...1423.../corp/admin/mattock] has joined #open=
vpn-meeting
21:04 < mattock1> more mattocks
21:05 < mattock1> if anyone is here let me know :)
20:38 < mattock1> are they in the same place?
20:39 < cron2> dunno, but it reads like it
20:39 < mattock1> ok, maybe they're drinking cheap beer in ukraine
20:39 < cron2> so we could have a short meeting at 20:30 or so, if you ha=
ve something to report (or questions to discuss)
20:40 < mattock1> I can give that report now
20:40 < mattock1> so, having looked at packet capture logs for e2eperf te=
st I think there's something wonky in the physical network / windows driv=
ers
20:41 < mattock1> I downloaded the Virtual HLK and will convert that to V=
irtualbox format so that I can see if I can reproduce the success of rozm=
ansi there
20:42 < mattock1> if so, I will see what a successful run should look lik=
e, then figure out how to fix the problem in the physical HLK environment=

20:43 < cron2> sounds like a plan
20:43  * cron2 needs to help $wife with dinner now, will be back
20:43 < mattock1> unfortunately I'm being pulled from all directions to o=
ther tasks
20:43 < mattock1> so things progress at a snail pace
20:44 < mattock1> I started work on the Windows buildslave but it is not =
yet in production
20:44 < mattock1> I'll try to move that forward tomorrow in the mini-hack=
athon
20:45 < mattock1> plus try to convert and launch the virtual HLK thing in=
 Virtualbox
20:56 -!- mattock2 [~mattock@...1423.../corp/admin/mattock] has joined #open=
vpn-meeting
21:04 < mattock1> more mattocks
21:05 < mattock1> if anyone is here let me know :)
21:05 < mattock1> it is meeting time
21:17 -!- mattock1 [~mattock@...1423.../corp/admin/mattock] has quit [Ping t=
imeout: 244 seconds]
21:18 < mattock2> one mattock down, two to go
21:27 < cron2> now I'm back
21:28 < mattock2> hi
21:28 < cron2> this mini-hackathon will be with out me (mostly) as I'm on=
 vacation
21:28 < cron2> I'll check in at siesta time
21:28 < mattock2> anything new at your end?
21:29 < cron2> no... the usual stuff.  We need a 2.4.x release eventually=
, we have a few "for 2.4" patches in the queue, we want a nice and shiny =
tap6 driver=20
               :) and we need more active developers
21:29 < mattock2> +3
21:30 < cron2> any progress on the "debug test fail #1 on the ubuntu buil=
dslave"?  you planned to separate your network so you could give access t=
o ordex
21:31 < mattock2> did the party animals tell if they would join the hacka=
thon tomorrow?
21:32 < cron2> no, the only part was
21:32 < cron2> (query)
21:32 < mattock2> the HLK env is now mostly separate, but for fedora stuf=
f creating a new buildslave in EC2 might be more useful
21:37 < mattock2> which I planned to do
21:37 -!- pippin__ [Pippin_@...2315.../vpn/protonvpn/pippin/x-75792076] has =
joined #openvpn-meeting
21:37 < cron2> it would save a bit of effort to migrate the existing conf=
ig over (t_client certs and that)
21:39 -!- mattock1 [~mattock@...1423.../corp/admin/mattock] has joined #open=
vpn-meeting
21:40 < mattock1> the buildslave setup is automated including t_client ce=
rts so creating Fedora 29/30 in EC2 is fairly straightforward (new keys, =
migration=20
                  of the puppet code to OpenVPN's puppet-control-repo)
21:41 -!- Pippin_ [Pippin_@...2315.../vpn/protonvpn/pippin/x-75792076] has q=
uit [Ping timeout: 272 seconds]
21:41 < cron2> huh, so it calls out to phillip and creates keys there?  n=
ice :)
21:43 < mattock1> well that is not done at the moment, but it would be do=
able
21:43 < mattock1> if I recall correctly I've been shamelessly reusing vpn=
 keys from decommissioned buildslaves
21:43 < cron2> well, that also works :)
21:45 < mattock1> anyways, the builder (sbuild_wrapper, openvpn-build, op=
envpn-windows-buildtest) and buildslave work is closely related - we've b=
een moving=20
                  our EC2 things under Terraform management which takes s=
ome effort but helps ongoing maintenance a lot
21:46 < mattock1> anyways, the builder VM is the first thing I'll finish =
(incl. windows buildslave)
21:46 < mattock1> it is "nearly there"
21:47 < mattock1> fedora 30 buildslave (which "hopefully" has the bug exp=
osed by t_client tests) would be next
21:47 < mattock1> I hope to get builder going tomorrow - that may be a re=
asonable goal
21:47 < cron2> nice
21:48 < mattock1> anything else we could/should discuss?
21:48 -!- pippin__ is now known as Pippin_
21:49 < mattock1> cron2: will you make it to tomorrow's hackathon?
21:49 < cron2> told mattock2 above
21:49 < cron2> 20:28 < cron2> this mini-hackathon will be with out me (mo=
stly) as I'm on vacation
21:51 < mattock1> oh yes, I see that
21:51 < mattock1> so it will be me fighting openvpn-windows-buildtest
21:51 < mattock1> :P
21:54 < mattock1> so meeting concluded?
21:55 < cron2> yes :)
21:55 < cron2> 5 minutes early!
21:55 < mattock1> good, I have have to wake up very early tomorrow mornin=
g
21:55 < cron2> (has anyone seen syzzer recently?)
21:55 < cron2> good night :)
21:55  * cron2 won't get up before 8:30... kids might get up at 9:30
21:55 < mattock1> no, I have not
21:55 < mattock1> lucky you :)
21:56 < mattock1> I have to get up in 9 hours and I'm only eating a bit b=
efore heading to shower and bed
21:56 < mattock1> anyways good meeting even with the limited participants=
 we had :D
21:58 < mattock1> summary tomorrow

--------------A86036905A26C4515D3035F9--

--e3LknkoHY4lIYkylBvQVKz9yeqy72HbuW--

--ukef75y3d5jMpjMf0jaXkxdgc1qdaRICe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl1o0sYACgkQKVhNn0CG
RXjtNQf4/mgL1fMSlkMj16e4WyTZpAiAQJdy70ug1Ox4yVXbc08t+Y48k9LX9YGm
1qDf1SkSY9iEa0+56c7/Pwq8Z9LYLr9APbp6NFWkct8HUHhX7loH0uG/fyuLv8wi
5xGzbIPwW9DPGWAmN4qK789mRSrU8c9rpUQqjDVJejEYkpmiXvWlsFZOhWGaZ8Bp
FI/MERwiUnoxdQNPyM/n0VjoLKhmtjvk0rPR+x9WxptGSNms0BNx+o/DAQWceeo/
bMhkTbaRo1uNKAKe9emehSC4WXevWa1m14/Hzw0WaEjpOmryFWGXR6F3so8EWSFR
gDr6QDZGZgmMX2FTcqV58VApBvvP
=urRq
-----END PGP SIGNATURE-----

--ukef75y3d5jMpjMf0jaXkxdgc1qdaRICe--

