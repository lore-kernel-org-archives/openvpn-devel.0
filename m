From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <cde19afd-b6cb-3b99-b346-1cfcdcebbbe2@...515...>
Message-ID: <693794ff-c2fd-1fbe-781e-d98964ff53e1@...515...>
Date: Thu, 4 Jun 2020 22:04:45 +0300
MIME-Version: 1.0
In-Reply-To: <cde19afd-b6cb-3b99-b346-1cfcdcebbbe2@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="r4ptYIhAg83GH54EhkKkqDQokk1aAJR1U"
Subject: [Openvpn-devel] Summary of the community meeting (4th June 2020)
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
--r4ptYIhAg83GH54EhkKkqDQokk1aAJR1U
Content-Type: multipart/mixed; boundary="OzciQHLeGj1fZZlfJbCHHiWx2OMYHjhmr"

--OzciQHLeGj1fZZlfJbCHHiWx2OMYHjhmr
Content-Type: multipart/mixed;
 boundary="------------1C2B7D5F077A449747090902"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1C2B7D5F077A449747090902
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 4th June 2020
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-06-04>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, ordex and plaisthos participated in this meeting.

---

Noted that mattock had forgot to send out the meeting invite and to
create the topic pages. He fixed that at the beginning of this meeting.

--

The "not-SSO" patchset is now ready to be merged. Cron2 will do it when
he has a bit of time.

--

Noted that the IPv6-only patchset should be ready to merge now and it
passes t_server tests already. Cron2 shall eyeball it one more time,
just in case.

Also noted that the planned hacking session between ordex and cron2
worked out great in "I'm in a meeting, you may go away"-sense.

--

There is now a TestCoverage wiki page:

<https://community.openvpn.net/openvpn/wiki/TestCoverage>

--

The two big things missing from 2.5 now are async client-connect and
MSI. Mattock will allocate a full day for MSI next week, as the flow of
infrastructure tasks to him shows no sign of stopping.

--

Talked about dazo's man-page reformatting patch. Dazo is wondering if
splitting the to-be man-page into several .rst files instead of one
would make sense. Cron2 will try his luck building a man-page with
dazo's new code.

--

Talked about HackerOne. Mattock was in a meeting with OSTIF and heard
that OpenSSL project has had similar low-quality HackerOne reports
mostly about website issues. Nobody in this OpenVPN community meeting
would feel sorry if we'd lose our HackerOne project.

--

Noted that some community people have complaints about the openvpn.net
website. It just so happens that dazo and mattock now do monthly
meetings with the corporate website people. So, if anyone has
feedback/rants about OpenVPN website(s) just let dazo or mattock know
and they'll do their best to make things suck less.

--

Full chatlog attached

--------------1C2B7D5F077A449747090902
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-06-04.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-06-04.txt"

(21:01:48) cron2: topic fixed! :)
(21:02:22) mattock: hello
(21:02:24) mattock: thanks!
(21:02:38) mattock: who else?
(21:02:55) cron2: I'm not here
(21:03:29) dazo: I'm here, I hope :-P
(21:03:30) mattock: ok good, then it is just me
(21:03:32) mattock: :D
(21:03:33) mattock: ok
(21:03:43) cron2: mass meeting!
(21:04:55) mattock: dazo: do you know if plaisthos, lev or ordex might be=
 joining?
(21:05:04) dazo: Just sent them a message
(21:05:20) cron2: since the topic page is not yet existing, shall we just=
 do the usual round of "working on it! for real!"? :-)
(21:06:14) dazo: hehe ... yeah
(21:06:33) cron2: but you actually got stuff done, so you can't speak in =
this round :-))
(21:07:01) dazo: I'm still on the man-page project ... it's ready to get =
some quick reviews and tests before I send the patches to the ML
(21:07:50) mattock: wow, I forgot to add the topic pages
(21:07:55) cron2: I saw your ACKs on the "not-SSO" patchset.  It's on my =
plate to be merged, and was planned for "last Sunday/Monday", right after=
 ipv6-only...  *that* one turned out to be a bit more stubborn and needed=
 a v5, and then I ran out of time
(21:07:59) mattock: I hope I did not forget to send the invites... :P
(21:08:04) cron2: I think I should be able to do this tomorro
(21:08:18) dazo: I've been through lots of the openvpn.8.rst file ... and=
 there is some duplicated info, and some things which could use some clea=
nups ... I'm pondering on splitting the file into multiple file which is =
put together as a single man page ... to make it easier to see which sect=
ion to put options into
(21:08:20) cron2: mattock: well, maybe you didn't send them on purpose? :=
)
(21:08:27) mattock: could be :)
(21:08:45) mattock: well, I've been bogged down - my infrastructure-relat=
ed workload increased, not reduced this week
(21:09:06) mattock: I'll send the invites out now for the upcoming meetin=
gs
(21:10:52) mattock: sent
(21:11:02) mattock: creating topic lists while you discuss other stuff
(21:11:05) mattock: :)
(21:11:44) dazo: some encouragements to have people look at the openvpn.8=
=2Erst file and and come with suggestions for improvements would be great=

(21:13:00) plaisthos: not really here ...
(21:14:57) cron2: but anyway, on the positive side, the ipv6-only patchse=
t has been reviewed and reworked last week, and is now "ready for merge".=
  I intend to review and review each patch again (to be sure that no reba=
se/rework accidents happened), but that should be easy.  Passed the t_ser=
ver test already :-)
(21:15:52) cron2: on the "testing coverage", I've started a bit on https:=
//community.openvpn.net/openvpn/wiki/TestCoverage but this needs way more=
 input (and possibly even a different format)...
(21:15:54) vpnHelper: Title: TestCoverage =E2=80=93 OpenVPN Community (at=
 community.openvpn.net)
(21:16:01) dazo: nice ... so ... the asymmetric compression and MSI are t=
he hot potatoes now?
(21:16:13) cron2: async cc shouldn't really be hard
(21:16:25) cron2: uh
(21:16:33) cron2: asymmetric compression shouldn't be hard
(21:16:49) cron2: the big open thing is "MSI" and "async client-connect",=
 which is close enough to "asymm comp" that I mistyped
(21:17:16) dazo: oh, there's async client-connect as well
(21:17:28) ***ordex is here !
(21:17:32) dazo: \o/
(21:17:34) mattock: hi ordex!
(21:17:37) ordex: hi
(21:17:39) cron2: hi ordex
(21:17:43) plaisthos: I am more afk than here
(21:17:46) ordex: hi=C2=B2
(21:18:38) mattock: I will allocate one full day for MSI next week, so th=
at I know if more time is needed
(21:19:29) mattock: the flood of other works has not clear end in sight
(21:20:18) cron2: sounds like a workable plan.  (Just as a note: arrangin=
g a timeslot with ordex to focus on "now we do *this*" turned out to be a=
 very good idea - I could push away all other stuff with "I have a meetin=
g now, leave me alone" and we got stuff done)
(21:20:43) ordex: yap yap
(21:21:06) mattock: \o/
(21:21:32) cron2: I do not have much else to say, and I'm way too tired f=
or meaningful patchwork review
(21:21:38) ordex: it turned out to be longer than the 2 hours we had plan=
ned, but it was good anyway
(21:21:51) cron2: yes
(21:22:26) dazo: cron2: whenever you get a chance to test the dev/man-ref=
ormatting branch on the host you do your 'make distcheck' steps would be =
valuable
(21:23:22) cron2: uh... I think I totally forgot to do "make distcheck" o=
n the last few 2.4 releases... :-)
(21:23:40) dazo: how did you produce the tarballs?  just 'make dist'?
(21:23:54) cron2: "tag, push --all --tags, hey mattock, stuff is done!"
(21:24:14) dazo: hmmmmm .... how did mattock generate the tarballs? ;-)
(21:24:19) cron2: all "building of things that are then signed and put so=
mewhere" happens on mattocks side :-)
(21:24:35) cron2: I assume with "make dist(check)" :)
(21:24:40) mattock: yes
(21:24:45) dazo: When I did the releases, I did the 'make distcheck' step=
 and gave mattock the tarball=20
(21:25:03) cron2: *that* ended up in having multiple tarballs with confli=
cting signatures, so I don't :)
(21:25:22) dazo: ahh right
(21:25:37) mattock: yep
(21:25:46) dazo: anyhow, the change I've done is to generate man page and=
 the html file from the .rst file during 'make dist(check)'
(21:25:50) mattock: it was easier to just add that part to my release scr=
ipt
(21:25:57) cron2: but I *should* do the distcheck, to be sure we haven't =
overlooked any new files that should be bundled
(21:26:02) ***cron2 makes mental note
(21:27:05) dazo: But that generation is only happening *if* the python-do=
cutils is available .... If that is missing, 'make clean' will _not_ remo=
ve those generated files ... but not sure how it behaves directly from a =
git tree without those files generated ...
(21:27:21) cron2: I need to test that, right
(21:28:32) cron2: now if I knew how "python-docutils" translates to gento=
o ebuilds or freebsd pkgs
(21:28:56) cron2: dev-python/docutils
(21:28:57) cron2: that was easy
(21:29:06) dazo: yeah, that sounds right
(21:29:10) cron2: py37-docutils
(21:29:16) cron2: also not hard
(21:29:49) dazo: yay!
(21:31:24) cron2: plaisthos: in case you're looking at your keyboard :-) =
- do you have time next week to debug auth-token related funnies?
(21:31:32) cron2: and come up with patches :-)
(21:32:11) cron2: (explicit-exit-notify breaks auth-token clients today, =
and my colleagues managed to produce other breakage as well, which smells=
 similar "the client stops updating the token it sends to the server")
(21:32:20) plaisthos: not yet, sorry
(21:32:28) cron2: "have time next week"
(21:32:33) cron2: not "had time last week" :)
(21:40:44) mattock: good question :)
(21:44:14) mattock: plaisthos ran away?
(21:44:28) mattock: I have a topic
(21:44:32) cron2: seems like it, and everyone else fell asleep :)
(21:44:40) mattock: I was in a meeting with OSTIF.org and discussed hacke=
rone
(21:44:50) mattock: there was an openssl developer there as well
(21:45:19) mattock: the openssl project's experience with hackerone was p=
retty much the same as ours
(21:45:19) cron2: and...?
(21:45:22) cron2: ah
(21:45:31) mattock: =3Dlots of website reports, nothing really worthwhile=

(21:47:29) mattock: I suppose nobody would be sorry if we stopped receivi=
ng HackerOne reports, should it go away?
(21:47:58) cron2: I would totally miss the reports about your website bei=
ng totally insecure!
(21:48:24) cron2: (but I can have wiscii or ecrist rant in #openvpn-devel=
 for a bit on how horrible the corp site is and that it's totally neglect=
ing the community side of things)
(21:49:00) mattock: btw. that gives rise to another topic
(21:49:16) mattock: dazo and are in a monthly meeting with the corp websi=
te people
(21:49:19) mattock: now
(21:49:23) mattock: tomorrow is the next one
(21:49:46) mattock: so, if there is any ranting it can be directed to daz=
o or me, and we will relay the rants to corp website people
(21:49:56) mattock: those responsible of doing design etc.
(21:50:07) mattock: page layouts, content, etc.
(21:51:28) cron2: it's all totally horrible.  I think.  All modern websit=
es are horrible.
(21:51:36) dazo: hehehe
(21:52:09) cron2: but on a similar tangent - does one of you want to answ=
er these "Orca Security" people?
(21:52:21) dazo: Yeah, we're tracking this=20
(21:52:26) cron2: I find it totally interesting that your AWS instances h=
ave a bug in their *WIFI* driver.
(21:52:37) cron2: never knew AWS was secretly using wifi!
(21:52:41) dazo: hehehe
(21:52:41) mattock: well, they probably bundle a linux kernel which happe=
ns to have the module
(21:52:45) mattock: :)
(21:53:09) dazo: but there are some kernel flaws which can be abused if t=
he driver is loaded, regardless if the hardware is present or not
(21:53:15) cron2: it looks like it, yes - "look, you are using 4.somethin=
g, which is KNOWN to have 145 security issues, so we just list them all!"=

(21:53:17) dazo: so we need to double check this
(21:53:44) cron2: why would the driver be loaded...?
(21:53:48) dazo: but the magnitude of checking all the variants of AS ser=
vers is hilarious .... it's the same base image
(21:53:59) dazo: could be autoloaded for some reason
(21:54:27) plaisthos: that report mention something like "when receiving =
a station frame" or something
(21:54:47) dazo: heh ... well, then it is not really applicable
(21:58:30) mattock: I heard that one time Google dumped a total of 2000 s=
uch (potential) security vulnerability reports to the Linux kernel projec=
t=20
(21:58:48) mattock: "please fix, some of these may be valid, we found the=
m with our new fuzzer"
(21:58:52) cron2: ouch
(21:58:52) mattock: or something along those lines
(21:59:19) dazo: I don't think they'll do that again :-P
(21:59:44) mattock: I hope they'd actually review them themselves and pro=
vide patches
(21:59:48) mattock: in the future
(21:59:57) mattock: anyhow, 1 minute left
(22:00:04) mattock: are we done?
(22:00:21) cron2: I was done for the day before we started *yawn* :-)
(22:00:38) mattock: sounds like "yes"
(22:00:44) dazo: yeah, sounds good :)
(22:00:47) mattock: I have the summary ready so let's call it a day
(22:00:55) mattock: good night guys!
(22:00:57) cron2: *wave* good night :)
(22:00:58) ordex: thanks!

--------------1C2B7D5F077A449747090902--

--OzciQHLeGj1fZZlfJbCHHiWx2OMYHjhmr--

--r4ptYIhAg83GH54EhkKkqDQokk1aAJR1U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl7ZRc0ACgkQKVhNn0CG
RXi4ngf+JrtvZDZLzWCydpyQqhaKtULhFqs1JhSHrie2ONN2Zzz9Y0L3ZOYnLRAY
HxL+Hakc5xaiipsGwxR0aJa1OidVQxZxjdzrzE8STY+Xk0U3IlQPwphHZ0b2uqb8
zIchZk8Ftr0vde2zzD3xlMyQ1c0Nl4Yn+QHtNAaAhqc1QN8P88Ftjsam2bOs9vgP
r5RbMtKGmCxtValS8+wz9J31MWq05NnyQhKG42im+dD9I6Ahdu2jcyyQ0Ac+/Vr/
D9VBUw0iWsCLL4+crNu2gSGrneYpRtUHmRqxOv3Su+uMKvZ+HX7ukJT1tOkdjoYq
r4lN9if0B+GxKb3S2KtrWeNS7S03TQ==
=gBlo
-----END PGP SIGNATURE-----

--r4ptYIhAg83GH54EhkKkqDQokk1aAJR1U--

