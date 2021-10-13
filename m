From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <74e6c803-a525-b738-6524-92354e5e9f14@...515...>
Message-ID: <dc3031b0-36d8-18c4-a903-57e1235bbfa0@...515...>
Date: Wed, 13 Oct 2021 16:25:33 +0300
MIME-Version: 1.0
In-Reply-To: <74e6c803-a525-b738-6524-92354e5e9f14@...515...>
Content-Type: multipart/mixed; boundary="------------DD26EBBF180812455E21434A"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (13th October 2021)
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
--------------DD26EBBF180812455E21434A
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on libera.chat
Date: Wed 13th October 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-10-13>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, d12fk, janjust, lev, mattock, MaxF, novaflash, plaisthos and rob0 
  participated in this meeting.

---

Talked about hackathon, in particular swag and T-shirts. The official 
OpenVPN swag shop is in here:

<https://openvpn-inc.myshopify.com/>

Agreed that Qaware who will kindly host the meeting in Munich should get 
some nice swag for their efforts. It was agreed that hackathon T-shirts 
with "Qaware" logos in the would be a nice gesture. For the rest of the 
crowd plain hackathon T-shirts would suffice.

Mattock will make inquiries to locate a designer at OpenVPN Inc. who 
could design the shirts. The shirts can then be shipped to Munich to 
cron2, or printed there, and then given to the hackathon participants. 
OpenVPN Inc. should be able to sponsor the T-shirts.

---

Noted that OpenVPN 2.5.4 broke version numbering in Windows (2.5..4 
instead of 2.5.4). Lev is investigating this problem. Fortunately this 
does not seem to cause any major issues to people right now.

---

Noted that Windows 11 seems to break OpenVPN 2.5.* *and* Connect for 
some people, which is a bit weird. This hints more at "some security 
product getting in the way". There are no "verb 5" logs yet, but the 
errors were UDP write errors. The problems may be related to this:

<https://docs.microsoft.com/en-us/windows/release-health/status-windows-11-21h2?irgwc=1&OCID=AID2200057_aff_7593_1243925&tduid=%28ir__llr3ag6gwokf6whl2qniaboutn2xrby1yzxmvckl00%29%287593%29%281243925%29%28kXQk6.ivFEQ-5Ed9DpkQKDrNHmn7beYbpg%29%28%29&irclickid=_llr3ag6gwokf6whl2qniaboutn2xrby1yzxmvckl00#1704msgdesc?ranMID=24542&ranEAID=kXQk6*ivFEQ&ranSiteID=kXQk6.ivFEQ-5Ed9DpkQKDrNHmn7beYbpg&epi=kXQk6.i>

---

Agreed that it is reasonable to add a "tls-cert-profile insecure" to 
allow setting OpenSSL security profile to 0 for better compatibility 
with "old crap":

<https://www.openssl.org/docs/man3.0/man3/SSL_CTX_set_security_level.html>

Plaisthos will send a patch.

---

Agreed that splitting off buildbot from openvpn-vagrant to 
openvpn-buildbot is fine. It has grown too big to "fit in" already.

-- 

Full chatlog attached

--------------DD26EBBF180812455E21434A
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-10-13.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-10-13.txt"

(14:55:28) cron2 ha scelto come argomento: https://community.openvpn.net/=
openvpn/wiki/Topics-2021-10-13
(15:01:31) rob0: 2021-10-13 12:00 UTC is one minute ago!
(15:01:53) ***cron2 yawns
(15:01:59) mattock_: hi
(15:02:00) cron2: hullo, good people!
(15:03:38) d457k: rob0: so you are one minute late ;-)
(15:03:43) d457k =C3=A8 ora conosciuto come d12fk
(15:04:15) MaxF [~MaxF@...2624...] =C3=A8 entra=
to nella stanza.
(15:04:19) MaxF: hi!
(15:04:29) cron2: d12fk is randomizing nicks again, for better IRC securi=
ty
(15:04:44) plaisthos: hehe
(15:04:45) lev__: hello
(15:04:51) plaisthos: hello everybody
(15:04:58) plaisthos: I added a topic to the agenda
(15:05:02) d12fk: the beefy comments come from "someone" else
(15:06:03) mattock_: let's start
(15:06:11) cron2: $nick =3D substr(sha256(mood,time),8)... :-)
(15:06:23) mattock_: hackathon
(15:06:27) cron2: yes!
(15:07:19) plaisthos: yes
(15:07:20) cron2: I've checked with qaware again, and they are still happ=
y with us coming (and it's still okay with covid requirements)
(15:07:43) cron2: plaisthos has established contacts and will be there to=
 shake hands and receive key cards on tuesday morning
(15:07:47) cron2: (thanks)
(15:08:00) cron2: so for all corp people -> talk to plaisthos :-)
(15:08:10) cron2: I will show up Friday morning
(15:08:19) cron2: so for all non-corp people -> talk to me or plaisthos ;=
-)
(15:09:23) cron2: anything else?
(15:09:41) plaisthos: mattock_: are you getting some merch/goodies for qa=
ware?
(15:09:50) plaisthos: or let our marketing people do that?
(15:10:00) cron2: oh yes please, and t-shirts
(15:10:05) MaxF: how do we talk to you or plaisthos? phone?
(15:10:11) janjust [~janjust@...2636...] =C3=A8 entrato nella sta=
nza.
(15:10:18) cron2: phowat
(15:10:21) janjust: hey folks
(15:10:33) cron2: MaxF: will update web site with phone number
(15:10:41) d12fk: jjk! hi
(15:11:17) d12fk: beer outings at night are not a problem, are they?
(15:11:24) janjust: hi d12fk, long time no see. Just wanted to let you al=
l know that I still intend to come to Munchen
(15:12:04) mattock_: plaisthos: no, I don't have access to any merchandiz=
e :)
(15:12:23) mattock_: if we want such a thing maybe we could ship it to cr=
on2 before the hackathon?
(15:12:33) mattock_: that said, I recall our web shop only ships to the U=
S
(15:12:41) plaisthos: MaxF: I will send you my phone in private query
(15:12:45) d12fk: janjust: cool, see you there then
(15:12:46) mattock_: so we'd need to ask somebody (Julie?) to do the ship=
ment
(15:13:37) cron2: MaxF: I have put my contact data on the hackathon page
(15:13:49) cron2: (and corp people have plaisthos' data anyway, I assume)=

(15:14:04) plaisthos: yeah and they have slack to annoy me
(15:14:25) ***cron2 has slack, teams, mattermost, jabber these days, for =
"talk to customer"...
(15:14:34) cron2: yes, very annoying
(15:14:56) janjust: cron2, no keybase ;) ?
(15:15:04) plaisthos: cron2 has left email and phone behind :D
(15:15:48) cron2: janjust: nah, and none of the other 473 messengers that=
 people like to use...  (I do have whatsapp and signal, indeed)
(15:17:40) rob0: we really do need more swag, and perhaps a better suppli=
er; the stickers are crazy expensive.
(15:18:21) mattock_: the instant messenger hell keep getting worse and wo=
rse
(15:18:29) mattock_: I have about 15 places I need to track nowadays
(15:18:36) mattock_: which means I track none, really
(15:19:05) plaisthos: anyway, should we leave the ranting about IM behind=
?
(15:19:07) mattock_: yes
(15:19:12) mattock_: we should decide on the swag
(15:19:27) janjust: hehe swag is way more important than rants ;)
(15:19:37) plaisthos: mattock_: yes, we want!
(15:19:38) mattock_: so, swag for Qaware, right?
(15:19:40) cron2: those geeks I have met when first on-site were typical =
geeks, so "T-Shirt, black, XL" would be something appreciated
(15:19:55) mattock_: what we could do is externalize that work
(15:20:04) mattock_: in the past I received a coupon to our webshop
(15:20:06) plaisthos: and if you can get some supplier that offers soemth=
ing like powerbanks/stickers/notebooks that would be really cool
(15:20:14) plaisthos: mattock_: I think corp will pay that
(15:20:17) mattock_: then a kind person at OpenVPN sent me what I wanted =
(because they only ship to the US)
(15:20:33) plaisthos: I managed to get it directly delivered to me=20
(15:20:40) mattock_: yes
(15:20:46) mattock_: so from the webshop?
(15:20:48) mattock_: directly
(15:20:50) cron2: you can have stuff shipped to me and I'll hand it to Ar=
ne on Monday
(15:21:06) cron2: (so it is there on Tuesday)
(15:21:51) plaisthos: yes
(15:22:22) mattock_: was that "yes" an answer to my question?
(15:22:35) plaisthos: yes
(15:22:38) mattock_: :)
(15:22:41) plaisthos: I got it direclty from the webshop
(15:22:43) mattock_: ok, then what I propose is this
(15:23:32) mattock_: - I figure out who at OpenVPN is responsible for the=
 swag
(15:23:32) mattock_: - I ask for $100(?) worth of credit to the webshop
(15:23:32) mattock_: - cron2 orders from the webshop using the coupon
(15:23:45) mattock_: whatever he things suits the QAware guys bset
(15:23:45) plaisthos: maybe more=20
(15:23:46) mattock_: best
(15:23:53) mattock_: money is unlikely to be a problem
(15:23:57) mattock_: $200
(15:23:59) mattock_: ?
(15:25:47) cron2: do we have hackathon t-shirts already?
(15:26:15) plaisthos: mattock_: maybe get an estimate of number of t-shit=
rts, etc, click that together in the web shop and then ask for that amoun=
t
(15:30:01) d12fk: where is the shop?
(15:30:24) mattock_: I have no clue where the shop is anymore
(15:30:59) cron2: was that an "openvpn corp" webshop?
(15:31:09) mattock_: cron2: yes
(15:31:27) mattock_: does anyone have the URL for the webshop at hand?
(15:31:28) cron2: interesting :-) - someone would need to put up a hackat=
hon t-shirt design, though
(15:31:31) mattock_: it seems difficult to find
(15:33:14) mattock_: asked about it in the company-wide chatroom
(15:33:20) mattock_: maybe somebody knows where it is :D
(15:33:41) cron2: mattock_: so can you do the T-Shirt design for the webs=
hop, then?  (If it can be found)
(15:33:49) mattock_: no
(15:33:51) mattock_: I won't
(15:33:51) ***cron2 has no clue about t-shirt design
(15:34:02) mattock_: somebody took that "privilege" away from me, and I'm=
 glad!
(15:34:02) mattock_: :D
(15:34:09) mattock_: I will make some inquiries
(15:34:36) mattock_: the hackathon T-shirt thing is probably a completely=
 different beast than the webshop=20
(15:34:57) cron2: but this is the interesting part
(15:35:01) mattock_: swag we can "just buy", but hackathon stuff needs to=
 be designed, ordered and shipped separately
(15:35:12) lev__: https://openvpn-inc.myshopify.com/
(15:35:32) cron2: and stuff we can "just buy" is much less interesting...=

(15:35:49) mattock_: lev: thanks!
(15:36:06) novaflash [~novaflash@...2592...] =C3=A8 e=
ntrato nella stanza.
(15:36:18) cron2: so who did the last T-Shirts?
(15:36:19) rob0: I have the shop link, hold on
(15:36:29) mattock_: rob0: it is already there
(15:36:30) rob0: oh, nm, so did lev :)
(15:36:30) mattock_: up
(15:37:44) rob0: shhh novaflash is here, everyone, look busy!
(15:37:47) lev__: I remember I got "We don=E2=80=99t offer shipping to Fi=
nland" at first, but then it turns out they forgot to add Finland to the =
"allowed" list of countries=20
(15:37:57) novaflash: too late, i already got a screenshot of your idle s=
tatus
(15:38:31) janjust: I forget who novaflash is...
(15:38:36) rob0: ha, got you there.  My shift starts on the [next] hour.
(15:39:07) novaflash: that's okay mister keijser, i am getting so old i s=
tart to forget who i am myself too sometimes
(15:39:18) mattock_: you've lost yourself already
(15:39:20) mattock_: anyhow
(15:39:49) novaflash: but if it helps, i was at the fox-it hackathon in d=
elft and you gave me a lift in your car to the city center
(15:40:01) mattock_: cron2: would be kind enough to check the webshop for=
 stuff that might interest Qaware, shove them in the basket and check the=
 cost?
(15:40:05) janjust: lol and you expect me to remember *THAT* ?
(15:40:12) mattock_: then I can ask for that amount of money
(15:40:22) novaflash: of course, such interactions with me should be high=
ly memorable
(15:40:47) plaisthos: janjust: it is a guy from strange country that you =
too familar with ;)
(15:40:59) cron2: mattock_: I think some of the baseball caps and sticker=
s might be interesting, but this is sort of ... anonymous.  A hackathon T=
-Shirt with qaware logo on it, that would be the thing.
(15:40:59) janjust: lol novaflash, I guess I have suppressed the memory=20
(15:41:12) novaflash: understandable ;-) =20
(15:41:38) mattock_: cron2: are you implying that all hackathon T-shirts =
would have the Qaware logo, or just those aimed at Qaware?
(15:42:33) cron2: we could do either (all without, some with and some wit=
hout, all with).  A hackathon T-Shirt in itself is already "something spe=
cial you can't just buy in the shop"
(15:42:45) mattock_: agreed to the last point
(15:43:05) mattock_: in that case we should focus on getting the T-shirt =
designed to work
(15:43:14) mattock_: designer
(15:43:21) cron2: +1
(15:43:21) mattock_: the first step is to locate that person
(15:43:27) janjust: mattock_, who created the previous shirts? =20
(15:45:00) novaflash: "your honor, i refuse to answer that question, as i=
t may serve to incriminate me" i think is the right answer here
(15:45:17) mattock_: janjust: I wish I remembered
(15:45:22) janjust: "I take the fifth" ?
(15:45:30) mattock_: I may have to ask on the company-wide chat=20
(15:45:33) cron2: so novaflash was the one? :)
(15:45:46) janjust: sounds like it, doesn't it
(15:45:54) rob0: ^^ on this side of the pond, it's the fifth; over there =
isn't it 750 ml?
(15:46:26) janjust: rob0 is in the us, I take it?
(15:46:38) novaflash: i meant mattock actually, but, if you want me to de=
sign it, you should be aware that i have a... uh...history in t-shirt des=
igns that may not be entirely....appropriate
(15:46:59) cron2: now that sounds like really something special
(15:47:31) novaflash: all jokes aside, we do actually have designers in t=
he company, maybe we could use that resource. maybe. i dunno. time is a l=
ittle short though.
(15:47:59) rob0: haha I wish I could go.  Not that I could contribute any=
thing, but a "not entirely appropriate" T shirt would be cool
(15:48:01) plaisthos: novaflash: can you hit them up and ask?
(15:48:01) cron2: it would be good to have a clear answer before end of t=
his week...
(15:48:13) mattock_: novaflash: I already asked "who is capable of doing =
this"
(15:48:27) mattock_: let's see if the responsible person is silly enough =
to answer my query
(15:48:27) plaisthos: cron2: should we ask if qware wants/likes to their =
logo on the shirt too?
(15:48:32) cron2: if it does not work out, I might volunteer my wife... b=
ut then you need all go and wear the pink/purple shirts...
(15:48:35) novaflash: mattock_: oh. okay.=20
(15:48:43) mattock_: pink/purple would be ok
(15:48:46) janjust: I've created a t shirt design twice, but that was mos=
tly placing a logo and text somewhere on the front
(15:48:48) plaisthos: cron2: I am only with pink/purple
(15:48:52) mattock_: it would be good for trolling, if nothing else
(15:48:55) novaflash: cron2: i would wear the shit out of the pink/purple=

(15:48:59) rob0: surely you can get a local Munchen shop to print shirts
(15:49:00) plaisthos: but then again I have colour blindness/weakness
(15:49:09) janjust: cron2: only if it is BRIGHT pink, the glow-in-the-dar=
k kind
(15:49:19) mattock_: +1
(15:49:25) cron2: janjust: I'll relay that :-)
(15:49:36) novaflash: great. so not only will the text on the shirt make =
us look gay, the colours will too.
(15:49:51) janjust: the kind of pink you want to wear because if you have=
 to look at the shirt it makes your eyes hurt
(15:50:05) cron2: and then there's a room full of pink
(15:50:26) novaflash: that makes it seem like a broken 3d game that's los=
t certain textures
(15:50:36) janjust: well the other swag merchandise is a piece of cake th=
en:  handbags/clutches for everyone
(15:50:49) cron2: anyway.  novaflash/mattock_: could you find out and let=
 me know?
(15:51:03) novaflash: looks like mattock is already on top of this, so i =
guess so
(15:51:05) cron2: 8 minutes left (I have a call at 15:00...) - short upda=
te on 2.5/2.6?
(15:52:14) cron2: so - 2.5.4 released, which seems to work okayish, but i=
dentifies itself in windows properties as 2.5..4 - lev__ (was) volunteere=
d to look into this
(15:52:29) cron2: (related to "other build system", so maybe broken forev=
er with MSVC but nobody noticed)
(15:52:41) plaisthos: OpenSSL 3.0 patches and OpenSSL 3.0 have been unlea=
shed on the public with my app
(15:52:46) mattock_: cron2: yes
(15:52:54) mattock_: to "could you find out"
(15:52:56) plaisthos: and apart from a lot of people running into SHA1 is=
sue it looks fine
(15:53:03) plaisthos: which brings me to my topic
(15:53:09) cron2: win11 seems to break OpenVPN 2.5.* *and* Connect for so=
me people, which is a bit weird (and hints more at "some security product=
 getting in the way")
(15:53:30) plaisthos: I suggest adding a tls-cert-profile insecure to all=
ow setting OpenSSL security profile to 0
(15:53:59) cron2: is that for 3.0.0 or also for 1.*?  what does this do a=
nd why do we want it?
(15:54:09) cron2: (besides "compat with old crap")
(15:54:20) plaisthos: for both
(15:54:44) plaisthos: cron2: compat for old crap basically
(15:54:44) plaisthos: https://www.openssl.org/docs/man3.0/man3/SSL_CTX_se=
t_security_level.html
(15:55:30) cron2: so this is a new style to specify "security profiles"?
(15:56:18) cron2: These functions were added in OpenSSL 1.1.0.
(15:56:21) plaisthos: yes
(15:56:24) plaisthos: we already support it
(15:56:34) cron2: ah, but we do not support "0".  Right?
(15:56:36) plaisthos: tls-cert-profile can currently set 1/2 with legacy/=
preferred
(15:56:37) plaisthos: yes
(15:56:52) cron2: now I understood - okay for me
(15:57:36) janjust: cron2: were any "verb 5" logs posted for failing win1=
1 clients?
(15:58:25) cron2: janjust: looked more like verb 3... but it was weird "U=
DP write" errors
(15:58:36) cron2: (forum, do not have the links handy)
(15:58:46) janjust: ok I'll check
(15:59:02) janjust: I thought that forum was supposed to be upgraded abou=
t 6 yrs ago
(15:59:40) ***cron2 is not a forum person...
(15:59:52) novaflash: have to go into a call
(15:59:54) cron2: (*and* I'm out now, need to attend that other meeting)
(16:00:25) plaisthos: okay will send a patch for security level
(16:00:33) janjust: makes me wonder if it is related to this: https://doc=
s.microsoft.com/en-us/windows/release-health/status-windows-11-21h2?irgwc=
=3D1&OCID=3DAID2200057_aff_7593_1243925&tduid=3D%28ir__llr3ag6gwokf6whl2q=
niaboutn2xrby1yzxmvckl00%29%287593%29%281243925%29%28kXQk6.ivFEQ-5Ed9DpkQ=
KDrNHmn7beYbpg%29%28%29&irclickid=3D_llr3ag6gwokf6whl2qniaboutn2xrby1yzxm=
vckl00#1704msgdesc?ranMID=3D24542&ranEAID=3DkXQk6*ivFEQ&ranSiteID=3DkXQk6=
=2EivFEQ-5Ed9DpkQKDrNHmn7beYbpg&epi=3DkXQk6.i
(16:00:34) janjust: vFEQ-5Ed9DpkQKDrNHmn7beYbpg
(16:00:52) plaisthos: and also one to openssl to include the note that sh=
a1/md5 certs are blocked with seclevel >=3D 1
(16:00:59) mattock_: cron2: any objections to separating the (big) buildb=
ot stuff from openvpn-vagrant to openvpn-buildbot?
(16:01:04) janjust: bleh... what I meant is a microsoft link about "Compa=
tibility issues with Intel =E2=80=9CKiller=E2=80=9D and "SmartByte" netwo=
rking software"
(16:01:33) cron2: mattock_: no objections
(16:02:35) mattock_: ok
(16:02:37) janjust: from that mickeysoft page: "Compatibility issues have=
 been found between some Intel =E2=80=9CKiller=E2=80=9D and =E2=80=9CSmar=
tByte=E2=80=9D networking software and Windows 11. Devices with the affec=
ted software might drop User Datagram Protocol (UDP) packets under certai=
n conditions. This creates performance and other problems for protocols b=
ased on UDP. For example, some websites might load slower than others in =
affected devices, with videos streaming sl
(16:02:37) janjust: ower in certain resolutions. VPN solutions based on U=
DP might also be slower. Next steps: Microsoft is working on a resolution=
 and targeting its release in the October security update (October 12, 20=
21)."
(16:02:39) mattock_: then I'll just do it
(16:03:14) mattock_: the "buildbot-host" directory is way too big to natu=
rally fit in openvpn-vagrant anymore, plus the "vagrant" thing has confus=
ed people into thinking that the buildbot setup somehow depends on Vagran=
t
(16:05:05) mattock_: I think all important topics covered
(16:05:08) mattock_: writing the summary

--------------DD26EBBF180812455E21434A--

