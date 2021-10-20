From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <74e6c803-a525-b738-6524-92354e5e9f14@...515...>
Message-ID: <bb88fc1e-89e1-9e1e-f190-cd8186a61387@...515...>
Date: Wed, 20 Oct 2021 16:51:01 +0300
MIME-Version: 1.0
In-Reply-To: <74e6c803-a525-b738-6524-92354e5e9f14@...515...>
Content-Type: multipart/mixed; boundary="------------50BC1FFA7824500EDB6F6C03"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (20th October 2021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------50BC1FFA7824500EDB6F6C03
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on libera.chat
Date: Wed 20th October 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-10-20>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, d12fk, lev, mattock, MaxF, nariman, novaflash, plaisthos 
and rob0 participated in this meeting.

---

Noted that there are about fifty openvpn_inc tickets in Trac that should 
be cleaned up.

---

Talked about OpenVPN 2.5.4 I604 Windows installers. Mattock copied them 
to build.openvpn.in, cron2 tested arm64 version and lev will test amd64. 
If all is good mattock will push out this new installer release.

---

Talked about hackathon. COVID-19 situation in Munich seems reasonable so 
we should be able to make it happen.

---

Talked about hackathon T-shirt design. Agreed that we can give fairly 
free hands for the designed, with "OpenVPN 2021 hackathon in Munich at 
QAware" as guidance. Mattock will ask a couple of design we can choose 
from. Cron2 will get the T-shirts printed in Munich to cut off the 
shipping time.

Those hackathon participants who want a T-shirt should add their size to 
the Hackathon attendee table in Trac:

<https://community.openvpn.net/openvpn/wiki/Hackathon2021>

---

Talked about the OpenSSL patch flood. Noted that ordex is on paternal 
leave and hence unable to ACK those. Agreed that ACKs and NACKs from 
MaxF are good, because he has to live with the results.

-- 

Full chatlog attached

--------------50BC1FFA7824500EDB6F6C03
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-10-20.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-10-20.txt"

(14:59:52) plaisthos: moin
(14:59:55) mattock: hi
(15:01:08) novaflash [~novaflash@...2592...] =C3=A8 e=
ntrato nella stanza.
(15:02:34) cron2: so, good afternoon, gentlemen
(15:02:45) novaflash: hallo
(15:03:43) cron2: ah, the openvpn_inc guy :-)
(15:05:12) cron2: shall we start?
(15:05:19) d12fk: aint we all inc guys?! =3D)
(15:05:39) plaisthos: d12fk: there is a openvpn_inc account that novaflas=
h manages
(15:05:43) cron2: d12fk: be careful what you are asking for :-) - this is=
 the user account that gets to clean up Corp tickets from trac...
(15:05:53) mattock: yes
(15:06:09) lev__: Hello
(15:06:22) nariman: hi=20
(15:06:25) MaxF [~MaxF@...2624...] =C3=A8 entra=
to nella stanza.
(15:06:30) mattock: let me check the status of windows installer build
(15:06:39) d12fk: cron2: how do I delete things from IRC? =3D)
(15:06:40) mattock: build was successful
(15:06:47) mattock: 2.5.4-I604
(15:06:48) novaflash: the openvpn_inc account is shared across company pe=
eps - rob0 for example uses it
(15:06:54) rob0: yup
(15:07:14) novaflash: cron2: and yes we are terribly slow at cleaning up =
trac tickets but it's being processed slowly
(15:07:45) cron2: thanks
(15:07:48) dazo: so .... we're slow because we're slow? :-P
(15:08:12) cron2: I just noticed because I had a cleaning spree yesterday=
, looking at the most recent 50-ish tickets, and noticed quite a few "ope=
nvpn_inc" ones...
(15:08:35) Pippin_ [Pippin_@...1423.../community/Pippin] =C3=A8 entrato nell=
a stanza.
(15:08:44) cron2: now, the *rest* of "the openvpn community" (with a few =
notable exceptions) was even less active...
(15:08:47) lev__: mattock: do we use OpenSSL 1.1.1l with the latest insta=
ller?
(15:08:56) cron2: lev__: thanks. I forgot.
(15:09:06) cron2: (that was one of those tickets)
(15:09:56) mattock: lev: not sure, but openssl port gets updated
(15:10:12) mattock: I will scp over the MSI so that somebody can test
(15:11:02) cron2: lev__: ah, that might have been due to 2.5 still buildi=
ng with the "local openssl build" thingie
(15:11:12) lev__: Oh right
(15:13:00) mattock: copying
(15:14:14) cron2: nice, so we already covered two agenda items (trac hygi=
ene and 2.5.4 I604 re-release) :-)
(15:14:52) mattock: lev: https://build.openvpn.net/downloads/releases/Ope=
nVPN-2.5.4-I604-amd64.msi
(15:14:57) mattock: if you happen to have time to test it
(15:15:20) lev__: I will test Soininen
(15:15:25) lev__: Soonish
(15:17:09) mattock: testing Soini[nen] is also welcome
(15:17:30) mattock: if the installer works ok I will release it this even=
ing
(15:18:45) mattock: I have an update on buildbot
(15:18:48) lev__: And if it doesn=E2=80=99t?
(15:18:52) mattock: then we do something
(15:18:53) mattock: :)
(15:19:16) dazo: do $magic
(15:19:19) cron2: testing arm64
(15:19:20) mattock: yep
(15:19:21) cron2: 1.1.1l
(15:19:21) cron2: good
(15:19:28) mattock: so the build is working well
(15:19:32) mattock: updates deps etc.
(15:20:12) mattock: as for buildbot: we're getting closer to being able t=
o start migrating and upgrading the community services, buildbot included=

(15:20:34) mattock: the new services will live in a fresh environment
(15:20:59) mattock: most of the work has been fighting policies and lack =
of policies
(15:21:08) mattock: technically it is not such a big deal
(15:23:07) cron2: so arm64 passed a few basic connects, tcp/udp, password=

(15:24:34) mattock: \o/
(15:26:30) d12fk: hackathon then?
(15:28:14) cron2: nothing new from my end.  Anything on your side?
(15:28:47) d12fk: no, situation seems to be managable in .de and also in =
muc
(15:28:53) d12fk: *covid
(15:28:56) cron2: yeah
(15:29:10) cron2: numbers are not perfect, but not catastrophic either
(15:29:39) lev__: amd64 seems to work (connected to corp vpn using wintun=
)
(15:29:41) novaflash: so far from what i can gather i don't have to do an=
ything special when travelling from netherlands to germany. just have a d=
eclaration of health and my QR codes for vaccination.
(15:29:48) mattock: I'm able to book the flights now that I paid the cred=
it card bill from my Creta trip :D
(15:30:19) d12fk: I think I had spotted the netherlands on the high risk =
countrys list
(15:30:44) novaflash: hm i looked at information online yesterday and it =
said netherlands was not high risk
(15:31:06) d12fk: okay it changes often, last time I checked was a week a=
go or so
(15:31:21) dazo: maybe we should just reschedule and meet inside the airp=
ort and find some available spots close to the gates ....
(15:31:38) mattock: :)
(15:31:51) rob0: haha
(15:32:04) d12fk: dazo: close to gates?! who are you and what have you do=
ne to david?
(15:32:26) ***dazo tries to hide .....
(15:33:17) novaflash: "Nederland is voor Duitsland geen coronarisicogebie=
d. Als u de afgelopen 10 dagen alleen in Nederland was, dan hoeft u zich =
niet v=C3=B3=C3=B3r vertrek te registreren en hoeft u bij aankomst ook ni=
et in thuisquarantaine."
(15:33:18) rob0: it's that chip he got in his vaccine
(15:33:33) novaflash: that's dutch gobbledegook for "dutchie no problemo"=

(15:34:36) cron2: just don't try to bring any smoke things... bavaria has=
 no sense of humor
(15:35:01) d12fk: novaflash: now I remember correctly, it was the ex-colo=
nies overseas which were listed
(15:35:12) novaflash: ah.. yeah that makes sense
(15:35:16) dazo: :-D
(15:35:18) novaflash: but they're like way out there
(15:35:24) mattock: d12fk: you mean New York?
(15:35:29) novaflash: there's not much risk of my being there accidentall=
y
(15:35:51) rob0: How many Bavarians does it take to change a light bulb? =
 One.  Bavarians are hard working and efficient, and they have no need fo=
r silly jokes.
(15:36:11) novaflash: is that a joke? jokes are not allowed in Germany. i=
n Germany, we do not laugh.
(15:36:23) cron2: nah, that won't work... we are busy drinking beer, we h=
ave no time for jokes...
(15:37:02) mattock: I get the sense that there are few if any real topics=
 left
(15:37:09) novaflash: what's the status on t-shirts?
(15:37:11) cron2: well
(15:37:13) novaflash: the most important topic
(15:37:13) cron2: that!
(15:37:24) mattock: German sense of humour?
(15:37:29) mattock: oh
(15:37:29) cron2: T-Shirts
(15:37:30) novaflash: because i was in a meeting with my colleague today =
and he was wearing a sophos t-shirt still
(15:37:30) mattock: of course
(15:37:35) mattock: what design?
(15:37:44) novaflash: and that was totally unacceptable so we need to bur=
y him in openvpn t-shirts now
(15:37:46) mattock: we need to discuss design or let the designer have fr=
ee hands there
(15:38:09) d12fk: novaflash: don't forget the ovpn socks
(15:38:18) mattock: I will tell the designed "do your worst" if you have =
no opinions
(15:38:21) cron2: I'd like to see the date/city table on the back side ag=
ain, and something nice on the front
(15:38:24) novaflash: we're a little short on time, so probably we should=
 just let the designer put something together ASAP and we can give it a y=
ay or nay?
(15:38:29) cron2: yep
(15:38:50) novaflash: (designer literally puts the text "something nice" =
on the front)
(15:39:14) cron2: he can come up with 2-3 variants as well... like a bava=
rian one with a beer stein + qaware logo, or just "PenVPN" (classic)
(15:39:23) mattock: second question: is cron2 able to have the T-shirts p=
rinted locally in Munich?
(15:39:39) dazo: novaflash: he knows it's about openvpn ... so probably e=
nd up with something like "something is nice with OpenVPN"
(15:39:49) cron2: I should be able to get that done
(15:39:52) mattock: ok
(15:39:56) cron2: if I have something by monday
(15:39:57) mattock: saves shipping time
(15:39:59) mattock: ok
(15:40:00) novaflash: OpenVPN. It's nice. (c)
(15:40:20) mattock: would it be ok to have Qaware logo in there in every =
shirt to keep things simple?
(15:40:40) mattock: plus we need sizes
(15:40:43) cron2: works for me - "munich, qaware, 2021" - this is "this p=
articular hackathon"
(15:40:56) novaflash: XL, i'm a big boy
(15:41:04) cron2: please put those in the wiki
(15:41:11) novaflash: ok
(15:41:41) mattock: yes, all please share your body size in Trac
(15:42:00) mattock: cron2: do you have a link to Qaware site?
(15:42:03) cron2: qaware.de
(15:42:08) mattock: we may need a high-quality logo from them as well
(15:42:15) novaflash: i added a t-shirt size column to our 'who is coming=
' thing
(15:42:27) novaflash: seemed easiest place to put it
(15:42:32) mattock: +1
(15:42:32) cron2: +1
(15:42:54) mattock: cron2: could ask for a proper logo from Qaware?
(15:43:04) mattock: the one on the website seems tiny and won't print wel=
l
(15:45:24) mattock: btw. https://community.openvpn.net/openvpn/wiki/Hacka=
thon2021
(15:45:31) mattock: not linked to from the front page of Trac
(15:45:32) cron2: mailed
(15:45:57) rob0: I think there is a vector graphic of the keyhole logo, s=
omewhere.
(15:47:51) cron2: this said - I need to leave in 10 minutes.  Anything el=
se on the Hackathon?
(15:47:57) mattock: not from my end
(15:48:02) novaflash: yes what snacks will people bring
(15:48:07) mattock: rob0: you mean the (O)penVPN logo?
(15:48:10) mattock: I have such a thing
(15:48:15) rob0: yes, ok
(15:48:21) novaflash: i will be bringing stroopwafels i think
(15:48:21) cron2: novaflash: Bretzels, and Weisswurst (if you want)
(15:48:32) novaflash: mmm food
(15:49:34) mattock: chocolate probably, as usual
(15:49:39) cron2: so who takes responsibility for the designer pushing?
(15:50:03) mattock: me
(15:50:18) mattock: OpenVPN hackathon 2021, space provider by QAware
(15:50:34) mattock: couple of suggestions and we choose
(15:50:37) cron2: +1
(15:51:10) plaisthos: cron2: you want to probably also ask qaware if they=
 also want shirts and if yes what sizes
(15:51:29) cron2: I did, but that side thread got a bit stuck
(15:51:40) plaisthos: ah okay
(15:52:02) cron2: oh the 2.6 front... we could use some help with the Ope=
nSSL 3.0.0 patch flood...
(15:52:23) cron2: most of the "non crypto" patches in that patchset are e=
asy enough, but I do not know enough about OpenSSL to do the rest
(15:53:06) novaflash: it's too bad ordex is on paternity leave
(15:54:39) mattock: cron2: also bring the pate thing you can put on top o=
f bretzels
(15:54:42) mattock: ober something
(15:55:48) d12fk: obatzder? cheesy thingie?
(15:55:50) mattock: yes
(15:55:53) mattock: obatzder
(15:55:53) MaxF: I've been looking at some of the OpenSSL patches. Don't =
know if an ACK from me is good enough, though...
(15:56:28) MaxF: I'm also not that deep into OpenSSL, so I don't know if =
I can ACK all of them
(15:56:34) cron2: MaxF: for me, it's good enough ("you and foxit will hav=
e to live with the result if I merge it") :-)
(15:56:50) cron2: NAKs are even more interesting :-)
(15:57:24) cron2: I'm off, and hope for IPv6 to community in the meantime=
 :-)
(15:57:50) mattock: ok, let's conclude the thing
(15:58:08) d12fk: hope dies last (German proverb)
(15:58:18) novaflash ha abbandonato la stanza (quit: Quit: stroopwafels).=

(15:59:37) mattock: "Everything is shit, except pee" (FInnish proverb)
(16:00:03) mattock: we're not as philosophical as the Germans
(16:00:22) d12fk: I like it, though
(16:00:27) mattock: it is true as well
(16:00:28) mattock: :D
(16:00:40) mattock: that's a typical finnish pessimistic saying (modern o=
ne, but still)
(16:01:02) MaxF: don't praise the day before the evening
(16:01:08) d12fk: I bet it sounds cool in Finnish
(16:01:23) mattock: "Kaikki on paskaa paitsi kusi"
(16:12:16) d12fk: so innocent =3D)

--------------50BC1FFA7824500EDB6F6C03--

