Message-ID: <4C286BBB.7080206@...515...>
Date: Mon, 28 Jun 2010 12:30:35 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060804080403000104020400"
Subject: [Openvpn-devel] Summary of the IRC meeting (24th Jun 2010)
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
--------------060804080403000104020400
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 24th Jun 2010
Time: 18:00 UTC

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed the bridge-start and bridge-stop scripts available on
openvpn.net. They had been discussed in an earlier meeting, too:

<http://article.gmane.org/gmane.network.openvpn.devel/3720>

Decided to proceed by first documenting to the Wiki what bridging is and
how it works, then creating sample scripts and sending them for review.
Waldner volunteered for this job.

--

Discussed an old patch, "Exclude ping and control packets from activity":

<http://article.gmane.org/gmane.network.openvpn.devel/3690>

This issue had been discussed in an earlier meeting:

<http://article.gmane.org/gmane.network.openvpn.devel/3673>

In this earlier meeting we decided to ask our users if they had managed
to configure proper byte limit for --inactivity so that the ping traffic
would be effectively ignored (without side-effects). Unfortunately
nobody replied:

<http://article.gmane.org/gmane.network.openvpn.devel/3676/>

Waldner will test the patch thoroughly to ensure that it never causes
ping packets to be dropped. After this the patch can be merged into
"testing" tree.

--

Discussed the possibility of using the Trac wiki as a staging area for
official OpenVPN documentation. This would mean that documentation would
be created in the following fashion:

- documentation would be created/modified in the wiki
- when an article is deemed good enough, it would become part of the
official documentation on openvpn.net

This would allow community to participate in the documentation effort
much more easily. It would also increase the overall quality of official
documentation. Everybody agreed that this is a good idea.

A similar arrangement is in use in the Puppet project:

<http://docs.puppetlabs.com>
<http://projects.puppetlabs.com/projects/puppet/wiki>


---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock






--------------060804080403000104020400
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-06-24.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-06-24.txt"

(21:05:07) mattock: ...
(21:07:05) mattock: dazo should be attending
(21:07:09) mattock: as should james
(21:07:20) dazo [~dazo@...1368.../redhat/x-pfdongmzktsdnycy] =EF=BF=BD=EF=
=BF=BD entrato nel canale.
(21:07:23) #openvpn-devel: modalit=EF=BF=BD=EF=BF=BD (+o dazo) da ChanServ
(21:07:25) mattock: hi dazo!
(21:07:42) dazo: mattock:  Hi :)
(21:07:55) mattock: I think I'll mail James... the guys at the company are =
_really_ busy releasing the next version of Access Server, so...
(21:08:03) mattock: I hope he could ACK the one patch we have in the queue
(21:08:18) waldner: heh, I hope it too :)
(21:08:22) dazo: yeah, that sounds good
(21:08:31) mattock: do you guys have anything else in mind for today?
(21:08:57) mattock: btw. community.openvpn.net is up again, there hav been =
lots of rekeying going on lately
(21:09:15) waldner: yes, I have some questions about the fixing of the brid=
ge script on the website which we talked about some time ago
(21:09:32) dazo: what's this rekeying procedure?  twice in less than 4-5 mo=
nths is quite a lot
(21:11:48) mattock: dazo: well, it's a long story... involving new wildcard=
 certs, certificate passwords etc.
(21:11:56) mattock: not sure of the exact details
(21:12:17) mattock: this should be the "final" rekeying - at least for a lo=
ng time
(21:12:18) mattock: ;)
(21:12:36) dazo: :)
(21:12:53) dazo: I hope so too, as it's rather annoying to suddenly loose t=
he community site
(21:12:54) mattock: sent mail to James
(21:13:33) mattock: waldner: perhaps we could start with your issue
(21:13:39) krzee: funny for PKI to be an issue for anything related to us ;]
(21:13:42) krzee: irony
(21:14:07) krzee: dazo, how you liking the openvpn cookbook?
(21:14:16) krzee: im sending back chapter 2 right now
(21:14:44) waldner: there is an openvpn cookbook?
(21:14:56) dazo: krzee:  I've only received chapter 1, and not really had t=
ime to look at it yet ... but it's coming a flight today, so I'll find some=
 time :-P
(21:15:07) dazo: waldner:  Jan Just Keijser is writing one
(21:15:12) waldner: cool
(21:15:35) waldner: mattock: yes, we can start from that
(21:16:03) mattock: waldner: shoot :)
(21:16:27) waldner: so, the bridge-start and stop as they are are broken
(21:16:34) waldner: we already agreed on that
(21:16:39) mattock: we did
(21:16:46) waldner: but bridge-stop is "more" broken than bridge-start
(21:16:59) waldner: because it doesn't even restore the old configuration a=
fter deleting the bridge
(21:17:12) waldner: it jst leaves the system unconfigured
(21:17:32) waldner: now, the first step I suggest is to "fix" that
(21:17:50) waldner: eg, at least it should end by restoring what brisge-sta=
rt undid
(21:18:22) waldner: once that is done, there are various possibilities
(21:19:03) waldner: the main problem is that (imho) using a bridge in that =
way is "wrong"
(21:19:12) waldner: ie, creating and destroying it on the fly
(21:19:36) waldner: I've always advocated permanent bridge, and just add/re=
move the tap interface when openvpn starts/stop
(21:19:41) ***dazo tend to agree
(21:20:16) mattock: I'll try to find the earlier meeting discussion
(21:20:21) waldner: so one thing to decide is: if we support the permanent =
bridge approach, then 99% of the issues are automatically solved
(21:20:25) dazo: Dynamic bridging increases the difficulty considerably, an=
d is IMHO a more hackerish solution
(21:20:30) waldner: and bridge-start and bridge-stop become basically 1-2 l=
ines of code
(21:20:59) waldner: (ip link set tap0 up && brctl add bro tap0, essentially)
(21:21:18) krzee: (if in linux)
(21:21:23) waldner: if, on the other hand, we want to go the dynamic bridge=
 route, then there are issues
(21:21:29) waldner: krzee: yes
(21:21:35) dazo: you'd need some way to identify/tell the script which brid=
ge to add/remove the tap device to/from
(21:21:48) waldner: but it's still much simpler than going the dynamic way
(21:21:59) krzee: agree
(21:22:04) dazo: +1
(21:22:11) waldner: and, the big one imho
(21:22:39) waldner: is that once you remove the IP from eth0, and you had a=
 default route pointing to eth0, the default route is deleted
(21:22:44) waldner: at least under Linux
(21:23:06) waldner: so that would mean parsing the routing table to check, =
and perhaps restore routes once the bridge is created
(21:23:14) waldner: (and the reverse with bridge-stop)
(21:23:48) waldner: which look like a lot of work to be done right imho
(21:24:25) waldner: I have some ideas on how that could be done on Linux, b=
ut I don't know how it could be managed on other systems
(21:24:40) mattock: ok, I found the earlier discussion: http://article.gman=
e.org/gmane.network.openvpn.devel/3720
(21:24:52) vpnHelper: Title: Gmane -- Mail To News And Back Again (at artic=
le.gmane.org)
(21:26:34) mattock: it seems a guy named "waldner" volunteered to do some s=
cript hacking on 27th May ;)
(21:26:45) waldner: heh
(21:26:55) waldner: better late than never :)
(21:27:04) waldner: seriously, I've been quite busy
(21:27:19) waldner: I think I'll have some time to work on that soon
(21:27:34) waldner: and I wante to set things straight before starting
(21:27:37) mattock: no problems, take your time
(21:28:55) waldner: so to recap: fix the major brokennes of bridge-stop
(21:29:02) waldner: ah btw, that script is already Linux-specific, right?
(21:29:29) mattock: waldner: I think so, yes
(21:29:39) mattock: I don't think anything else uses the bridge-utils
(21:29:56) dazo: I think we should keep things stupidly simple.  We should =
not "rearrange" the network in our scripts when starting openvpn with bridg=
ing ... some preparation steps should rather be documented and presumed com=
pleted before people start using openvpn with bridging
(21:30:19) mattock: dazo: +1
(21:30:39) waldner: +1
(21:30:50) dazo: then we would need some clever magic in our scripts which =
then adds the TAP device to/from an already existing bridge, according to t=
he distro/OS way of doing it
(21:31:01) waldner: and once that is stated, perhaps provide different scri=
pts for different operating systems
(21:31:20) waldner: or, harder, a single script that detects the os and wor=
ks everywhere
(21:31:25) waldner: yes
(21:31:29) dazo: you could identify that via a call to uname ... and then j=
ust call the different methods based on the uname result
(21:31:40) waldner: yes, that could be a way
(21:31:57) dazo: uname -o, might be the safest
(21:32:08) waldner: and I think it could be useful to document how to creat=
e a permanent bridge on the major OSs
(21:32:15) dazo: +1
(21:32:28) waldner: cool
(21:32:37) mattock: waldner: you could write the documentation to community=
.openvpn.net Wiki
(21:32:51) waldner: is it possible to use the wiki to create a draft of all=
 this?
(21:32:54) waldner: :)
(21:32:57) waldner: read my mind
(21:33:00) dazo: oh yes, please do!
(21:33:02) mattock: I'm getting write access to openvpn.net next week, so I=
 can put links to community.openvpn.net in place
(21:33:12) waldner: ok
(21:33:17) mattock: waldner: drafting in wiki is a good idea
(21:34:00) mattock: waldner: do you think you have a good idea how to proce=
ed?
(21:34:06) waldner: excellent
(21:34:09) mattock: great!
(21:34:17) waldner: yes
(21:34:21) waldner: first, fix bridge-stop
(21:34:34) waldner: then start a wiki page explaining what bridging is and =
how it works
(21:34:47) waldner: and why using a permanent bridge should be preferred
(21:34:55) waldner: then, sample code etc.
(21:35:01) waldner: and review by people, of course
(21:35:07) krzee: [krzee@...1383... ~]$ uname -o
(21:35:07) krzee: uname: illegal option -- o
(21:35:07) krzee: usage: uname [-aimnprsv]
(21:35:07) krzee: not the safest ;)
(21:35:25) krzee: [krzee@...1383... ~]$ uname
(21:35:25) krzee: FreeBSD
(21:35:29) dazo: waldner:  if krzee/ecrist's wiki got something on the rout=
ing stuff, please copy that or refer to that wiki ... easier for #openvpn t=
o provide a consistent help then
(21:35:45) dazo: krzee:  good point
(21:35:53) dazo: waldner:  just uname it is then :)
(21:35:59) waldner: yes
(21:36:15) waldner: I think they have documents about routing, iroute etc. =
but not sure about bridging
(21:36:16) mattock: yep, "uname" gives "Linux" on Ubuntu 9.10
(21:36:21) ***dazo honestly thought that uname was standardised on all plat=
forms .... but obviously not
(21:36:26) waldner: krzee: ?
(21:36:33) waldner: yes, uname alnoe should be fine
(21:36:38) waldner: *alone
(21:36:46) krzee: imo my routing document is the best document online about=
 openvpn routing
(21:37:02) krzee: http://www.secure-computing.net/wiki/index.php/OpenVPN/Ro=
uting
(21:37:02) vpnHelper: Title: OpenVPN/Routing - Secure Computing Wiki (at ww=
w.secure-computing.net)
(21:37:11) krzee: welcome to mirror it or link to it anywhere you like
(21:37:17) ***dazo agrees
(21:37:17) waldner: yes, but is there something about bridging I could refe=
r to in the wiki page?
(21:37:35) krzee: there is, but its up to you to decide if its worthy
(21:37:43) waldner: ok, I'll have a look and see
(21:37:51) krzee: i had no part in anything bridge related on the wiki
(21:38:01) krzee: i avoid bridging like its infectious
(21:38:31) waldner: well, but people ask for it, and since openvpn provides=
 it, then somehow it should be documented
(21:38:40) krzee: of course i agree
(21:38:45) waldner: (and I like it, btw :))
(21:38:54) krzee: i just personally dont do it, support it, or document it
(21:39:01) waldner: I've used it to tunnel home and get IPv6 at work :)
(21:39:06) krzee: i expect those of you who like it to do so ;)
(21:39:29) waldner: sure
(21:39:55) krzee: (that was not directed at anyone specific, more of a gene=
ral comment)
(21:39:57) mattock: james does not seem to be coming... any other developer=
s who could ACK/discuss this: http://article.gmane.org/gmane.network.openvp=
n.devel/3690
(21:40:04) vpnHelper: Title: Gmane -- Mail To News And Back Again (at artic=
le.gmane.org)
(21:40:18) waldner: that's a very simple one, really (or should be)
(21:40:28) waldner: it didn't seem to break anything in my tests
(21:40:57) mattock: dazo: you had some concerns you'd like to discuss?
(21:41:15) mattock: ...regarding this patch
(21:41:33) waldner: IIRC even dazo was unsure, he had asked James
(21:41:37) dazo: mattock:  yeah, it's an older patch from waldner IIRC ... =
I'm uncertain if it is a good approach to reset a byte counter
(21:41:49) dazo: and I've not heard anything from James at all
(21:41:55) waldner: it's not a byte counter
(21:42:00) waldner: it's a length field
(21:42:04) jamesyonan [~jamesyona@...1384...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(21:42:07) waldner: \o/
(21:42:11) dazo: yeah, that was what I meant
(21:42:16) dazo: talking about the sun ;-)
(21:42:21) waldner: dazo: other parts of the code do so already
(21:42:37) waldner: but ok, I'm not 100% sure of course
(21:42:41) dazo: yeah, I just want to be sure we don't break anything by do=
ing that here
(21:42:45) waldner: yep
(21:42:46) mattock: hi james!
(21:42:49) jamesyonan: hi guys
(21:42:49) waldner: agreed
(21:42:56) waldner: hi
(21:43:05) dazo: jamesyonan:  hi!  Perfect timing, as we need some of your =
knowledge on one issue :)
(21:43:08) mattock: jamesyonan: we're now discussing the patch I mentioned:=
 http://article.gmane.org/gmane.network.openvpn.devel/3690
(21:43:14) vpnHelper: Title: Gmane -- Mail To News And Back Again (at artic=
le.gmane.org)
(21:43:19) dazo: which we just began to discuss :)
(21:43:46) waldner: basically internal pings are counted as activity, thus =
defeating --inactive
(21:44:02) dazo: jamesyonan:  I'm wondering if it is the proper way to do i=
t by doing c->c2.buf.len =3D 0; in ping.c, check_ping_send_dowork()
(21:44:41) waldner: ISTR the receiving code does that as well
(21:44:51) waldner: if length is 0, it's ignored
(21:45:02) waldner: and that is purposely set to 0 somewhere earlier
(21:45:25) jamesyonan: but why not count the ping packets as traffic but th=
en set a threshold on --inactive ?
(21:45:53) waldner: I think on a logical level, pings are not "traffic"
(21:45:57) jamesyonan: because there are other packets that may be automati=
cally generated that should not constitute activity
(21:46:03) waldner: yes, SSL negotiation packets
(21:46:10) waldner: and those were counted as well
(21:46:16) waldner: which imho is not correct either
(21:46:19) jamesyonan: not only that, but tunnel packets
(21:46:40) jamesyonan: with layer 2 tunneling, there will be broadcasts and=
 ARPs
(21:47:16) waldner: well, I'd say those are more "user traffic" than openvp=
n's administrative traffic anyway
(21:47:43) waldner: how would you suggest to go about it then?
(21:48:06) jamesyonan: so the idea with --inactive is that you don't want t=
o have to write an algorithm to determine what constitutes traffic, so you =
use the heuristic of traffic above a given threshold
(21:48:14) krzee: i agree layer2 chatter is user traffic
(21:48:58) waldner: jamesyonan: but that has proven problematic when --inac=
tive is used together with --ping
(21:49:12) waldner: because effectively --inactive was never kicking in
(21:49:17) dazo: yeah, and pings from inside openvpn, which only goes betwe=
en two openvpn processes are not user traffic
(21:49:21) waldner: even with no user traffic
(21:49:35) mattock: so how many "internal" types of traffic do we have whic=
h should not be counted?
(21:49:50) waldner: good question
(21:50:27) dazo: waldner:  jamesyonan suggested to have some clever algorit=
hm which would give a more sensible second --inactive argument, iirc ... --=
inactive can take two arguments
(21:50:55) waldner: isn't that what we're doing?
(21:51:16) waldner: if you set the second argument, ping packets are counte=
d towards that
(21:51:27) waldner: with my patch, they're not
(21:52:22) waldner: so the risk is that, depending on how often ping happen=
s, the counted bytes are never less than that second argument in the given =
period of time
(21:52:51) dazo: waldner:  you have a different approach here, where pings =
are not counted at all .... and jamesyonan suggested earlier to have a expe=
cted bytes counter for --inactive
(21:52:53) waldner: (if they're counted, I mean)
(21:53:05) waldner: dazo: there is already such a counter
(21:53:28) waldner: or I don't get what you mean
(21:53:45) dazo: waldner:  I mean that the default value would be more clev=
er calculated and not a fixed value as it is now
(21:54:02) jamesyonan: on the patch, are you sure that "Set length to 0, so=
 it won't be counted as activity" won't simply cancel the ping?
(21:54:21) waldner: jamesyonan: I checked and pings were sent
(21:54:21) waldner: dazo: no it's not fixed
(21:54:40) waldner: you can pass whatever value you want as second argument=
 to --inactive
(21:55:25) dazo: waldner:  yeah, but without giving this argument .... it i=
s a default fixed  value, it's this default value we wanted to look at maki=
ng more clever
(21:55:25) waldner: no, without that argument, it's just a timer which, aga=
in, is reset every time a ping is sent
(21:55:34) waldner: so "n" seconds of inactivity are never detected
(21:56:28) jamesyonan: I'm concerned that there might be cases where this p=
atch could would disable the outgoing ping, for example if crypto is disabl=
ed.
(21:56:28) waldner: jamesyonan: do you want me to perform more testing?
(21:56:28) waldner: I can surely do that
(21:56:28) dazo: waldner:  0 is also a default value ;-)
(21:56:28) jamesyonan: sure
(21:56:28) waldner: ok
(21:57:03) waldner: dazo: ok well, you win :)
(21:57:08) mattock: ok, so we've have had cries for help about this: http:/=
/article.gmane.org/gmane.network.openvpn.devel/3676/
(21:57:13) vpnHelper: Title: Gmane -- Mail To News And Back Again (at artic=
le.gmane.org)
(21:57:46) mattock: and this is the meeting where this was discussed last t=
ime: http://article.gmane.org/gmane.network.openvpn.devel/3673
(21:57:47) waldner: isn't that what we were just discussing?
(21:57:49) dazo: that's what started this discussion and which lead to wald=
ner's suggested patch
(21:57:52) vpnHelper: Title: Gmane -- Mail To News And Back Again (at artic=
le.gmane.org)
(21:58:18) mattock: waldner: yep
(21:58:33) mattock: I was sure we discussed this same thing earlier, just c=
ould not find out when
(21:58:37) mattock: now I did ;)
(21:58:43) waldner: ah ok
(21:58:57) mattock: just for the reference
(21:59:27) mattock: ok, so waldner will do some more testing
(21:59:37) waldner: yes
(21:59:45) mattock: and if everything works, the patch can be ACK'd, right?
(21:59:48) dazo: waldner:  if you can document your testing routine, with c=
onfigs preferably ... and some test results ... we can get more people eval=
uating the test scenario and to test it themselves to see if their findings=
 match our expectations
(22:00:03) waldner: I'll perhaps try different combinations of ciphers/no c=
iphers, also with certificates or with shared keys
(22:00:56) mattock: you can create a wiki page or Trac task
(22:00:58) dazo: if that passes, we can give it an ACK
(22:01:01) waldner: dazo: agreed, will do
(22:01:01) dazo: waldner:  that's my thought exactly :)  .... and if you ca=
n share those configs .... that'll help documenting how we've tested it, wh=
ich might make jamesyonan calmer as well :)
(22:01:01) waldner: sure, no problem
(22:01:07) dazo: waldner:  you probably also know there are certificates an=
d keys for testing already available in the source tree ....
(22:01:15) waldner: yes
(22:01:30) waldner: I do use them often when testing in fact
(22:01:34) ***dazo just wanted to be 120% sure :)
(22:01:38) dazo: perfect :)
(22:01:42) waldner: but in any case, I also have my set of certs and keys
(22:01:47) waldner: many, even
(22:02:18) jamesyonan: I'm happy with the patch, as long as we can prove th=
at it will never cause the ping packet to be dropped.
(22:02:26) waldner: cool
(22:02:31) ***dazo agrees with that
(22:02:36) mattock: waldner: have you registered to Trac already?
(22:02:39) waldner: +1
(22:02:50) waldner: mattock: mot yet
(22:02:53) mattock: or rather, our "Community Services Platform" ;)
(22:03:09) waldner: *not
(22:03:14) waldner: will do in the next days
(22:03:23) mattock: ok, remember to read the first paragraph on the Trac ma=
in page first
(22:03:24) waldner: I think a trac task is more suited
(22:03:33) mattock: agreed
(22:03:36) waldner: let's leave pages for real docs
(22:03:42) mattock: "Bayesian spam prevention is being teached and is not a=
ctive yet. This causes all edits to being rejected as spam, unless you defi=
ne your real name and email address in Trac-specific preferences. These are=
 not the same as those used during registration."
(22:03:45) waldner: ok
(22:04:17) mattock: actually, the Bayesian filter has been trained enough (=
unless it needs to eat spam too)
(22:04:25) mattock: haven't had time to check how to activate it
(22:04:33) waldner: ok, will do
(22:04:33) krzee: "teached" lol
(22:04:56) mattock: krzee: I guess "trained" would be more suitable ;)
(22:05:09) mattock: I'd fix that if my internet connection was faster (over=
 5kbps) ;)
(22:05:30) mattock: anything else for today?
(22:05:32) krzee: taught
(22:05:51) mattock: oh yes, of course
(22:05:52) krzee: oh i have one
(22:06:09) krzee: something i just learned from JJK's cookbook
(22:06:28) krzee: but i have never seen documented (correct me if im wrong)
(22:06:43) krzee: windows paths can use forward slashes instead of needing =
double backslashes
(22:07:16) krzee: that would go well in the howto in the sample configs whe=
re it talks about windows paths (and anywhere else that talks about win pat=
hs)
(22:08:26) dazo: good point
(22:08:51) krzee: i had to go test it when i read about it, i had never see=
n that before (and i think ive read all docs)
(22:09:10) mattock: regarding documentation in general... the "Puppet" proj=
ect has a system where all(?) documentation is written into a Wiki first. T=
hen, as it matures, it's moved to "official" (=3Dmostly read-only) document=
ation in their website
(22:09:21) mattock: perhaps we could use the same approach for our document=
ation
(22:09:37) waldner: +1
(22:09:48) krzee: +1!
(22:09:49) mattock: that way community could take part in writing the docum=
entation, but you'd still have some guarantee that the official documentati=
on is good
(22:10:08) mattock: =3Dnot full of misinformation
(22:10:17) dazo: mattock:  +1
(22:10:41) waldner: yes, community review too
(22:10:51) mattock: +1
(22:11:38) krzee: can that happen for the FAQ/howto as well?
(22:11:44) krzee: (not a big deal, but if it can... why not)
(22:11:51) dazo: +1
(22:12:14) mattock: I'll have to consult others about what to do with exist=
ing documentation
(22:12:27) mattock: I'm pretty sure nobody has anything against this plan
(22:12:56) waldner: yes agreed
(22:12:56) waldner: the docs on the official site look kind of stale-ish
(22:12:56) waldner: imho
(22:13:06) mattock: yep
(22:13:11) mattock: I don't think they're updated very often
(22:13:37) mattock: there are some technical hurdles, depending on the appr=
oach we take
(22:13:41) mattock: but no showstoppers
(22:14:27) mattock: krzee: I should get write access to openvpn.net communi=
ty section next week
(22:14:35) mattock: so please send me the fixes you have in mind
(22:14:41) mattock: anything else for today?
(22:15:03) mattock: or shall I go the sauna and swimming in Finland's bigge=
st lake?
(22:15:06) mattock: ;)
(22:15:14) mattock: to the...
(22:15:33) krzee: im offcially jealous
(22:15:42) krzee: its hurricane season here
(22:15:48) mattock: oh, I see
(22:16:14) mattock: but at least the water is warm there ;)
(22:17:17) mattock: here it's only 18 celsius, which is pretty "warm" for a=
 Finnish lake=20
(22:17:21) mattock: not sure about Fahrenheits
(22:17:50) mattock: ok, so nothing else?
(22:17:58) mattock: let's call this a day then!
(22:18:13) ***dazo needs to complete packing now
(22:18:32) mattock: going back or going hiking?
(22:18:57) mattock: back to Europe I mean
(22:19:01) dazo: thanks for a great meeting again!
(22:19:07) waldner: yes, good meeting
(22:19:08) mattock: thanks everybody!
(22:19:18) mattock: see you next week!
(22:19:19) dazo: going back ... plane goes in 5-6 hours
(22:19:28) mattock: don't expect the summary until Monday
(22:19:39) waldner: have a good flight
(22:19:51) dazo: c'ya!
(22:19:51) dazo: waldner:  thx!
(22:20:04) mattock: bye!
(22:21:22) dazo: bye!
(22:21:27) waldner: bye

--------------060804080403000104020400--

