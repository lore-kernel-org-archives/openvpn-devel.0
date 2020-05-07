From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <9d879a78-47c9-5be5-5798-98e07bc25c89@...515...>
Message-ID: <295783be-b1fe-2e98-6978-5b99fa74885c@...515...>
Date: Thu, 7 May 2020 22:29:02 +0300
MIME-Version: 1.0
In-Reply-To: <9d879a78-47c9-5be5-5798-98e07bc25c89@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="h5x9E4f2uoCAd1eHk35Arq1riSF5JUEsV"
Subject: [Openvpn-devel] Summary of the community meeting (7th May 2020)
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
--h5x9E4f2uoCAd1eHk35Arq1riSF5JUEsV
Content-Type: multipart/mixed; boundary="McwYeUUlR3fbnwOAf02v9nlBdsx7yMoCu"

--McwYeUUlR3fbnwOAf02v9nlBdsx7yMoCu
Content-Type: multipart/mixed;
 boundary="------------FB990164CCFD182B08970E87"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------FB990164CCFD182B08970E87
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 7th May 2020
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-05-07>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo and mattock participated in this meeting.

---

Noted that cloudflare has now been disabled on community.openvpn.net
(again) to get IPv6 working. This is hopefully just a stop-gap measure
before we get IPv6 enabled in Cloudflare - for community.openvpn.net or
for whole openvpn.net domain.

--

Noted that most of OpenVPN Inc. has been working on CloudVPN which has
now been released:

<https://openvpn.net/cloud-vpn>

It is not clear if CloudVPN supports IPv6 transport. IPv6 payload seems
to be supported. Mattock made some queries during the meeting.

--

Discussed OpenVPN 2.5. Noted that the high-level status has not changed
recently:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25>

The recent activity was directed at cleaning up the backlog, Trac
tickets, etc. which was also needed.

The amount of effort required by most "must have" tasks seems fairly
reasonable:

- async-cc stuff
  - it's there, it works
  - needs polishing, some refactoring and review
  - a few days of focused work
- MSI installers
  - needs final integration + testing
  - 1-2 days of work assuming no major roadblocks
- asymmetric compression
  - just needs the final ACK

Effort required by man-page reformatting and IPv6-only server were not
discussed.

Ordex is working on the OpenVPN kernel module which is why he's been
isolated from OpenVPN 2.5 tasks. However, dazo and lev have some
bandwidth for taking over tasks from ordex next week.

Mattock will start work on MSI a.s.a.p. so that if any issues are found
rozmansi will have some time to step in. Mattock will also try to locate
OpenVPN Inc. MSI experts, if any, to help with potential MSI issues.

--

Noted that syzzer's successor at OpenVPN-NL has been pretty quiet on the
community front. Also noted that syzzer said he might be able to do some
OpenVPN community work on his free time.

--

Full chatlog attached


--------------FB990164CCFD182B08970E87
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-05-07.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-05-07.txt"

(21:00:46) mattock: guten abend
(21:00:54) dazo: ciao!
(21:01:30) cron2: gr=EF=BF=BDezi!
(21:04:22) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
0-05-07
(21:04:23) vpnHelper: Title: Topics-2020-05-07 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:05:25) mattock: IPv6 on community should work now or soon
(21:05:46) cron2: not now, so "soon" :)
(21:05:57) mattock: unfortunately the "IPv6 on all servers" thing had to =
be postponed - too much stuff going on
(21:06:17) cron2: yeah, it always is
(21:07:20) dazo: Most of the corp folks has been involved in this lately:=
 https://openvpn.net/cloud-vpn/ .... first version finally released
(21:08:23) mattock: yeah, I got dragged into that too
(21:08:34) cron2: does it have IPv6?
(21:08:48) cron2: ah, yes, the web page says so \o/
(21:09:07) cron2: external *and* internal v6?
(21:09:52) dazo: You define all the internal IPs yourself, and I would be=
 surprised if IPv6 was missing
(21:10:11) cron2: that's "internal", but what about IPv6 transport toward=
s the "cloud"?
(21:10:33) cron2: ("--proto udp6")
(21:11:10) dazo: right ... external should be supported, but the ops team=
 knows which IPs has been deployed into production
(21:11:32) dazo: I've not been involved on the production servers, so I d=
unno
(21:11:41) cron2: mattock: do you know?
(21:14:15) mattock: no, not sure
(21:17:13) mattock: ok, distractions over
(21:17:49) mattock: I would not count on IPv6 transport - knowing that ou=
r Cloudflare has IPv6 disabled I would not count on it
(21:18:19) mattock: now, openvpn 2.5 anyone?
(21:18:38) cron2: this is why I'm asking.  We've had problems here in DE =
with client networks behind DS-Lite ("double natted IPv4" plus native IPv=
6) and "server has no v6" starts being a problem
(21:18:45) cron2: (for all that is not "tcp port 80/443")
(21:19:56) mattock: I asked about IPv6 transport on our ops channel
(21:20:00) mattock: maybe somebody knows
(21:21:45) mattock: as far as OpenVPN 2.5 is concerned - no progress yet =
on my end unfortunately on MSI
(21:22:00) cron2: not too much progress on my end here either
(21:22:03) mattock: the big internal project I talked about ended today f=
inally
(21:22:15) cron2: I've been digging through patches, working my way throu=
gh _inline v11 right now
(21:22:16) mattock: the next project is starting but it should not be as =
involved
(21:22:32) cron2: good, so msi on you and v6-only on me :)
(21:22:59) cron2: (I had to do a quick patch to tcpdump yesterday, hah :-=
) )
(21:23:17) mattock: doorbell ...
(21:24:44) dazo: I got about 35 min until my next meeting starts
(21:25:17) cron2: dazo: so how's your time availability?  (and how's orde=
x'?)
(21:25:33) cron2: our major stumbling block is "working with plaisthos on=
 async-cc"
(21:26:53) dazo: It is tight ... but it should be possible to squeeze in =
more community time now
(21:28:40) mattock: should we update the 2.5 status page? it is several m=
onths old
(21:28:56) mattock: I've lost track of the status way back when
(21:29:09) mattock: https://community.openvpn.net/openvpn/wiki/StatusOfOp=
envpn25
(21:29:11) vpnHelper: Title: StatusOfOpenvpn25 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:29:19) cron2: I do not think we have completed anything of those poin=
ts... but let me look
(21:30:00) mattock: I'll make a minor change
(21:31:22) dazo: Do we know if there are any man page changes in the pipe=
 among the last changes we're planning to pull in?  Otherwise I can get s=
tarted on the man page stuff
(21:32:36) cron2: I am not aware of any, but lost track
(21:36:15) cron2: ok, so the "must have" are "unchanged"
(21:36:30) mattock: since months
(21:36:52) cron2: the "try to make it happen" is also unchanged :-(
(21:37:09) mattock: hmm
(21:37:28) mattock: there has been lots of activity recently - I wonder w=
here it was directed then :P
(21:39:38) mattock: well, this is not nice
(21:39:54) cron2: this was in the "trac tickets, floating-around patches,=
 clean up" section, but not one of the major blocks
(21:40:03) mattock: ok
(21:40:16) mattock: so we really need a final push which focuses on the m=
ust haves
(21:40:25) mattock: before we start having a backlog of that other random=
 stuff again
(21:41:05) cron2: corp needs to release ordex a bit more :)
(21:41:20) mattock: yep
(21:43:30) mattock: dazo: any idea on how to make the happen?
(21:43:43) mattock: also, any idea of the effort required by the "must ha=
ves"?
(21:43:50) mattock: are we speaking of hours, days or week of work?
(21:44:40) cron2: a few days of focused work for the async-cc stuff - it'=
s there, it works, it "just" needs polishing, some refactoring, and revie=
w
(21:46:24) mattock: the MSI stuff is probably 1-2 days of work (including=
 testing) assuming there are no major issues
(21:47:06) mattock: asymmetric compression?
(21:47:13) dazo: We have isolated ordex to be able to progress more rapid=
ly on the kernel module ... which will also provide openvpn 2.x support a=
s well .... we know it is not too good for the 2.5 release, but lets see =
if lev__ or I can try to help on the review side for the async-cc stuff
(21:47:15) cron2: needs a final ACK, I think
(21:47:30) cron2: (the asymm compression)
(21:47:44) dazo: review is tagged "syzzer/cron2" ... is that doable?
(21:47:48) cron2: lev__ could certainly do this, I think, as he found qui=
te a few async bugs
(21:48:04) cron2: dazo: review fort aht?
(21:48:23) cron2: ah
(21:48:24) cron2: yes
(21:48:29) cron2: I'll bite
(21:48:32) dazo: :)
(21:49:28) dazo: lev__ is on some training courses this week ... so I hop=
e we can figure out something for next week.
(21:49:50) cron2: I need him to figure out my win7 openvpn problems as we=
ll :)
(21:50:14) dazo: heh ... alright, I'll make some notes :)
(21:51:32) cron2: someone who understands crypto could have a look at the=
 tls-groups patch...
(21:52:40) ***dazo got 3-4 minutes until needing to prepare for next meet=
ing
(21:53:10) mattock: quick question: so what is syzzer's availability nowa=
days?
(21:53:16) cron2: spotty
(21:53:23) mattock: did he get a new job or something?
(21:53:54) cron2: changed department in fox-it
(21:54:23) mattock: where is the bright new guy then?
(21:54:37) cron2: seems to be a bit shy
(21:55:02) mattock: but there is such a thing?
(21:55:52) cron2: supposedly syzzer can now work in his spare time on ope=
nvpn, not being all burnt up by work exposure to openvpn :-)
(21:56:09) cron2: and a new guy works on openvpn-nl which we sort of have=
 met before (Karlsruhe?)
(21:57:13) mattock: mkay
(21:57:20) mattock: but there is some hope on the crypto front
(21:57:32) dazo: Just asked lev__, he will try to allocate some time next=
 week
(21:57:37) mattock: \o/
(21:57:48) cron2: nice
(21:58:06) mattock: I will also try to allocate time on MSI next week - a=
t least to see if it is all smooth sailing or if rozmansi will need to wo=
rk on something
(21:58:16) mattock: I will also try to locate any MSI guys we might have =
in-house
(21:58:27) mattock: forgot to do that last week
(21:59:06) ***dazo gotta go
(21:59:21) mattock: I think we can call this a day - we did manage to do =
something useful at least :D
(21:59:26) mattock: ok?
(21:59:36) cron2: yep... good night :)
(22:00:32) mattock: good night!
(22:02:04) mattock: IPv6 was missing the AAAA record
(22:02:08) mattock: should start working shortly
(22:02:45) cron2: community.openvpn.net has no AAAA record
(22:03:07) cron2: ah, now it's there
(22:03:12) mattock: yep
(22:03:14) cron2: local resolver still has the NXDOMAIN cached
(22:03:14) mattock: I just added it
(22:04:05) mattock: I will try to get IPv6 enabled across the board becau=
se on the next DoS (and those do happen occasionally) they will just turn=
 on cloudflare and then IPv6 is broken again on community
(22:04:23) mattock: this is just duct tape to cover the problem
(22:12:18) cron2: so v6 is direct, not via cloudflare?
(22:20:12) mattock: yes, direct for now
(22:20:24) cron2: better than nothing and it will quiet my monitoring :)
(22:20:30) mattock: and mine
(22:20:42) mattock: I have IPv6 monitoring for community servers now
(22:21:04) mattock: technically it checks the certificate expiration, but=
 as it does it via IPv6 tranport it will alert on broken IPv6 as well
(22:26:27) mattock: that could of course cause us to not catch IPv4 issue=
s on those servers :D

--------------FB990164CCFD182B08970E87--

--McwYeUUlR3fbnwOAf02v9nlBdsx7yMoCu--

--h5x9E4f2uoCAd1eHk35Arq1riSF5JUEsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl60YX4ACgkQKVhNn0CG
RXhwzQf/ZLfClHN8vnGn9gHSpJxszRVAgo9938EYbq3675FSgPcq86k3srO2q7PG
yn5DIH+i6k9J9/L8QOpFiZ77vLCdmamI4noOJZzir5mTvuhYnRqXLRwcdn1OvzLf
0mPLztdH0FABHpGtwD+tCUgAbW49T4SA/mmgAA60Dk1GER9vrq5KEbSuvjTnD4FG
GrG78bZDWYE1orGDPIth/w2RzXjmJxMsvCt3bHpZlrUjjBvi/9GelyL1rGj2yZhH
cB5Wf9cYemNz7NOA+q5/1uIsdTWlCpgwMaEc/A3L6acxDD903H4gpMLjy8wBQZsC
GOI27eskK2Ouo1F6gdc2TOQBKGDhUw==
=1xXL
-----END PGP SIGNATURE-----

--h5x9E4f2uoCAd1eHk35Arq1riSF5JUEsV--

