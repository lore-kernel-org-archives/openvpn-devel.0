Message-ID: <4D0B71CB.3020809@...515...>
Date: Fri, 17 Dec 2010 16:20:59 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030101060106070603060909"
Subject: [Openvpn-devel] Summary of the IRC meeting (16th Dec 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------030101060106070603060909
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 16th Dec 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-12-16>

Next meeting will be announced in advance, but will be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<http://www.timeanddate.com/world clock>

or with

$ date -u


SUMMARY

Common, dazo, ecrist, krzie and mattock were present in this meeting.

None of the planned topics could be covered, as they would have required
James' presence.

--

Discussed the current ACK system, which could be working better.
Especially large patchsets and non-trivial patches have a tendency the
get "stuck" because of lack of ACKs. Decided to try splitting the ACK
process into two parts to encourage participations from developers and
non-developers alike:

 * Feature ACK: this is given if the _feature_ the patch provides makes
   sense. This is where non-developers can participate easily.
 * Patch quality ACK: this is where the patch is reviewed to make sure
   it is compliant with the patch quality requirements. This ACK is
   meant to be given by developers.

A patch has to get both ACKs to be included into the development tree.
However, both ACKs can be given at the same time by the same person.

Mattock promised document this new process in the developer
documentation, and he did:

<https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>

Also discussed a few options to make this ACK process as smooth and as
widely known as possible:

- write a mailman welcome message describing our development/ACK process
- send a (weekly?) summary of new, unACKd patches to openvpn-users ml
- create a webapp (or Trac addon) which would be used by users to vote
  on which patches make sense (or user the forums?)

--

Discussed the placement of "Community project" link on openvpn.net.
Agreed that the link was very hard to find, which had led into a number
of complaints from users looking for OpenVPN downloads and
documentation. This even led some people to think that the OpenVPN OSS
project had been discontinued in favor of commercial products.

NOTE: the link was returned to it's original position soon after the
meeting.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------030101060106070603060909
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-12-16.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-12-16.txt"

(20:01:35) ***dazo gets ready for the meeting
(20:02:09) mattock: ... meeting time
(20:03:23) dazo: Agenda: https://community.openvpn.net/openvpn/wiki/Topics-=
2010-12-16
(20:03:24) vpnHelper: Title: Topics-2010-12-16 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(20:04:43) dazo: mattock: have you mailed James?
(20:05:33) mattock: dazo: I'll do it now
(20:06:37) mattock: ok, sent
(20:06:41) mattock: so, which topic first?
(20:07:21) dazo: well, we have 3 patches, and two of them definitely needs =
James' eyes (2nd and 3rd)
(20:07:29) mattock: ok, so the first one then
(20:07:52) dazo: That's the dev_type patch
(20:07:59) dazo: that needs an ACK/NACK
(20:08:07) mattock: any other devs present?
(20:08:17) dazo: cron2 said it looked fine and sane but didn't really under=
stand the point of it
(20:08:24) mattock: :)
(20:08:43) mattock: I think that's a serious problem with the current ACK/N=
ACK system=20
(20:09:05) mattock: even if code looks good, that's not enough to know if t=
he patch itself makes sense in a larger context
(20:09:13) dazo: yeah, agreed
(20:09:26) mattock: which I think is a big reason why people don't often AC=
K/NACK
(20:10:51) dazo: I know I stay low on patches where I know I don't see the =
deep implications ... but I'm also taking some chances, trying to understan=
d the patches ... and to make up my own opinion if it makes sense or not
(20:11:06) mattock: I also think that if one ACK is enough, some devs might=
 avoid giving an ACK to a patch they don't really understand
(20:11:26) mattock: so that they're not "responsible" if something goes bad
(20:11:30) dazo: But that depends on a good problem description, a good exp=
lanation of the solution ... and then a clean patch
(20:11:57) mattock: yeah
(20:12:21) dazo: Well, it's not too many active developers ... but I do app=
reciate each of those who did send ACK to the list
(20:12:52) dazo: I think maybe people set the barrier too high for themselv=
es on when to ACK/NACK or not
(20:13:09) mattock: perhaps we could try to clarify what the ACK means?
(20:13:15) mattock: and where the barrier should be set
(20:13:24) dazo: yeah, that would really be good
(20:14:03) mattock: so, basically we'd need to make sure code is good quali=
ty (formatting, style, conventions etc)
(20:14:14) mattock: but also to make sure the feature / fix makes sense
(20:14:22) mattock: =3Dis worth including
(20:14:22) dazo: yes
(20:14:48) dazo: it should not require deep understanding of what really ha=
ppens, but if the feature/change makes sense from a user perspective
(20:15:13) mattock: the way I see it, a big issues is trying to understand =
what the patch really does when included... it's not easy to see that from =
a diff
(20:15:21) mattock: and perhaps that's holding many back from giving an ACK
(20:15:23) dazo: I will anyway be the one who evaluates patches in the end =
for inclusion ... so I will always have a veto if I mean this is to bad
(20:15:26) roentgen [~arthur@...1423.../community/support/roentgen] =EF=BF=
=BD=EF=BF=BD entrato nel canale.
(20:15:59) dazo: that means we need to be better at asking better explanati=
ons of what the patch does, in plain English
(20:16:10) dazo: asking *for better
(20:16:35) mattock: yeah, that, but it's also probably really hard to see a=
ny unintended side-effects from the diff
(20:16:45) mattock: even obvious ones
(20:17:02) dazo: I know that can be difficult sometimes ... you've worked h=
ours with a patch, it works ... and then to adjust to write something under=
standable for people not having been deep into those code paths
(20:17:33) dazo: yeah, side-effects is impossible to guard yourself against=
 .... --x509-username-field is an example of this
(20:17:47) mattock: would it make sense to "split" the ACK process into two=
 parts? for example, somebody could give a "this feature makes sense ACK" a=
nd "the code looks good ACK"
(20:18:05) mattock: to lower the barrier for giving an ACK
(20:18:15) dazo: interesting thought=20
(20:18:34) dazo: I'm not convinced it really lowers the barrier though ... =
but I'm willing to give that a shot
(20:19:07) dazo: but it should be possible to also give both ACKs at the sa=
me point, to avoid deadlocking due to only having received one ACK
(20:19:37) mattock: yep
(20:20:02) mattock: I think the core of my idea is that a single person doe=
s not have to be responsible for the "whole" ACK
(20:20:05) dazo: when you read the commit msg on the dev_type patch ... are=
 you able to catch the concept of the patch?
(20:20:13) mattock: let's see...
(20:21:20) mattock: before I start reading... the benefit of the above spli=
t ACK system would be that non-dev could give the "feature makes sense ACK"
(20:21:35) mattock: even though they could not comment on the code quality
(20:22:23) dazo: yeah, I see that as an advantage, if we get more active AC=
Kers
(20:22:56) dazo: that means we don't waste time on discussing code quality,=
 if some people don't see the purpose of the patch to start with
(20:23:01) common: actually it does not really matter initially what people=
 reply, if it is an ack or just a question
(20:23:17) dazo: that's true
(20:25:05) mattock: dazo: after reading the commit message thoroughly I thi=
nk I got it
(20:25:18) mattock: and I give it a "this feature makes sense ACK" :D
(20:25:29) dazo: mattock: was something unclear?
(20:26:02) dazo: I was thinking we could create an example of an ideal comm=
it message for people posting to the ML ... and if things are not so clear,=
 we point them towards that description
(20:26:05) mattock: well, I assume the "dev" environment variable is availa=
ble already
(20:26:13) mattock: that was not 100% clear to me at first
(20:26:34) mattock: because of the "... will contain" (as if the patch adds=
 that functionality)
(20:26:35) dazo: good point ... I see I took that knowledge for granted, so=
 that's one mistake
(20:27:06) dazo: (it's even a grammar mistake ... it should have been:  con=
tains)
(20:27:46) mattock: writing documentation is hard... or good commit messages
(20:28:07) dazo: it is, and especially after having worked on something and=
 all details are in your fingertips
(20:28:15) mattock: common: can you give the dev-type patch an ACK?
(20:28:33) common: am I in the position?
(20:28:36) mattock: yep
(20:28:48) dazo: all developers are allowed to ack or nack things on the ML
(20:28:58) common: never used openvpn as server on windows, did not get the=
 idea, not looked on the patch
(20:29:05) common: need to catch a train in 5 minutes
(20:29:19) mattock: oh
(20:29:33) dazo: there we have another issue ... people might not know they=
 are allowed to do ACK/NACK
(20:29:38) mattock: true
(20:29:58) mattock: I think that's especially true with non-developers
(20:29:59) dazo: we probably need a better "How can I contribute" introduct=
ion
(20:30:11) common: mailmain welcome message
(20:30:16) common: mailman
(20:30:24) dazo: good idea!
(20:30:28) mattock: yep
(20:30:36) common: ned to run, sorry
(20:30:38) mattock: I can add one easily
(20:30:41) dazo: common: have fun
(20:30:45) mattock: common: have a nice trip!
(20:30:46) dazo: thx for your input!
(20:31:00) mattock: ok, so we need a mailman welcome message
(20:31:08) mattock: and improvements to the wiki articles
(20:31:24) dazo: and we need to polish/write a "How can I contribute" page
(20:31:55) mattock: hmm, we don't have a single "How can I contribute" page=
, actually
(20:32:02) mattock: only "developer" and "tester" pages
(20:33:32) mattock: this section could be improved: https://community.openv=
pn.net/openvpn/wiki/DeveloperDocumentation#Communitypatchesandtheacceptance=
processofthesepatches
(20:33:33) vpnHelper: Title: DeveloperDocumentation =EF=BF=BD=EF=BF=BD=EF=
=BF=BD OpenVPN Community (at community.openvpn.net)
(20:34:12) mattock: (I'll ask if the guys @company know where james is)
(20:34:14) dazo: that can be improved yes
(20:34:46) mattock: should we "split" the ACK process and see what happens?
(20:35:43) mattock: this does not have to be anything else than explaining =
this on the -devel ml and encouraging people to ACK either the code, or the=
 feature
(20:35:55) dazo: Let's give that a shot ... if that's what's needed to get =
the ball rolling, we can join it later on when things are flowing better
(20:36:37) dazo: we just need to be clear that we do need both feature and =
code ACKs ... but one person can give both
(20:36:38) mattock: it's just that especially the bigger patchsets tend to =
get "stuck" when following the current process
(20:36:46) mattock: yes, agreed
(20:38:03) dazo: yeah ... and that's why I have not cared so much about tha=
t cron2's IPv6 patches haven't gotten acked ... but then again, he is activ=
e here and on the ML, and from how he responds and the code I've seen, it i=
s clean and I feel I can trust him
(20:38:48) mattock: I can update the wiki with these ideas and you can then=
 have a look
(20:38:56) dazo: that'd be great!
(20:38:58) mattock: and if the changes are ok, I can send mail to -devel
(20:39:05) dazo: goodie!
(20:39:20) mattock: andrew thinks James is sleeping :)
(20:39:28) dazo: But maybe we should have a introduction page for "How to c=
ontribute", and then that one can link to more detailed pages
(20:39:38) dazo: heh
(20:39:40) dazo: okay
(20:40:00) mattock: agreed, I'll write that page
(20:40:05) krzee: +1
(20:40:17) mattock: I'm surprised we gotten so far without that page, actua=
lly :)
(20:40:49) mattock: krzee: what do you think about the non-devs giving feat=
ure ACKs?
(20:40:55) mattock: makes sense to you?
(20:41:04) dazo: the aspects we probably should cover are ... documentation=
, testing and development ... probably something else which would be clever=
 to add
(20:41:08) krzee: mattock, im for it, but it should be treated as a differe=
nt type of ACK
(20:41:25) mattock: different from what exactly?
(20:41:30) krzee: for example, im not a dev, but if i used ipv6 i could ACK=
 as in "works for me in X situation"
(20:41:32) dazo: krzee: agreed
(20:41:43) mattock: oh yes, good point
(20:41:53) krzee: whereas a dev ACK is like "the code follows the openvpn s=
tyle, and should work, and doesnt introduce bugs"
(20:42:15) dazo: "doesn't introduce bugs" is probably to raise the bar too =
high ;-)
(20:42:34) dazo: but "doesn't introduce any obvious risks" are probably clo=
ser to reality
(20:42:42) krzee: right
(20:42:54) krzee: but just illustrating how the ACKs are very different
(20:43:04) krzee: one is a coder point of view, one is a user point of view
(20:43:07) krzee: both are important
(20:43:52) dazo: yes, that's exactly the point .... and no point of spendin=
g time on patches which users just responds "huh!?!? wtf?!? Do I need that?"
(20:44:13) krzee: definitely not a priority when that is the response
(20:44:16) mattock: krzee: I really like your point of view
(20:45:03) mattock: so basically, non-devs could say "this feature makes se=
nse/does not make sense" and "I've tested this feature and it works / does =
not work for me"
(20:45:18) mattock: the only things devs would have to take care of is code=
 quality and code integration issues
(20:46:15) dazo: how difficult would it be to setup a web page where you po=
st patches ... then users can vote on patches, and if karma > 1 after a wee=
k, the patch is automatically posted to the devel mailing list ...
(20:46:55) dazo: then we could even "hide" the diff section (viewable on re=
quest) and maybe that would be less intimidating for users to look at
(20:47:33) dazo: (would be even cool if that "web page" could tackle being =
e-mail too as well)
(20:47:37) mattock: perhaps a Trac add-on?
(20:47:44) dazo: f.ex
(20:50:05) dazo: okay, seems we need to postpone the  current agenda for ne=
xt meeting ... which will be when?
(20:50:20) dazo: I cannot next week, and it is the 23rd
(20:50:21) mattock: yep, agreed
(20:50:33) mattock: perhaps 30th?
(20:50:44) dazo: another thing ... the --x509-username-patch should be tack=
led before the RC
(20:50:53) dazo: 30th should work for me
(20:50:58) mattock: let's try to reach James before that
(20:51:06) dazo: Yeah, definitely
(20:51:27) mattock: mail him, unless he visits the IRC
(20:51:30) dazo: If we can get that one in, I don't have issues with ACKing=
 common's patch
(20:51:33) mattock: hasn't he been here quite often lately?
(20:51:54) mattock: btw. JJK's chained certificate stuff should go into the=
 Wiki
(20:51:54) dazo: well, at least passively ... I don't know how much attenti=
on he gives to the channel
(20:52:00) dazo: definitely
(20:52:12) mattock: I'll ask if he'd like to write a short article there
(20:52:20) dazo: would be cool!
(20:52:43) dazo: or at least copy-paste his mails, and then polish the text=
 a bit
(20:53:33) dazo: mattock: I'll try to remember to mail James tomorrow ... b=
ut if it pops into you mind, I don't mind getting a reminder
(20:53:44) mattock: ok, I'll try
(20:53:52) dazo: no stress
(20:53:56) mattock: regarding the web page for ACKs/karma...
(20:54:32) mattock: I'm wondering if just sending the patch description to =
openvpn-users would do the trick
(20:54:42) mattock: or, in addition, posting to the forums
(20:54:52) dazo: yeah, but it's more tricky to follow something more places
(20:55:10) mattock: agreed, I don't like fragmenting the communication chan=
nels either
(20:55:14) mattock: gets messy
(20:55:29) dazo: maybe a weekly summary to -users (+ forums?) of new patche=
s on -devel would be a better solution?
(20:55:42) mattock: hmm, that might do the trick
(20:55:49) dazo: with links to each patch
(20:56:26) ***dazo need to prepare to go
(20:56:28) mattock: maybe on monday/tuesday
(20:56:42) mattock: so that people can comment on the patches before the me=
eting
(20:56:42) dazo: you mean the mail?
(20:56:45) mattock: yep
(20:56:45) dazo: yeah
(20:56:58) mattock: and then, in the meeting (if necessary), give the devel=
oper ACK
(20:57:04) mattock: anyways, something like that might work
(20:57:13) dazo: I hope so :)
(20:57:34) mattock: I'd start with simple documentation and encouragement, =
though :)
(20:57:55) dazo: yeah ... that makes it more easy to see we are serious abo=
ut this :)
(20:58:10) dazo: btw ... just recalled it now ... I saw the new web-pages=20
(20:58:15) mattock: ok, let's continue this tomorrow
(20:58:21) dazo: the community edition is completely hidden now :-P
(20:58:34) mattock: yep, it is
(20:58:34) dazo: (at least for windows users)
(20:59:00) mattock: surprisingly nobody except ecrist has been annoyed (eno=
ugh) with the new hidden "community project"
(20:59:05) mattock: I was expecting a backlash
(20:59:37) dazo: well, I remember you mentioned this fear ... but I didn't =
realise it was so extreme until today when I heard cron2 getting confused
(21:00:13) mattock: well, in my opinion it does not make sense to hide the =
community project like that
(21:00:24) dazo: IMO ... this page looks like it tries to hide the communit=
y behind openvpn totally
(21:00:37) mattock: yep, that's definitely how it looks
(21:00:56) dazo: That do give me a distasteful feeling
(21:00:58) krzee: mattock,=20
(21:01:02) krzee: that is SOOOOO not true
(21:01:07) krzee: i get complaints OFTEN
(21:01:10) krzee: as does ecrist
(21:01:23) mattock: krzee: do you have links to the complaints? or quotes?
(21:01:38) krzee: just 2 nights ago someone complained to the point of bein=
g banned
(21:01:39) mattock: something concrete "evidence"
(21:01:46) krzee: his name on IRC is simplechat
(21:02:12) dazo: let's collect a lot of complaints ... and then write a cle=
ar messages to the management in OpenVPN Tech ...
(21:02:13) krzee: he asked us to slap the webmaster, preferably with a trout
(21:02:21) mattock: krzee, ecrist: if you want to help get the "Community p=
roject" links to where they belong, copy-and-paste each complaint and send =
them to me
(21:02:57) mattock: I'll forward them to the correct place and I'm sure thi=
ngs will get back to normal pretty soon
(21:02:57) krzee: we asked him to write on the wishlist what his solutions =
to his complaints are, not sure if he did
(21:02:57) krzee: !wishlist
(21:02:57) vpnHelper: "wishlist" is https://forums.openvpn.net/viewforum.ph=
p?f=3D10 for the openvpn wishlist
(21:02:57) krzee: (ill check)
(21:03:06) dazo: For me this new web page was a slash in the face, of the t=
ime and energy I've put into the OpenVPN community
(21:03:38) krzee: and quite a few users felt it was ovpn selling out, they =
cant even find how to download openvpn
(21:03:44) krzee: few think to click the community link
(21:03:58) krzee: they click right to the downloads section, which doesnt h=
ave the FOSS version
(21:04:14) dazo: "Community Project" is just too vague ...
(21:04:15) mattock: yep, my thoughts exactly
(21:04:30) ***dazo really need to run
(21:04:33) dazo: c'ya tomorrow!
(21:04:36) mattock: and given the amount of confusion there was when the "C=
lient software" tab lead to Access server clients only...

--------------030101060106070603060909--

