From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <74e6c803-a525-b738-6524-92354e5e9f14@...515...>
Message-ID: <bcadb5e5-d3bf-2dd6-2de7-2601a76a475c@...515...>
Date: Wed, 27 Oct 2021 22:13:05 +0300
MIME-Version: 1.0
In-Reply-To: <74e6c803-a525-b738-6524-92354e5e9f14@...515...>
Content-Type: multipart/mixed; boundary="------------AB31A5D909A84A08628E4C46"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (27th October 2021)
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
--------------AB31A5D909A84A08628E4C46
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit


Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on libera.chat
Date: Wed 27th October 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-10-27>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, d12fk, mattock, MaxF, novaflash, plaisthos and rob0 
participated in this meeting.

---

Talked about hackathon T-shirt design. The top left design was chosen 
earlier:

<https://build.openvpn.net/downloads/temp/hackathon-ideas.jpg>

Most people agreed that the grey color as shown in the design is 
preferable to black. So grey is what we'll have.

It was agreed that we'd like to have a list of hackathons at the back:

2011 Brussels
2012 Brussels
2013 Munich
2014 Munich
2015 Delft
2016 Helsinki
2017 Karlsruhe
2018 Lviv
2019 Trento
2021 Munich

---

Talked about the OpenSSL 3.0 patches aimed at 2.6. Plaisthos will make 
the requested modifications once the currently acked ones are merged.

---

Talked about 2.5.5 release. One significant bug has been fixed since 
2.5.4-I604. Agreed to wait a few weeks to make sure there are no more 
hidden corner-cases caused by the switch to MSVC builds, then do 2.5.5.

---

Talked about corp guys who are not active in the community yet they're 
joining the hackathon even on Friday-Sunday. Noted that this is ok, but 
we'd like to get them involved in community work as well. Also noted 
that Qaware guys were invited to join us on Friday.

-- 

Full chatlog attached


--------------AB31A5D909A84A08628E4C46
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-10-27.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-10-27.txt"

(15:03:05) mattock: hi
(15:03:17) novaflash [~novaflash@...2592...] =C3=A8 e=
ntrato nella stanza.
(15:03:20) novaflash: boop
(15:03:21) dazo: hey!
(15:03:37) cron2: coming soon... got stuck in a meeting
(15:03:39) MaxF: hello
(15:03:55) mattock: this is the "fight over T-shirt color and what's on t=
heir backside" -meeting
(15:04:01) rob0: hi all, longer, larger, fart[her]
(15:04:13) mattock: cron2 has opinions, not sure if anyone else has them =
:)
(15:04:14) novaflash: top left dark gray ball of network cables woo
(15:04:30) mattock: not my preference, but I can live with it
(15:05:17) dazo: mattock: oh good!  So nice with a variation of the colou=
r of the bike shed discussions ..... :-P
(15:06:11) ordex: I agree with cron2: wouldn't be bad to have the dates o=
f the hackathons on the back
(15:06:14) ordex: :]
(15:06:21) ordex: assuming this is not too much effort for the designer
(15:06:37) novaflash: it's an american designer, you know how they are wi=
th dates
(15:06:42) plaisthos: just the dates!
(15:06:45) ordex: resending: "hey I am here just to say that time my on s=
ide is still not easily available, thus I have to confirm that I won't be=
 able to join the hackathon phisically"
(15:06:45) novaflash: better teach them the right way
(15:06:52) ordex: lol
(15:07:09) novaflash: but i assume if we just do YYYY then it's hard for =
them to mess it up
(15:07:39) mattock: you still have to convert those years to pounds
(15:08:05) plaisthos: MMXI, MMXII, MMXIV, yeah should be doable ;)
(15:08:13) mattock: indeed
(15:08:29) mattock: that's actually fairly easy because we're not far awa=
y from 2000
(15:08:36) mattock: anyhow
(15:08:41) mattock: we need a list of hackathons then
(15:08:57) mattock: I should have the old T-shirt designs which have the =
list
(15:10:48) mattock: 2011 Brussels, 2012 Brussels, 2013 Munich, 2014 Munic=
h, 2015 Delft, 2016 Helsinki, 2017 Karlsruhe, 2018 Lviv, 2019 Trento, 202=
1 Munich
(15:11:06) mattock: damn, year 10
(15:11:27) novaflash: munich is a lot in there
(15:11:30) mattock: everybody ok with having the dates on back
(15:11:32) mattock: ?
(15:11:35) novaflash: +1
(15:12:04) mattock: as for the color: I would personally prefer the gray =
one
(15:12:10) novaflash: it serves as a great reminder of the trauma experie=
nced - but only when i see someone else wearing the shirt. so i'm not con=
fronted with it every time when wearing it myself.
(15:12:13) novaflash: yes gray +1
(15:12:19) mattock: but it might be possible to just have black for cron2=
 and grey for everyone else
(15:12:20) mattock: :D
(15:12:31) dazo: gray++
(15:12:32) novaflash: just turn off the light for him
(15:12:42) rob0: I think plaisthos also wanted black
(15:12:54) mattock: I told the designed (let's call him Matt) to make des=
ign so that it will work on both grey and black
(15:13:10) mattock: rob0: I think plaisthos said he has too many black ha=
ckathon T-shirts
(15:13:11) mattock: :)
(15:13:18) rob0: haha
(15:13:24) plaisthos: yeah
(15:13:35) plaisthos: I would prefer a non-black colour
(15:13:53) mattock: I also have like 10 black openvpn hackathon T-shirts,=
 so I welcome change
(15:14:33) novaflash: i have a backup design handy just in case, in pink
(15:15:03) d12fk: pink *would* be nice
(15:15:20) ***rob0 has to go afk, wishing all an excellent hackathon and =
a well-painted bikeshed
(15:15:27) rob0: pink++
(15:15:38) cron2: now
(15:15:52) novaflash: hi
(15:16:05) d12fk: so, "pink" summons cron2 =3D)
(15:16:34) dazo: not sure how to interpret that .....
(15:16:58) mattock: rob0: have fun!
(15:18:44) mattock: novaflash: I'm sure the backup design is created with=
 MS Paint
(15:19:52) novaflash: yes but i am a pro at it https://crashed.computer/2=
021-10-13_14-57-08.jpg as you can see here
(15:20:15) cron2: so if you all are grey hackers these days, I can live w=
ith non-black... but...
(15:20:29) mattock: ...but you will not talk to any of us during the hack=
athon? :D
(15:20:34) plaisthos: novaflash: your English is stuck in 200 year old En=
glish
(15:20:41) plaisthos: when gay had a different meaning
(15:20:57) mattock: I think novaflash means the more modern meaning of "g=
ay" here
(15:21:11) cron2: mattock: if I have to look at white or grey t-shirts, I=
'll have to wear sunglasses
(15:21:30) mattock: ok :)
(15:21:39) mattock: grey is much better than white in that regard
(15:21:43) MaxF: has someone invented shirts with a dark mode toggle yet?=

(15:21:54) mattock: I don't think so
(15:22:04) mattock: I've only seen swag mugs that turn from black to whit=
e
(15:22:12) mattock: when you pour hot liquid inside
(15:22:42) mattock: ok, so grey is good enough even for cron2, and we wan=
t the list of hackathons at the back
(15:22:55) mattock: anything else regarding T-shirts?
(15:23:15) dazo: MaxF: only in the webshops ... but can't be toggled afte=
rwards :-P
(15:24:17) plaisthos: As for OpenSSL 3.0 patches. I think I will wait unt=
il the currently acked are merged and then a v4 patch set of the ones tha=
t needed correction/are not yet merged
(15:25:16) cron2: plaisthos: I'm not sure I can merge any of the currentl=
y ACKed ones, as they seem to depend on prior infra
(15:25:25) plaisthos: cron2: which one?
(15:25:42) MaxF: plaisthos Do you want to change anything about 19/21? Ot=
herwise I'm going to review that one today
(15:26:00) plaisthos: no 19/21 is fine as is
(15:26:01) cron2: like 11 ("USe EVP_MD_get0_name"), that needs openssl_co=
mpat.h context
(15:26:07) plaisthos: ah
(15:26:36) cron2: ok, I thought 01 had a "can you change this?" comment f=
rom Selva, but that was misremembered
(15:26:52) cron2: that was actually myself getting confused about "const"=
, but that has been clarified
(15:26:56) cron2: so, 01 is good
(15:27:02) cron2: 02 wants reindenting - shall I do that?
(15:27:03) plaisthos: the context is just=20
(15:27:03) plaisthos: #if OPENSSL_VERSION_NUMBER < 0x30000000L
(15:27:32) plaisthos: cron2: should I resend the patch for that?
(15:27:54) cron2: 02 + reindent - you can re-send, or I can fix at apply =
time
(15:28:30) cron2: 08 wants code change (Selva)
(15:28:47) cron2: 09 has an ACK (MaxF) and a style change (Selva)
(15:29:11) cron2: 10 is good
(15:29:35) cron2: 11+13 are good
(15:29:55) cron2: 12 (providers) has a larger discussion, but 13 is indep=
endent of that, I think
(15:30:13) cron2: so yeah, I can busy myself with 01+02+10+11+13
(15:30:34) plaisthos: and when those are merged I can then resend the oth=
er ones that are still missing
(15:30:40) cron2: yep
(15:31:07) MaxF: 18 looks good too
(15:34:47) cron2: it definitely has no conflicts
(15:37:27) cron2: anything else on 2.6?
(15:38:19) mattock: not from my end
(15:39:18) cron2: so, 2.5 :-)
(15:39:29) cron2: shall we do a 2.5.5 eventually, when we are sure we hav=
e finally fixed all windows bugs?
(15:40:06) mattock: you mean a real 2.5.5 or 2.5.4 + more MSVC fixes?
(15:42:52) mattock: I mean, either one is ok once we're fairly sure there=
 won't be more MSVC fixes
(15:43:12) mattock: but maybe we can wait for some non-Windows fixes _or_=
 some months
(15:43:53) cron2: there is a crucial bug fixed in 2.5.4
(15:44:36) cron2: wiscii's common_name env bug!!
(15:44:45) mattock: that one
(15:44:54) mattock: I think you mean release/2.5
(15:44:58) cron2: but yeah, we can do that in 2-3 weeks when we have more=
 feedback on I604 (<- that is actually a record)
(15:45:01) cron2: yes
(15:45:11) cron2: and yes, "in release/2.5 after 2.5.4"
(15:45:33) mattock: yep, let's wait "some weeks" and then consider 2.5.5
(15:47:02) cron2: another quick note about the hackathon
(15:47:19) cron2: I see that we're quite many people, and half of them I'=
ve never heard of
(15:47:26) cron2: but they all stay until Sunday
(15:47:43) cron2: so, does that mean, lots of corp people that all discov=
ered their love for the community side of things and want to contribute m=
ore?
(15:47:50) ***dazo looks at the list
(15:47:58) mattock: https://community.openvpn.net/openvpn/wiki/Hackathon2=
021
(15:48:18) dazo: I recognise all names
(15:48:30) cron2: well, not "lots", but at least a few :- (Kyryl, Frank, =
Jeff, Mark)
(15:48:31) mattock: you're in the company
(15:48:37) mattock: yep
(15:48:39) dazo: it's a lot of corp folks, indeed
(15:48:48) dazo: we need to expand the community too!
(15:48:58) cron2: right
(15:49:02) mattock: joining on Fri-Sun will require doing community work
(15:49:06) mattock: agreed?
(15:49:10) mattock: :)
(15:49:23) dazo: yeah!
(15:50:01) cron2: yep
(15:50:11) ordex: some are just curious to learn more about the community=
 and the open source project
(15:50:13) mattock: so we just have to figure out what those guys can do
(15:50:38) novaflash: oh shit do i have to mop the floor or something
(15:50:41) novaflash: community service
(15:50:55) cron2: to clarify, this is certainly welcome, I just wanted to=
 understand what everybody's expectations are :-)
(15:51:17) cron2: *and* I have invited qaware geeks for Friday ("if you a=
re using OpenVPN, and want to meet the folks behind, *and* contribute, th=
en please come!")
(15:51:24) mattock: novaflash: yes, or entertain us by pole dancing
(15:51:36) novaflash: i don't wish to destroy the community
(15:51:37) cron2: novaflash could bake stroopwaafels
(15:51:42) mattock: +1
(15:51:43) novaflash: i'll bring stroopwafels
(15:52:02) cron2: :-)
(15:52:56) dazo: so far 14 folks are coming ... so that's within the limi=
tations at least.  And a good group size
(15:53:27) d12fk: ah those... lekker
(15:53:29) cron2: yes, our limit is 20(-ish), so this is a good size
(15:53:51) mattock: I need to leave in 2 mins
(15:53:56) mattock: anything else on the plate?
(15:53:58) cron2: if only 5 people show up, it's a bit of a silly signal =
towards qaware "look, this is the community, all 5 of us!" :-)
(15:54:17) novaflash: i will just pretend to be community member, to fill=
 out the ranks
(15:54:28) mattock: well you are at least talking on IRC
(15:54:31) dazo: In stead it is "we're 14!  3 of them are from the commun=
ity" :-D
(15:54:32) novaflash: "and what do you do in the community?" pole dancing=
 and stroopwafels and mopping the floor
(15:54:33) mattock: so that qualifies you
(15:54:40) d12fk: novaflash: jubelperser
(15:54:43) MaxF: I'm also coming, can/should I just edit myself into the =
table?
(15:54:59) cron2: MaxF: yes, please.
(15:55:00) mattock: MaxF: of course, along with the T-shirt size
(15:55:10) mattock: voting for design is no longer possible :)
(15:55:29) dazo: unless he votes for top left! :-P
(15:55:34) mattock: that is allowed
(15:55:35) mattock: :)
(15:55:57) mattock: ok, I have to leave, will send the summary after I co=
me back (~20 minutes)
(15:56:03) ***cron2 waves
(15:56:15) cron2: I have to leave as well, next call starts in 4 minutes.=
=2E. and my coffee is empty
(15:56:20) novaflash: that's the signal for me to leave as well i guess. =
got a meeting in 4 minutes.
(15:56:26) cron2: busy folks
(15:56:26) plaisthos: dazo: the one man one vote one option approach? :)
(15:57:01) dazo: you make it sound so bad, plaisthos ..... :-P
(15:57:03) novaflash ha abbandonato la stanza (quit: Quit: gotta go poled=
ancing).
(15:58:19) mattock: let's all leave

--------------AB31A5D909A84A08628E4C46--

