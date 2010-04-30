Message-ID: <4BDAC9DC.8040505@...515...>
Date: Fri, 30 Apr 2010 15:15:24 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030404020406090309040903"
Subject: [Openvpn-devel] Summary of the IRC meeting (29th Apr 2010)
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
--------------030404020406090309040903
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 29th March 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-04-29>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed the VLAN tagging patchset. Agreed that "feat_passtos" branch
needs to be tested before VLAN tagging patches can be included in
"allmerged" branch. Feat_passtos patch was sent to -devel ml a while back:

<http://thread.gmane.org/gmane.network.openvpn.devel/3165>

Discussed tasks which we know we should do, but can't do immediately.
Agreed that we should start using Trac to track these. Samuli promised
to move existing content from Secure Computing "Open tasks" wiki page to
Trac.

Discussed Trac spam prevention. Agreed that some of the Trac wiki pages
should be protected against editing by "normal" authenticated users.

Discussed the "Using --inactive and --ping seems to defeat each other"
issue:

<http://thread.gmane.org/gmane.network.openvpn.devel/3556>

Agreed that we need to find a proper default value for --inactive
arguments (seconds & bytecount) which avoids OpenVPN pings from keeping
the connection open. Samuli promised to ask if our users could help us
with this issue. If that fails, a new Trac task will be created.

Discussed the "Avoid repetition of "this config may cache passwords in
memory" (v2)" issue:

<http://thread.gmane.org/gmane.network.openvpn.devel/3591>

James ACK'd the above patch.

Discussed the "Revamped the script-security warning logging (version 2)"
 issue:

<http://thread.gmane.org/gmane.network.openvpn.devel/3587>

James will give the above patch an ACK once it's changed to use the
openvpn_snprintf function. Dazo will take care of this small modification.

Discussed OpenVPN roadmap. Agreed to make the next Thursday's meeting a
dedicated "Roadmap" meeting. In this meeting James will present his
views of the future of OpenVPN 3.0 and it's relationship with 2.x
series. Discussion will be kept at a relatively high-level, without
going into gory details such as "OpenVPN 2.2 will include the following
features...". Agreed that users need to be involved in defining the
future of OpenVPN.

Discussed OpenVPN coding conventions / coding style. Agreed that we need
to use "GNU Indent" (or similar tool) to make sure all code is formatted
similarly. Agreed that some parts of the current code may have to
reformatted before forcing people to use a specific coding style.

Discussed code security issues. Agreed that all patches should be
checked with (security) auditing tools such as Valgrind and Coverity.
James promised to write the first version of "Coding security
guidelines" document, which can then updated as required.

Discussed problems with getting developers with no prior OSS development
experience involved. Samuli has noticed that many people who provide
useful patches are not confident enough to send them to the -devel
mailinglists. Agreed that something has to be done to lower the
(psychological) barrier of entry to OpenVPN development. Mentoring was
suggested as one possibility.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock





--------------030404020406090309040903
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-04-29.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-04-29.txt"

(21:06:25) mattock: james should be coming - at least he has not told me ot=
herwise
(21:07:51) mattock: should we begin with something that does not require / =
benefit from James' presence?
(21:09:36) mattock: ...
(21:10:26) dazo: I can just introduce fabiank on this channel is the one be=
hind the VLAN tagging patches ... and I hope he will be able to join our me=
etings in the future=20
(21:11:03) mattock: dazo: do we a specific goal regarding VLAN tagging patc=
hes today?
(21:11:19) ***fabiank waves
(21:11:31) mattock: hi fabiank!
(21:11:42) krzee: hey fabiank!
(21:11:47) dazo: not more than I'd like to see someone who understands VLAN=
 and the code paths being modified to give it a proper review
(21:12:17) dazo: Peter Stuge seems to have done a pretty decent overall ove=
rview, but nothing in-depths to the feature itself
(21:12:58) dazo: And we should probably combine this with the --passtos tes=
ting as well, as Fabian's patches are based upon that branch
(21:13:41) mattock: can the patchset be merged to "allmerged" once somebody=
 knowledgeable gives it an ACK?
(21:13:56) fabiank: Yes, it merges cleanly with allmerged.
(21:14:16) mattock: great!
(21:14:48) mattock: I just sent James mail, I hope he's coming
(21:14:58) dazo: yes, the overall code quality seems to be good for that, f=
rom what I could see ... but as this patch might have some interesting chal=
lenges against IPv6 branch ... it can be good to be sure VLAN is safe from =
a technical point of view
(21:15:15) dazo: fabiank:  ahh!  Cool you tested it!
(21:15:25) mattock: he might be able to give the VLAN patchset an ACK=20
(21:15:47) dazo: yeah, it would be good to have that done .... but!
(21:16:32) dazo: as VLAN patches are based upon feat_passtos .... which we =
have not received any testing feedback from .... that merge with VLAN will =
implicitly bring feat_passtos into allmerged as well
(21:16:45) fabiank: dazo: yes, I've created an internal allmerged branch (f=
smi_allmerged) which includes both the feat_vlan branch and another feature=
 I'm working on. This is / will be what we're basing our internal Debian pa=
ckage on and will be used in our testing setup.
(21:17:05) mattock: dazo: yep, that's a problem
(21:17:30) dazo: fabiank:  cool!  you may try to contact agi on this channe=
l ... he's the Debian package maintainer for OpenVPN as well
(21:17:56) dazo: mattock:  exactly
(21:18:30) mattock: james is coming in a minute
(21:18:34) dazo: fabiank:  how is feat_vlan_tagging related to feat_passtos=
 ... what code is shared here?  Are there code changes in feat_passtos whic=
h you don't need?
(21:18:36) fabiank: dazo: Ah, interesting.  We've based it on his Debian pa=
ckaging anyway, so everything fine on that end. :)
(21:18:56) fabiank: dazo: To be honest, I'm not sure of the exact scope of =
feat_passtos...
(21:19:17) mattock: who is responsible for the feat_passtos?
(21:19:19) fabiank: dazo: I'll see whether I can have a short look at a dif=
f.
(21:19:20) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(21:19:25) mattock: and is he/she working with us already?
(21:19:30) mattock: and if not, why not? ;)
(21:19:30) dazo: fabiank:  it's rather a simple patchset ... which makes su=
re the TOS flag is forwarded correctly over the tunnel
(21:19:36) mattock: hi james!
(21:19:45) jamesyonan: Hi everyone
(21:19:54) mattock: good you could attend!
(21:19:56) fabiank: dazo: Is it basically a single patch? Then I've looked =
at it already ...
(21:19:56) dazo: Hi, James!
(21:20:41) mattock: btw. the meeting topics are here: https://community.ope=
nvpn.net/openvpn/wiki/Topics-2010-04-29
(21:20:43) vpnHelper: Title: Topics-2010-04-29 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN (at community.openvpn.net)
(21:20:48) dazo: fabiank:  yeah, normally I'd put feat_passtos into feat_mi=
sc ... but we wanted some explicit testing of that branch to be sure it won=
't break anything and that it works as expected ... but nobody have respond=
ed to our testing request so far
(21:22:39) mattock: james, we've been discussing the vlan patchset
(21:22:44) fabiank: dazo: OK. If feat_passtos hadn't existed, I would have =
submitted the same code. Slightly different approach, but ... anyway.  (Dur=
ing my first patch-set attempt I didn't know of feat_passtos.)
(21:23:34) krzee: hey james!
(21:23:50) dazo: fabiank:  no problem ... and if you share code paths with =
feat_passtos ... it do make sense to base it here ... but that's the main c=
hallenge we have now to merge it into allmerged .... unless you share all t=
he code paths of feat_passtos
(21:24:40) dazo: we just need to be sure we get the code paths tested which=
 we change
(21:25:06) fabiank: dazo: My motivation would have been slightly different =
though.  If I understand the effects correctly, feat_passtos also allows th=
e packet filtering to filter based on IP addresses for ethernet packets tha=
t are tagged.
(21:25:42) fabiank: dazo: We'd share the code-paths, if we'd test the PF si=
de of things.
(21:25:54) dazo: fabiank:  that might be true ... I'm not experienced into =
the network packet layer, so I don't really know that
(21:26:15) dazo: fabiank:  that sounds pretty promising
(21:28:22) fabiank: dazo: Unfortunately, our planned installation doesn't r=
equire PF / passtos / mssfix stuff (yet?), so we would have to explicitly t=
est it.
(21:30:23) dazo: fabiank:  I see ... well, we will have to bring up the tes=
ting situation as a different agenda topic, as this is something we should =
be able to test out easily ... but if you're able to get some testing of th=
is, it would be great!
(21:31:18) mattock: anything else on VLAN tagging / feat_passtos?
(21:31:32) dazo: right now, I'm focused on getting you the needed ACK on th=
e patches so we can get it into allmerged ... but it requires some testing =
of the feat_passtos stuff right now too :(  that's the current situation
(21:31:47) dazo: mattock:  I don't think so ... unless fabiank has more to =
share :)
(21:32:23) mattock: dazo: any ideas how to test the feat_passtos? I think w=
e asked people to test it on the ml earlier, but got no test reports=20
(21:32:37) mattock: I think the patch has been "floating" since then
(21:32:53) dazo: mattock:  Didn't we get a little "test script" by the guy =
who wrote the patch?
(21:32:59) fabiank: I have nothing pending on the vlan stuff ... the last u=
pdate in response to Peter's review was all.
(21:33:19) mattock: dazo: might be, have to recheck that
(21:33:33) dazo: fabiank:  good!  And I'll be rebasing your feat_vlan_taggi=
ng branch this evening, to synch it on your proper branch
(21:33:48) dazo: mattock:  we might have wiki page with it as well, iirc
(21:34:07) mattock: dazo: good idea=20
(21:34:08) fabiank: Basically the priority in an 802.1Q frame should influe=
nce the TOS field of the tunnel's-IPv4 packet, right?
(21:34:55) dazo: fabiank:  that's how I've understood it ... jamesyonan?
(21:39:15) jamesyonan: Yes, basically the passtos concept is about moving p=
acket meta-data (like from the IP header) from the tunnel layer to the tran=
sport layer
(21:39:17) fabiank: I've had a short look: feat_passtos should allow IPv4 p=
ackets that are 802.1Q tagged to be properly examined for TOS, TCP MSS, DHC=
P router extraction and packet truncation checking.
(21:42:14) mattock: ok, shall we move on?
(21:42:22) dazo: I'm ready for that
(21:42:37) fabiank: Me too. :)
(21:42:44) mattock: so, in a nutshell, feat_passtos needs testing - somehow=
 :)
(21:43:13) mattock: are any of the topics especially crucial / important?
(21:43:21) mattock: or shall we start from the top, as always?
(21:43:55) dazo: sure :)  But I don't think we have anything new on the fir=
st topic though ... which changes things=20
(21:44:21) dazo: we're still missing someone who could help out on the Wind=
ows side
(21:44:42) mattock: true
(21:45:19) mattock: should we start using Trac tasks for things that should=
 be done, but nobody has volunteered?
(21:45:19) dazo: (fabiank:  I've just scratched the old feat_vlan_tagging b=
ranch ... and put out a new one with your feat_vlan branch as the base)
(21:45:35) dazo: mattock:  +1
(21:45:36) mattock: things like the InternetQueryOptions API update
(21:45:40) fabiank: (dazo: Great! Thanks. :) )
(21:45:51) mattock: with links to all background information
(21:46:02) dazo: that would be a good idea
(21:46:17) mattock: same for bugs we can't fix right away, of course
(21:46:29) dazo: +1
(21:46:39) mattock: and even for bugs which we do fix right away, as discus=
sed in last(?) meeting
(21:46:46) mattock: regarding Trac...
(21:46:59) mattock: the self-service registration service is now as ready a=
s it can ever be
(21:47:07) mattock: so we _could_ open Trac for wider audience
(21:47:16) mattock: however, I'm a little worried about spam and such
(21:48:08) mattock: I think we should protect the most essential content (e=
.g. developer docs) against changes by random people=20
(21:48:12) mattock: what do you think?
(21:48:17) dazo: no clever captcha stuff during registration?  Like the one=
s which secure-computing.net got .... gives you a math piece to solve
(21:48:31) mattock: dazo: there's reCAPTCHA for user registration
(21:48:43) mattock: but nothing in trac to prevent human spammers
(21:49:19) dazo: ahh ... well, let's open some pages for all ... and see ho=
w that goes, but I agree ... the crucial docs should not be too open, at le=
ast not in the beginning
(21:49:36) jamesyonan: agreed
(21:49:57) dazo: but if we compare against the changelogs on secure-computi=
ng.net wiki ... it's not too much action there
(21:50:17) mattock: I think we should not be too strict (e.g. like CentOS i=
s/was)
(21:50:36) mattock: dazo: I fear we'll have quite a lot of traffic once Tra=
c gets linked to from openvpn.net
(21:50:52) dazo: agreed ... so then it's just to decide which pages is cruc=
ial :)
(21:51:01) dazo: good point
(21:51:32) mattock: I'll take a look at what Trac offers on the page protec=
tion / spam prevention front and let you know via ml
(21:51:57) dazo: good :)
(21:52:07) mattock: and I'll move the "Open tasks" pages from secure comput=
ing to Trac tasks
(21:52:38) dazo: Ahh ... perfect!  I wasn't sure if you had moved that page=
, so I added one item there the other day, I believe
(21:52:56) mattock: I'll move it tomorrow
(21:53:51) dazo: Next item?
(21:53:54) mattock: yep
(21:53:57) dazo: Using --inactive and --ping seems to defeat each other htt=
p://thread.gmane.org/gmane.network.openvpn.devel/3556
(21:53:59) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:54:35) dazo: jamesyonan:  This one is one you might know something abou=
t .... could you use --inactive and --ping earlier on?
(21:55:12) dazo: this guy reporting this one claims that when --ping is ena=
bled .... it will never close the connection after the defined --inactivity=
 time
(21:56:03) dazo: From a quick code review, it seems to make sense though ..=
. and the guy is right ... these two should either work ... or be better do=
cumented that do not work together
(21:57:19) jamesyonan: remember that --inactive takes an argument (see man =
page)
(21:57:59) jamesyonan: i.e. the optional 'bytes' argument
(21:58:10) jamesyonan: if not specified, I believe that bytes defaults to 0
(21:58:18) dazo: hmmm ...=20
(21:58:22) krzee: i got off work early, see you guys later
(21:58:27) krzee: have a good meeting
(21:58:33) dazo: why did I believe it was seconds ....
(21:58:39) jamesyonan: so that means that even minimal traffic could keep t=
he tunnel open
(21:58:49) dazo: jamesyonan:  that makes sense though
(21:59:02) mattock: krzee: bye!
(21:59:10) jamesyonan: I'm referring to the second, optional parameter to -=
-inactive
(21:59:23) dazo: ahh ... yeah, I see
(21:59:40) dazo: well, then it's just to adjust that byte value higher
(21:59:47) jamesyonan: right
(21:59:48) dazo: how big are those ping requests?
(22:00:14) jamesyonan: tens or hundreds of bytes
(22:00:49) dazo: oki ... so setting it to 250 bytes, might actually behave =
closer to what's expected
(22:01:44) jamesyonan: so basically, you want to set inactive bytes high en=
ough so that the normal "chatter" of the open tunnel won't make OpenVPN thi=
nk that the tunnel is still active
(22:01:45) krzee ha abbandonato il canale (quit: Quit: Leaving).
(22:02:16) dazo: jamesyonan:  should we consider to raise the default byte =
count in --inactive?  So that normal pings do to keep it open?
(22:02:35) jamesyonan: yeah, that probably makes sense
(22:03:42) dazo: mattock:  can you put up in the open tasks list? .... Expe=
riment with finding a proper --inactive byte count value so --ping requests=
 are ignored=20
(22:03:50) mattock: will do
(22:04:05) dazo: thx!
(22:04:14) mattock: perhaps we could ask users on the ml before we do that,=
 though
(22:04:27) jamesyonan: it's tricky to default it to a constant because it n=
eeds to be larger as the number of seconds parameter increases
(22:04:39) dazo: true
(22:05:27) mattock: what if I ask users if they could test this... if that =
fails, but it to a Trac task
(22:05:29) dazo: but the default could be    (seconds * byte_count_factor)
(22:05:32) ecrist: mattock: when is the forum going to be up?
(22:05:39) mattock: ecrist: depends on us :)
(22:06:03) mattock: self-service registration service is ready and Trac onl=
y needs a few plugins / tweaks
(22:06:10) mattock: after that we can move on to forums
(22:06:14) ecrist: since I have some keys to that castle, email me a task l=
ist and I'll get to work on it.
(22:06:54) mattock: ecrist: I can handle the basic server configuration tas=
ks if you manage the phpbb stuff
(22:07:12) ecrist: sure.
(22:08:39) dazo: next?
(22:08:55) mattock: yep
(22:09:07) dazo:     * Avoid repetition of "this config may cache passwords=
 in memory" (v2)  -- http://thread.gmane.org/gmane.network.openvpn.devel/35=
91
(22:09:08) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(22:09:34) mattock: anybody care to ACK that?
(22:09:41) dazo: this one I have tested in prod ... and it seems to work pr=
etty well
(22:09:59) dazo: fabiank:  you are also most welcome to give ACK's to mails=
 on the ML :)
(22:10:30) mattock: the more devs we have giving ACK's, the better
(22:10:37) fabiank: dazo: Ah ok, I see.  Thanks for mentioning that. :)
(22:10:39) dazo: exactly! :)
(22:10:53) jamesyonan: this seems reasonable
(22:11:17) mattock: currently some stuff manages to "slip" away without an =
ACK
(22:11:30) mattock: even if the patch is relatively trivial
(22:11:54) mattock: jamesyonan: is that an ACK?
(22:12:15) jamesyonan: ack
(22:12:41) dazo:   * Revamped the script-security warning logging (version =
2) -- http://thread.gmane.org/gmane.network.openvpn.devel/3587
(22:12:42) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(22:13:34) dazo: this is a bigger one ... but fixes what we discussed last =
week or so ... removing a --script-security warning unless when absolutely =
needed ... and does it only once
(22:16:57) jamesyonan: looks pretty good -- BTW, you can say: openvpn_snpri=
ntf(msg, sizeof(msg), ...
(22:17:46) dazo: ahh! true!
(22:18:19) mattock: jamesyonan: is it an ACK with that change?
(22:18:27) jamesyonan: yes
(22:18:28) dazo: jamesyonan:  If I get an ACK, I can promise to fix that on=
e on the fly
(22:18:40) krzie: !learn wishlist as http://ovpnforum.com/viewforum.php?f=
=3D10 for the openvpn wishlist
(22:18:40) vpnHelper: krzie: Error: You don't have the factoids.learn capab=
ility. If you think that you should have this capability, be sure that you =
are identified before trying again. The 'whoami' command can tell you if yo=
u're identified.
(22:18:42) ***dazo will fix
(22:18:57) krzie: !learn wishlist as http://ovpnforum.com/viewforum.php?f=
=3D10 for the openvpn wishlist
(22:18:57) vpnHelper: krzie: Joo got it.
(22:20:38) dazo: We've been through the next one already ... PULL-REQUEST f=
or VLAN-Tagging ...
(22:21:38) dazo: Unless someone wants/need a status update on "In progress"=
 and "awaiting testing before ACK" items ... we can go to "Other" items
(22:23:13) ***dazo will put a little bit more information on those items to=
 next week
(22:23:13) mattock: ok, "other" is fine by me
(22:23:49) dazo: Community site - Trac config ... that's been discussed
(22:23:52) mattock: yep
(22:23:54) dazo: Roadmap'
(22:24:04) dazo: this is a biggie ...
(22:24:10) mattock: yep, it is
(22:24:30) dazo: should we allocate one meeting for this topic alone, maybe?
(22:24:41) mattock: sounds like a good idea
(22:25:35) mattock: I think I intended to start discussion about roadmap an=
d something else this week... but somehow managed to forget
(22:25:54) mattock: on the mailing list I mean
(22:26:19) dazo: ahh ... yeah, that sounds familiar, somehow :)
(22:26:43) mattock: should we have a separate "roadmap" meeting in addition=
 to our usual meeting... or should we just replace the usual meeting?
(22:27:23) jamesyonan: I would vote to replace the usual meeting
(22:27:29) dazo: I was thinking about that as well .... but I thought that =
peoples schedules might be pretty packed already .... but if it is announce=
d ahead of time, more people might be able to plan it better
(22:28:41) mattock: I think we should try to keep as much of the roadmap di=
scussion as possible on the mailing list
(22:29:43) mattock: and use the IRC where it makes most sense
(22:30:02) dazo: true ... but to get started, to get a kind of framework to=
 start working from - that might need a meeting
(22:30:16) mattock: dazo: agreed
(22:30:46) mattock: I'll check what I promised last week and then do it :)
(22:31:02) mattock: shall we have the roadmap meeting next week?
(22:31:37) jamesyonan: that works for me
(22:32:28) mattock: let's try to prepare that meeting as well as possible
(22:32:43) dazo: sure ... let's get a quick announcement about it as soon a=
s possible as well
(22:33:03) mattock: so that we know what issues we need to solve somehow
(22:33:16) mattock: dazo: I'll send an announcement tomorrow
(22:33:16) dazo: mm
(22:33:21) dazo: good!
(22:33:23) mattock: should we send it to -users as well as -devel?
(22:33:38) mattock: I think -devel suffices - what do you think?
(22:34:09) mattock: =3Dis enough
(22:34:10) dazo: hmm .... not sure, but I tend to lean towards both .... fo=
r the announcement .... and then the discussion after the meeting will go o=
n -devel=20
(22:34:38) dazo: but doing it on -users can cause more traffic and maybe so=
me unneeded noise
(22:34:49) ecrist: IMHO, if people want -devel traffic the should subscribe=
 to the right thing
(22:35:01) mattock: ecrist: good point. Ok, so what exactly shall we discus=
s on the roadmap meeting?
(22:35:03) ecrist: s/the//
(22:36:07) mattock: will it be high-level stuff (like the questions listed =
on today's topics)?
(22:36:29) mattock: or shall we discuss concrete issues (like what features=
 will be included in next release
(22:36:31) mattock: ?
(22:36:55) ecrist: I think roadmap meetings should discuss things users can=
 get more involved in
(22:37:14) dazo: The result should be some kind of milestone skeleton .... =
with some estimates for deadlines and if possible who will be responsible i=
n keeping the tasks
(22:37:23) ecrist: sometimes, it's not always good to only have developers =
at the helm, but to allow users to influence the course a bit.
(22:38:06) dazo: mattock:  yes, it needs to be more high-level ... because =
with a roadmap we will have these weekly meetings to follow up the progress=
 on the roadmap
(22:38:17) dazo: with the gory low-level details=20
(22:38:27) dazo: ecrist:  +1
(22:39:29) mattock: ok, what if we keep the "roadmap meeting" high-level an=
d then discuss the concrete issues ("what will be on next release") on the =
mailing list
(22:39:59) dazo: If jamesyonan could give a more detailed "presentation" on=
 that meeting of where he sees OpenVPN should go further, what problem we h=
ave with the current state and where he sees us headed ... and then take th=
e discussion from there
(22:40:22) jamesyonan: yes, I can do that
(22:41:52) mattock: ok, I guess that's settled then
(22:42:04) mattock: agreed?
(22:42:53) dazo: the next thing we need to clarify is to somehow document t=
he process of getting stuff from openvpn-testing.git into the stable trees
(22:42:55) jamesyonan: my presentation will probably be more far-sighted, i=
.e. looking more towards 3.0 than 2.2
(22:43:04) dazo: that's fine enough!
(22:43:17) mattock: dazo: yep, that's very important
(22:44:00) mattock: currently we have testing (git) and stable (svn) but th=
ey're pretty separate
(22:44:19) mattock: there's no clear process leading from a patch to release
(22:44:27) dazo: that process needs to clarify conditions for patches to go=
 into the stable tree ... how to document that ... and then the practical m=
erge
(22:46:13) dazo: jamesyonan:  I'm seeing that a 2.2 and releases up to 3.0 =
will all kind of be gradually moving the code base more and more over to wh=
at we want to see in 3.0 ... or am I thinking of this wrong?
(22:46:40) mattock: dazo: I think we agreed in a meeting we should at least=
 try to do that
(22:47:01) mattock: to make the jump from 2.x to 3.0 as small as possible
(22:47:28) mattock: otherwise we'll run into a number of problems
(22:47:30) dazo: mattock:  ahh ... I had a strong feeling this was not new =
thoughts :)
(22:48:05) mattock: if we move towards 3.0 in small increments the 2.x seri=
es is not "competing" against 3.0 as it would if 3.0 was a complete rewrite
(22:48:07) jamesyonan: it's possible but tricky to reach 3.0 incrementally
(22:49:04) mattock: perhaps we could document what needs to be done, where =
a complete rewrite is required, where we could move forward incrementally e=
tc
(22:49:20) mattock: then we'd know better what approach to take
(22:49:27) jamesyonan: in 3.0 I would like see a revamped i/o event layer a=
nd an internal architecture that more closely mirrors a general network sta=
ck
(22:49:35) dazo: mm ... some parts of the 3.0 base must be written from scr=
atch ... that would be expected ... but if the we can modularise better thi=
ngs in the 2.x path, it can more easily be used in 3.x
(22:50:18) jamesyonan: maybe we can bring in a new library to handle the ev=
ent layer such as libevent
(22:50:29) dazo: mm
(22:52:20) dazo: the encryption layer might also be possible to modularise =
already during 2.x
(22:53:02) mattock: what if we try to figure out what 3.0 will be like and =
then dig into the code to get a better idea what's involved?
(22:53:11) dazo: yupp
(22:53:30) mattock: shall we move on to "Coding style guidelines"?
(22:53:41) mattock: that'd be the last issue...
(22:54:37) dazo: jamesyonan:  this one you might be able to answer better .=
.. but do you use any indenting tools to make sure the code follows one sty=
le for your work?
(22:54:53) dazo: and what "parameters" do you keep your style after?
(22:55:01) dazo: (bad grammar)
(22:55:03) jamesyonan: well, there's always gnu indent
(22:55:56) dazo: could we find some good parameters for gnu indent which we=
 can instruct those sending patches to use?
(22:55:59) jamesyonan: early on in the project, I actually ran the code thr=
ough gnu indent a few times, and then maintained that style going forward
(22:57:12) mattock: I've seen quite a lot of style discussions on the ml la=
tely... how strict style guidelines do we want?
(22:57:56) dazo: I would prefer a rather strict guideline ... as mixing cod=
ing styles is even worse than any bad coding style
(22:58:27) mattock: dazo: how much of that can be achieved with a tool like=
 GNU indent?
(22:58:38) dazo: mattock:  basically everything :)
(22:59:09) dazo: even though, I'm not a big fan of the current style ... I'=
d rather keep something close to what the majority of the code uses now, th=
an to get a lot of mixed styles into the code
(22:59:28) mattock: I remember seeing discussion about if - then - else blo=
cks vs. some other approach... can indent fix that kind of stuff?
(22:59:36) dazo: mattock:  yes
(22:59:49) mattock: oh, that's pretty advanced, then :)
(23:00:00) mattock: can we reverse-engineer indent parameters from the code?
(23:00:04) dazo: mattock:  you can completely reformat the whole code to wh=
atever coding style you define ... it's all controlled by the arguments to =
indent
(23:00:05) fabiank: Whether or not GNU indent would work might depend on ho=
w unified the code style is currently.  A patch probably shouldn't touch un=
related code pieces and running GNU indent might cause unrelated parts to b=
e changed ...
(23:00:23) dazo: fabiank:  good point!
(23:00:45) dazo: we might actually need a "clean up coding style patch" bef=
ore we start enforcing it
(23:01:31) mattock: jamesyonan: do you use some tools to check the code for=
 security problems, memory leaks etc.? or does gcc handle all of that autom=
atically?
(23:01:49) jamesyonan: I usually use valgrind
(23:01:51) mattock: also, should the patches go through such tools?
(23:02:03) jamesyonan: yes, I would highly recommend that
(23:02:31) ***dazo usually tests his stuff regularly with valgrind to look =
for memleaks and other memory related issues
(23:03:04) jamesyonan: Also: there's a company called Coverity that has a t=
ool set that does compile-time checking for bugs and security issues
(23:03:23) jamesyonan: as an open source project, we can freely use Coverit=
y's tool
(23:03:54) mattock: ok, so we'd need a "fix indent patch", publicly availab=
le GNU indent parameters, documentation on how to use valgrind/coverity
(23:03:56) mattock: ...
(23:04:08) mattock: -> more developers docs and patch requirements
(23:04:23) dazo: mattock:  basically, yes
(23:04:46) jamesyonan: we should add a doc on "coding security guidelines" =
as well
(23:05:08) dazo: yes!
(23:05:24) mattock: jamesyonan: could you write the first version of that d=
ocument?
(23:05:38) dazo: jamesyonan:  would you have time to put up a kind of skele=
ton here, of what you find crucial and imp....... mattock was quicker
(23:05:50) jamesyonan: It's on my todo list
(23:06:15) dazo: jamesyonan:  if you get some skeleton out ... I can sure h=
elp filling out some of the gaps
(23:06:23) jamesyonan: cool
(23:06:30) mattock: btw. many devs are frightened of sending patches to mai=
ling lists... especially after I give them the link to "patch requirements"
(23:06:50) mattock: I was wondering whether we should have something to cat=
er for devs who are not used to OSS development
(23:07:21) mattock: for example, the guy who wrote the OSX keyring patch ne=
eded some encouragement before he dared send his patch to the list
(23:07:33) mattock: I was wondering whether a "mentoring" thing could help =
here
(23:07:38) dazo: well, yes and no .... if the documentation is difficult to=
 understand ... but if we could tell them "run this script before you commi=
t your patch" .... and that points out problems or fixes the simple issues =
... then a lot is done
(23:08:04) dazo: mattock:  you think I scared him away? :)
(23:08:19) ***dazo sure hope he didn't scare him
(23:08:24) mattock: hope not, but if you did, I can encourage him again :)
(23:08:36) dazo: :)
(23:08:37) mattock: "no, dazo's not really like that, really..." :)
(23:08:45) dazo: hehe :)
(23:09:08) mattock: anyways, I'll try to think of a way for OSS noobs to ge=
t into OpenVPN development without getting scared away
(23:10:03) mattock: several of the devs I've pointed to devel docs have not=
 been heard from since then, so this is a real problem=20
(23:10:07) dazo: but some people who send patches also have the idea that "=
the others will fix it!" ... and we're not garbage collectors either ... bu=
t if my responses are too harsh or not appropriate, please let me know!
(23:10:31) dazo: that's worrying!
(23:10:36) mattock: dazo: agreed... the patch authors need to be responsibl=
e for their stuff
(23:11:02) mattock: dazo: we're talking about maybe 4-5 patches here
(23:11:34) dazo: mattock:  well, that's many enough to get worried .... we'=
re getting more and more patches, but 4-5 more wouldn't hurt us
(23:12:04) mattock: I'm tracking these guys now and will send at least one =
"encouragement" email to each dev who hasn't sent the patch the -devel afte=
r I asked them to
(23:12:23) dazo: that's cool! :)  And clever!
(23:12:32) dazo: but having that said, the amount of patches now being sent=
 to the ML is increasing! :)
(23:12:38) mattock: yep, it is
(23:13:57) mattock: I wonder what happens once Trac is linked to from openv=
pn.net... I think the majority of people don't know our development model h=
as changed=20=20
(23:14:08) mattock: and that probably includes some devs, too
(23:14:14) dazo: good point!
(23:14:44) mattock: do you think we're done for today?
(23:14:51) mattock: it's getting late here
(23:15:36) dazo: yeah, I think we are :)
(23:15:57) mattock: ok, so "Roadmap" meeting next week
(23:16:04) mattock: I'll announce it tomorrow on -devel
(23:16:11) dazo: perfect!
(23:16:27) mattock: ok, good night guys!
(23:16:34) dazo: good night!
(23:16:38) jamesyonan: take care
(23:16:54) mattock: see you later
(23:17:18) fabiank: bye bye :)

--------------030404020406090309040903--

