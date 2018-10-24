From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <39fa6e80-16db-8fd5-727a-edb6f71e1d47@...515...>
Message-ID: <ed49e144-6981-53bb-be28-fa550b7d33d4@...515...>
Date: Wed, 24 Oct 2018 14:29:52 +0300
MIME-Version: 1.0
In-Reply-To: <39fa6e80-16db-8fd5-727a-edb6f71e1d47@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7WbKUZF3YQSAkg79kjs3h3qBzWNgRYVoZ"
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 24th Oct 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7WbKUZF3YQSAkg79kjs3h3qBzWNgRYVoZ
Content-Type: multipart/mixed; boundary="4fKKOccefn9K3fRQB8Ft3tcVmCbtf9blW";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <ed49e144-6981-53bb-be28-fa550b7d33d4@...515...>
Subject: Summary of the community meeting (Wed, 24th Oct 2018)
References: <39fa6e80-16db-8fd5-727a-edb6f71e1d47@...515...>
In-Reply-To: <39fa6e80-16db-8fd5-727a-edb6f71e1d47@...515...>

--4fKKOccefn9K3fRQB8Ft3tcVmCbtf9blW
Content-Type: multipart/mixed;
 boundary="------------542784AB2BA3A272ACF549CD"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------542784AB2BA3A272ACF549CD
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 24th October 2018
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2018-10-24>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

dazo, mattock, ordex, plaisthos and syzzer participated in this meeting.

--

Talked about adding Google Analytics on Trac. The request came from
OpenVPN Inc. webmaster. Mattock will send email about this to
openvpn-devel to gather feedback.

--

Talked about tls-crypt-v2. Ordex will review Steffan's patches one by
one next week.

--

Talked about the networking API patch. Plaisthos will review that one.
Ordex will review the block-ipv6 patch from ordex in return.

--

Talked about the MSI installer for OpenVPN and tap-windows6 that
rozmansi has been working on. It was noted that there are six patches on
the mailing list which have not been reviewed yet. Mattock will review
what he can and ask other (Windows) developers to participate in the
review process if possible.


--

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock




--------------542784AB2BA3A272ACF549CD
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-10-24.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-10-24.txt"

(12:16:55) L'argomento di #openvpn-meeting =C3=A8: Next meeting on 06/Jun=
/2018 at 11:30CEST. Agenda at https://community.openvpn.net/openvpn/wiki/=
Topics-2018-06-06
(12:16:55) L'argomento per #openvpn-meeting =C3=A8 stato impostato da ord=
ex!~linuxaro@...2309.../batman/ordex a 19:15:01 su 02/06/2018
(12:22:39) plaisthos: okay
(12:28:41) mattock: hi
(12:29:18) ordex: hi
(12:29:24) ordex: dazo: syzzer: ?
(12:31:10) dazo: Oh, I'm here
(12:31:58) ordex ha scelto come argomento: Next meeting on 24/Oct/2018 at=
 11:30CEST. Agenda at https://community.openvpn.net/openvpn/wiki/Topics-2=
018-10-24
(12:33:34) mattock: we have people, good
(12:34:00) mattock: do we have anyone who is not from openvpn inc? the go=
ogle analytics thing could need input from neutral parties
(12:34:43) ordex: cron2_ is in read-only mode and syzzer did not appear
(12:35:35) ordex: where do we start?
(12:35:40) ordex: 1) ?
(12:35:51) mattock: yeah let me see the agenda
(12:36:51) mattock: well, we can touch that topic but I don't think we ca=
n decide on anything about GA
(12:37:42) mattock: I think having Google Analytics on Trac would be reas=
onable, but I do see people could view it as a mild form of spying
(12:38:04) plaisthos: question is if anyone of us actually uses it
(12:38:22) mattock: use what?
(12:38:32) plaisthos: analytics on the community pages
(12:38:35) ordex: I have GA blocked everywhere because I do see it as a f=
orm of spying
(12:38:53) ordex: I would be more prone to use a hosted solution like piw=
ik (if it called this way)
(12:39:17) ordex: plaisthos: it would be used by our Inc. webmaster, in t=
heory
(12:39:37) ordex: (and by Google itself, of course :P)
(12:39:47) mattock: I think GA would actually get used, because the guy (=
webmaster) is only working our websites
(12:39:55) ordex: yap
(12:39:58) mattock: so he has time to actually go through the data
(12:40:46) ordex: maybe somebody should collect some feedback from other =
community users
(12:40:49) mattock: I'm not familiar with GA, but I suppose everything (o=
penvpn.net, community.openvpn.net, etc) needs to be there for the whole t=
o make sense
(12:41:12) mattock: I mean, understanding the route the user takes from o=
penvpn.net to community.openvpn.net or vice versa
(12:41:17) ordex: not necessarily, but of course it would help understand=
ing how people jump from one part to the other
(12:41:36) ordex: GA will still grab the URL that people used to reach op=
envpn.net
(12:41:58) mattock: I could just send email to openvpn-devel about this
(12:42:04) mattock: I'm sure we would get some responses
(12:42:18) ordex: I mean, if you consider c.ovpn.net as a separate websit=
e, it is no different from knowing that somebody reached ovpn.net from ..=
=2E. any other website
(12:42:26) ordex: yap
(12:42:28) mattock: yeah
(12:42:53) ordex: even though, when sending such email you have to state =
the goal
(12:42:56) mattock: so "mattock will send email to openvpn-devel about ad=
ding GA to community.openvpn.net"?
(12:42:58) mattock: yes, of course
(12:42:58) ordex: and ... what is the goal ?
(12:43:04) mattock: it's on the topic page
(12:44:17) ordex: I am just asking because yesterday we were actually dis=
cussing in #openvpn-devel that the c.ovpn.net website as a whole needs a =
big restructuring, therefore adding GA seems like something stepping on t=
he way, with no much gain
(12:44:24) ordex: anyway, send the email to openvpn-devel :)
(12:44:30) mattock: ok
(12:45:00) mattock: ordex: maybe create a wiki article with suggestions f=
or improving openvpn.net?
(12:45:10) mattock: that would enable community members to participate
(12:45:32) ordex: yup, that is what I suggested (even if i did not mentio=
n the wiki explicitly)
(12:45:37) ordex: but in the community nobody has time apparently
(12:45:37) ordex: :P
(12:45:43) ordex: but yeah, we should start that
(12:45:46) mattock: nobody is angry enough it seems
(12:45:49) mattock: :P
(12:46:10) mattock: actually, nobody has been angry about 2.3.18 being mi=
ssing from the download page, either
(12:46:16) ordex: I think people have lost faith (to my understanding) be=
cause no previous comment has been taken into account when designing the =
new website
(12:46:35) mattock: where were the comments directed to?
(12:46:36) ordex: mattock1: yes, the 2.3.18 missing link was the beginnin=
g of the discussion
(12:46:43) mattock: ok
(12:46:54) ordex: mattock1: you should not log out #openvpn-devel :-P
(12:46:56) plaisthos: ordex: yeah, the new website seems like it has comp=
letely lost focus to openvpn
(12:46:56) mattock: that can be added easily, but I wanted to see if some=
body would speak up
(12:47:11) plaisthos: (the community openvpn)
(12:47:23) mattock: ordex: I would love to stay logged in, but getting ZN=
C to co-operated with Pidgin _and_ Freenode's new authentication schema t=
urned out pretty horrible
(12:47:47) ordex: the other thing I heard was about the link to openvpn-g=
ui redirecting to sf.net, which is not updated since a bit
(12:47:47) mattock: I will retry setting up ZNC correctly "soonish"
(12:47:56) ordex: hehe :D I use znc+irssi
(12:48:09) ordex: anyway
(12:48:12) ordex: this is for another time
(12:48:14) mattock: well I would too, but I want to avoid having <n> chat=
 clients running
(12:48:16) mattock: yes
(12:48:27) ordex: let's start a wikipage and collect all comments there
(12:48:28) mattock: but let's compile a wiki page with "problems with the=
 new website"
(12:48:31) ordex: yap
(12:48:40) mattock: I have 25 mins roughly
(12:48:43) mattock: next topic
(12:48:45) mattock: :P
(12:48:50) mattock: tls-crypt-v2: status update=20
(12:48:51) ordex: #2 tls-crypt-v2
(12:49:09) mattock: this yours ordex?
(12:49:15) ordex: the latest patchset that Steffan sent to the mailing li=
st should be the final one. Next week I will go through the patches and a=
ck them one by one
(12:49:16) ordex: yap
(12:49:30) dazo: sorry got disrupted .... Google Analytics is blocked in =
all my browsers, as well as a boatload of other trackers
(12:49:49) dazo: I understand the usefulness of such things ... but I do =
not like them at all.
(12:50:09) ordex: same here - however it was proposed to move the discuss=
ion to the ml to gather more "community" feedback
(12:50:23) ordex: then we can throw the ball at Inc. and they can decide
(12:50:30) dazo: yeah
(12:50:51) ordex: about tls-crypt-v2 that's all too. I just wanted to get=
 people ready for "merging" because this might be the final round
(12:51:02) mattock: #3 networking API patch: status update=20
(12:51:09) ordex: plaisthos:=20
(12:51:10) ordex: ^
(12:51:23) plaisthos: will look into it soon=20
(12:51:36) ordex: ok, if there is anything I can do, let me know
(12:51:38) plaisthos: ordex: you also have patches waiting from me to rev=
iew :P
(12:51:55) ordex: which ones exactly? my queue is looooong
(12:52:10) plaisthos: block-ipv6 for example :P
(12:52:15) ordex: yeah
(12:52:16) ordex: good one
(12:52:29) ordex: assigning to me on pw
(12:52:35) ordex: otherwise I won't see it any time soon
(12:53:17) ordex: ok, so networking API is WIP
(12:53:40) ordex: #4 OpenVPN 2.5
(12:54:09) ordex: plaisthos: what do you need for asym compression to get=
 going? just review?
(12:54:27) plaisthos: yeah, allow-compression patch should be fine
(12:54:32) ordex: plaisthos: is it *only* this patch: [Openvpn-devel,v2] =
Make compression asymmetric by default and add warnings  ?
(12:55:42) ordex: ?
(12:55:45) plaisthos: ordex: let me double check for style and then yes
(12:55:49) ordex: oky
(12:55:59) dazo: But we discussed this patch in Lviv ... and we wanted to=
 slim it down a bit in regards to the arguments, or?
(12:56:35) plaisthos: dazo: well I convinced you that yes/no/asym is okay=
 since it matches openvpn3
(12:56:49) dazo: ahh ... but it should not be pushable
(12:56:59) dazo: that was the other aspect, which we discussed with Johan=

(12:57:28) plaisthos: I still disagree a bit on that but I don't care eno=
ugh anymore to fight that ;)
(12:57:42) dazo: "The current patch will be updated to not allow this new=
 option to be pushable." .... https://community.openvpn.net/openvpn/wiki/=
LvivHackathon2018
(12:57:43) vpnHelper: Title: LvivHackathon2018 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:58:04) ordex: but allow-compression is checked with:
(12:58:04) ordex: +        VERIFY_PERMISSION(OPT_P_COMP);
(12:58:07) ordex: is this pushable ?
(12:58:10) plaisthos: yes
(12:58:26) plaisthos: Seems I have not send out the v3
(12:58:37) plaisthos: in my branch it already has OPT_P_GENERAL
(12:58:49) ordex: rebase and send then :)
(12:58:59) ordex: I'll mark v2 as rejected in pw
(12:59:11) ordex: doing now
(12:59:33) mattock: sorry, child-related distraction
(13:00:07) ordex: np
(13:00:16) ordex: so plaisthos will send v3 of his asym patch
(13:00:24) ordex: then we can review
(13:00:32) ordex: mattock1: " migrate from NSIS to MSI installer " any pr=
ogress on that ?
(13:00:50) mattock: not on my side, but have Simon's patches been merged?=

(13:00:55) mattock: he sent a few to openvpn-devel
(13:01:12) mattock: directly/indirectly related to his MSI work
(13:01:57) mattock: I see a set of five patch plus one individual patch
(13:02:05) ordex: who's expected to review those ?
(13:02:33) mattock: hmm
(13:02:40) mattock: we could ask Selva or Lev
(13:02:43) dazo: lev__, selva and mattock1 I'd say :)  (depending on whic=
h parts it is changed)
(13:02:59) mattock: I can have a look, but I won't be able to review the =
actual code anyways
(13:03:05) mattock: (need to split in 5)
(13:03:13) ordex: we can definitely try to involve lev__ , if he likes th=
e idea
(13:03:36) dazo: probably not :-P
(13:03:41) ordex: :D
(13:04:26) ordex: other than that, for 2.5 we have netlink (already discu=
ssed), VLAN (moving on), multi-port (waiting for review)
(13:04:39) dazo: struct argv ready for review
(13:05:01) ordex: oh, the table needs to be updated then
(13:05:23) dazo: ahh, I've forgotten that :/
(13:05:35) mattock: I'll put the wheels on MSI review in motion
(13:05:56) ordex: updating it now
(13:06:20) ordex: ok
(13:06:22) mattock: later today...
(13:06:38) mattock: anything else on 2.5?
(13:06:39) ordex: I guess we have a lot things out there that needs revie=
w, as usual :)
(13:06:52) ordex: mattock1: not really, I think
(13:06:52) mattock: yeah
(13:07:02) mattock: we rarely get to "review patches on patchwork" part
(13:07:19) mattock: _if_ we had weekly meetings then maybe we would end u=
p in there
(13:07:36) plaisthos: btw. do I still support non existing client backwar=
ds compatible in my managed interface
(13:08:26) ordex: your managed interface ?
(13:08:37) plaisthos: +patch
(13:09:07) ***syzzer present too now :)
(13:09:22) ordex: syzzer is just on time for the beer !
(13:09:25) ordex: :D
(13:09:29) syzzer: not much to add to the earlier discussion though
(13:11:22) mattock: meeting concluded?
(13:11:54) syzzer: perfect :D
(13:12:03) dazo: :)
(13:12:15) mattock: I take that as a yes :D
(13:12:42) mattock: I will send the summary later today, start review of =
the MSI patches so that people wake up, contact selva and others who may =
be able to review the MSI patches from Simon
(13:12:53) mattock: now I need to split so that I'm not late from lunch a=
ppointment

--------------542784AB2BA3A272ACF549CD--

--4fKKOccefn9K3fRQB8Ft3tcVmCbtf9blW--

--7WbKUZF3YQSAkg79kjs3h3qBzWNgRYVoZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlvQV7AACgkQKVhNn0CG
RXjPHAgApwYDRR+URBrd7z/RFsDF3EV7eRCxw006nTrYLg9qqDI7znL6u7B1R0r0
SUfmWWFyU502hmCdkIu5YHykVM64MdOJgikTVq+aIj/JNbSs4zuuAr9+CQOqf7jM
Oq/YIzqCc74k5ZUbbaGc8vaPhnZb2yw4ifZmzApQV+hVnr6aV0+d+R4jhZbzAJ70
ulUO3qgEjU8mJjwQ57EkmjMtv1W2syDArkP8HwFweT/9KDVXhghGvgXTTVSP3vbB
ZdxINm3EV4juv6J6dy9IvqhukjkiMGEdOmDP4vw4O5PMALHVtsV0VbFP0jJqLqW3
iqu2bMeDFQxJ57wFpIUHLPV5srAmRA==
=z1h3
-----END PGP SIGNATURE-----

--7WbKUZF3YQSAkg79kjs3h3qBzWNgRYVoZ--

