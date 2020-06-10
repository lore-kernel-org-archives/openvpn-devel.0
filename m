From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <cde19afd-b6cb-3b99-b346-1cfcdcebbbe2@...515...>
Message-ID: <b1b1c5da-6fc6-663b-41f7-75bc77310c8e@...515...>
Date: Wed, 10 Jun 2020 14:00:00 +0300
MIME-Version: 1.0
In-Reply-To: <cde19afd-b6cb-3b99-b346-1cfcdcebbbe2@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qFC7yGJnZaPo556BhdxgHVu0wCZHT6Fa4"
Subject: [Openvpn-devel] Summary of the community meeting (10th June 2020)
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
--qFC7yGJnZaPo556BhdxgHVu0wCZHT6Fa4
Content-Type: multipart/mixed; boundary="q5X0naP5K5sAdVcdIdXMIKptGR5Y54lXp"

--q5X0naP5K5sAdVcdIdXMIKptGR5Y54lXp
Content-Type: multipart/mixed;
 boundary="------------EF8425C6AEFC94948D4839F9"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------EF8425C6AEFC94948D4839F9
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 10th June 2020
Time: 11:30 CEST (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-06-10>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, ordex, plaisthos and uip participated in this meeting.

---

Talked about deprecating net30 topology. Agreed that in 2.5 we should
print a deprecation and warning:

"Topology net30 support will be removed in a future release. Please
migrate to topology subnet as soon as possible"

The client-side code is less harmful, so it can stay a bit longer than
the server-side code.

Noted that there are ways to work around lack of net30. Also agreed that
we should document those workarounds.

---

Had a lengthy discussion about deprecation/removal of obsolete options.
An option that was brought up was having "config levels" which would set
reasonable, modern defaults for several settings. The config level would
have to be defined explicitly by the user and the actual defaults would
not be touched.

Nobody was opposed to cron2's suggestion, which was "write up a list,
agree on what the goal should be, and whether we can get there with
negotiations or not".

---

Talked about the release schedule for OpenVPN 2.5. Agreed that given how
far we are now releasing 2.5-beta1 on 30th June is doable, followed by
2.5-rc1 on 3rd August. The 2.5.0 release would happen around 15th August.

---

Talked about dazo's man-page patches. The man-page is now split into
multiple sections:

<https://gitlab.com/dazo/openvpn/-/tree/dev/man-reformatting/doc/man-sectio=
ns>

Options in each section are currently sorted alphabetically. As the next
step we need to get people to review the section contents and the order
of the items to make sure they make sense.

---

Noted that the IPv6-only patchset is now merged.

Also noted that cron2 will merge the non-SSO patches "really soon now".

--

Full chatlog attached

--------------EF8425C6AEFC94948D4839F9
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-06-10.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-06-10.txt"

(12:28:01) ***uip says hi!
(12:29:09) dazo: hey!
(12:29:47) cron2: ho
(12:31:05) ordex: hi
(12:31:18) mattock: hi!
(12:32:39) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
0-06-10
(12:32:41) vpnHelper: Title: Topics-2020-06-10 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:33:17) ordex: revised timeline!
(12:33:43) cron2: I have updated the StatusOf25 (or how it is called) pag=
e with a new proposed timeline
(12:33:51) cron2: discuss and agree or not :-)
(12:33:58) plaisthos: hey
(12:34:33) plaisthos: net30 deprecation, no problem for me
(12:34:54) plaisthos: It is hack anyway
(12:34:58) mattock: https://community.openvpn.net/openvpn/wiki/StatusOfOp=
envpn25
(12:34:59) vpnHelper: Title: StatusOfOpenvpn25 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:35:27) dazo: I don't think we can remove net30 ... it will break an i=
ncredibly amount of configs, as that has been the default since at least =
2.0
(12:35:53) cron2: my idea was
(12:35:56) dazo: I agree to deprecate it, maybe even switch to subnet as =
default ... but I don't think we can remove it easily
(12:36:04) cron2:  - announce depreciation for 2.6 now
(12:36:18) cron2:  - but leave it "as it is" in 2.5, except for a warning=
 message
(12:36:53) cron2: changing the default alone won't really do much good, a=
s we'd still have to maintain all the special cases
(12:37:14) ordex: I agree this this plan
(12:37:34) dazo: Don't get me wrong, it would be good to see it gone.  I'=
m even open to accept that certain features won't work with net30 ... but=
 I fear 2.6 might be too early to see it gone
(12:37:40) cron2: we might decide to only depreciate it - and only remove=
 it - for the server side initially
(12:38:07) ordex: if we add the warning now..we give people at least anot=
her year before it will break
(12:38:09) plaisthos: we have to deprecate it if we want to remove it=20
(12:38:09) dazo: what is the challenge with net30 today?
(12:38:20) plaisthos: messy=20
(12:38:27) dazo: yes, deprecate should be done
(12:38:27) ordex: legacy stuff that has no real reason to exist ? :D
(12:38:34) cron2:             switch (pool->ipv4.type)
(12:38:37) cron2:                 case IFCONFIG_POOL_30NET:
(12:38:39) cron2:                 case IFCONFIG_POOL_INDIV:
(12:38:41) plaisthos: we also need something that sets better defaults
(12:38:57) plaisthos: we have a lot defaults that do not make sense today=
 anymore
(12:39:07) cron2: dazo: it affects how pools are handled, and that is qui=
te a bit of senseless code in pool.c
(12:39:17) cron2: plaisthos: yeah
(12:40:13) cron2: tun.c is actually fairly harmless, so we can keep the c=
lient side of net30 around for longer
(12:41:05) plaisthos: even with pool code gone you can do it manually wit=
h client-conn
(12:41:22) dazo: If removing net30 is mainly code cleanup in pool.c ... I=
'm not sure we're in such a hurry.  But I agree, add deprecation warning =
in 2.5
(12:41:22) cron2: if you insist, yes :)
(12:41:51) cron2: dazo: pool.c, helper.c, multi.c.  Quite a bit of extra =
code that needs to be stared at when reworking bits.
(12:42:48) dazo: that's a good point, plaisthos ... getting a workaround =
well documented would ease migration for those who really cannot do anyth=
ing else currently.  And having client support for some time is also reas=
onable
(12:43:13) ordex: dazo: remember that this is not only about "clean up", =
but about time we have to spend to make sure we don't break this feature =
when introducing other changes
(12:43:25) ordex: +1 for the workaround documentation
(12:43:50) dazo: yeah, but I would also avoid getting lots of complaints =
on "OpenVPN 2.x broke my config!"
(12:43:50) cron2: yes
(12:44:19) plaisthos: I would assume 90% of config that currently use net=
30 will also work with subnet
(12:44:33) plaisthos: but we have a plan forward
(12:44:35) cron2: dazo: this is why we warn now, so people can adjust bet=
ween 2.5 and 2.6=20
(12:44:47) plaisthos: cron2/ordex: are you preparing a patch?
(12:44:49) dazo: So ... to not spend too much time back-and-forth here ..=
=2E. I think there is consensus that we add net30 deprecation notice in 2=
=2E5, clearly stating it will be removed in a future release.  But I thin=
k we need to see the response in the community if we can remove it on the=
 server side already in 2.6
(12:45:21) plaisthos: for better defaults: Do we want something like conf=
ig-version x?
(12:45:33) cron2: plaisthos: yes (patch)
(12:45:44) plaisthos: that would then set a number of default like cipher=
, explicit-exit-notify etc?
(12:45:48) dazo: cron2: there is an urge from the company side to get 2.6=
 quicker out, primarily with kernel module support as the main feature ..=
=2E which might be a too quick turn-around for deprecating a feature
(12:46:27) ordex: dazo: we can set a timeline "in a year from now" and we=
 remove it at the next release after that date
(12:46:40) ordex: which could be 2.6 or 2.10
(12:46:53) dazo: ordex: that's a reasonable plan as well
(12:47:29) cron2: we're not going to have 2.10 in a year :-)
(12:47:44) ordex: :D think so too, but it was just an example hehe
(12:47:48) dazo: plaisthos: that's a good idea ... config-defaults $OVPN_=
VERSION (would be my vote, if we start painting the bike shed :-P)
(12:48:44) cron2: #1288
(12:49:17) ordex: config-defaults << so we're planning to have "different=
" series of defaults ?
(12:49:22) ordex: or is it for backward compatibilities ?
(12:49:33) dazo: So ... conclusion is:  net30 deprecate warning in 2.5, s=
tating it will be removed a release no later than December 2021?
(12:49:35) ordex: this way you can restore the old defaults ?
(12:49:55) dazo: ordex: yes, for backward compatibility
(12:50:19) ordex: dazo: better state "will be removed in a release not ea=
rlier than July 2021" - to guarantee that until that dtae it will work fo=
r sure
(12:50:35) ordex: after july 20201 will be removed with the first release=
 we have on the roadmap
(12:50:35) cron2: "in a future release" is good enough
(12:50:50) plaisthos: dazo: $OVPN_VERSION does not work great for ovpn3. =

(12:51:03) dazo: no commitment on when ... just a "future release ... I'm=
 fine with that
(12:51:12) plaisthos: or do we want that same 2.x version in both?
(12:52:02) dazo: so ... conclusion: 2.5 Deprecation warning: "Topology ne=
t30 support will be removed in a future release. Please migrate to topolo=
gy subnet as soon as possible"
(12:52:31) cron2: dazo: works for me. can you put this text into #1288?
(12:53:14) dazo: plaisthos: I think so, yes .... OpenVPN 3.x can use the =
same 2.x numbering ... and if OpenVPN 3.x adds features not planned to be=
 supported in 2.x, it will have the OpenVPN 3 Core version
(12:53:40) dazo: cron2: sure!
(12:54:50) ordex: dazo: it sounds like we will enter numbering mess very =
soon :D how about documenting the various defaults so that somebody can t=
urn them on manually one by one as he see needs ?
(12:55:10) ordex: without us maintaining huge compatibility tables
(12:56:50) dazo: The alternative is to have a "config level ID" instead .=
=2E.. where we would need to document which releases supports the various=
 config levels ... so instead of documenting that as text, have a mapping=
 table for the OpenVPN versions to such levels in code.
(12:58:32) plaisthos: you would need that anyway
(12:58:48) plaisthos: like config version 2.5 is supported in openvpn 2.x=
 and openvpn 3.7
(12:59:02) dazo: well, yeah, true
(12:59:11) cron2: but we should be careful what we intend to use that for=

(12:59:15) dazo: (Once this topic is done ... I'd like to bring up the ma=
n-page work .... I'd like to hear your input on a change I prepared yeste=
rday)
(12:59:33) cron2: for stuff like cipher, having full NCP is much better t=
han maintaining compat tables
(12:59:49) plaisthos: yeah
(12:59:58) cron2: for stuff like net30, the point of getting rid of it is=
 "get rid of the code", so a compat table won't make us happy campers
(13:00:05) plaisthos: for cipher the problem is the hardcoded BF-CBC that=
 a client always has to support
(13:00:45) dazo: there are two aspects ... depending on what we call the =
option .... config-version vs config-defaults .... the former can indicat=
e which options is supported, through documentation (and can set the defa=
ults) ... while the latter one would be more scoped at default values
(13:01:04) plaisthos: yeah config-defaults more like it
(13:01:09) cron2: this
(13:01:47) dazo: agreed
(13:03:39) dazo: well, using a single digit indicating the defaults or Op=
enVPN version ... I'm fine with both.  But I think it might be easier to =
understand OpenVPN versions for users than an unrelated digit
(13:04:31) dazo: "I want the default values as defined in OpenVPN 2.6" ..=
=2E. vs  "I use config-defaults 2, as that is the defaults in OpenVPN 2.6=
"
(13:04:51) cron2: I wonder if that makes any sense at all, tbh
(13:05:16) cron2: if someone is clueful enough so they know "ah, I need t=
hose old defaults", they can just set those config options directly
(13:05:22) cron2: why is=20
(13:05:25) cron2:   config-defaults 2
(13:05:26) cron2: better than
(13:05:29) cron2:   cipher BF-CBC
(13:05:33) cron2:  auth SHA1
(13:05:47) cron2: (or whatever defaults are packed in there)
(13:06:11) dazo: because existing configs upgrading will keep the old def=
aults ... users setting up new server only adds --config-defaults 2 and g=
et a lot more options set to sane values by default in one go
(13:06:20) plaisthos: We basically never change default in openvpn
(13:06:30) dazo: exactly
(13:06:41) cron2: so you would leave the defaults *unchanged*, and requir=
e "config-defaults 2" to get "more sane defaults"?
(13:06:44) plaisthos: the problem with that is that we still in 2020 defa=
ult to a cipher that nobody should use anymore
(13:07:07) dazo: so --config-defaults 2 could mean --topology subnet --au=
th sha256 --cipher AES-128-GCM
(13:07:11) cron2: I totally fail to see under which conditions this optio=
n would make sense
(13:07:26) plaisthos: cron2: do you have a better idea without killing ho=
ly cow of backword compatbility?
(13:07:37) cron2: kill holy cow in cases where the cow is dead anyway
(13:07:39) dazo: (not that --auth and GCM makes sense, but yeah, you get =
the picture)
(13:08:17) cron2: like, if we have reasonable mechanisms to deal with tha=
t cow, like NCP, document change, done
(13:08:25) plaisthos: if I submitted a patch now that changed cipher defa=
ult from BF-CBC to AES-256-GCM I don't think it would get merged
(13:08:34) dazo: exactly
(13:08:35) cron2: changing cipher default, to stick to that example, will=
 ONLY hurt p2p setups, or --ncp-disable setups
(13:08:47) dazo: And we should never deliberately break users configs unl=
ess strictly needed
(13:09:09) plaisthos: cron2: yeah but the options like subnet
(13:09:10) dazo: and if we do default changes which breaks existing confi=
gs ... we need to warn well ahead of time
(13:09:31) plaisthos: where we want to change the default but do not want=
 to break stuff
(13:09:34) cron2: plaisthos: that's an option that you cannot "compat" - =
if you get rid of that code, it is no longer there
(13:09:55) plaisthos: cron2: no as in makeing subnet the default in 2.5=20
(13:10:04) cron2: but we do not want to do so
(13:10:08) plaisthos: while net30 is still supported
(13:10:17) cron2: because that would indeed cause surprises
(13:10:22) plaisthos: yeah
(13:10:39) plaisthos: so we that is why we need some solution to "Apply t=
he current best default defaults"
(13:11:00) cron2: anyway.  Before we go forward with this, I think it sho=
uld be clear *which* options we're talking about, who exactly would be af=
fected if we change the defaults
(13:11:22) dazo: config-defaults in 2.5 would actually make sense ... whe=
re config-defaults {2.5|1} would mean --topology subnet being the default=
 (together with a other saner defaults in other options) .... users can t=
hen just add a single option to get to a more modern standard default
(13:12:18) cron2: users would not upgrade their defaults, because, that w=
ould break their setups.  No?
(13:12:21) dazo: in OpenVPN 2.8 ... we can add a warning "--config-defaul=
t 0 will be unsupported in the next release" ... then --config-default 1 =
will be come the new defaults, and slowly over time force users to move f=
orward as well
(13:13:20) cron2: this sounds like a very complicated (and labour- and te=
sting-intensive) approach to not getting things done, really.
(13:13:28) dazo: Which also means we have a better mechanism to handle a =
lot of default settings as a group, instead of deprecating modes and defa=
ults on a per-option basis
(13:14:28) dazo: using --config-defaults 1 ... then you know, these set o=
f options are expected to break ... so you slim down the scope over time.=

(13:14:32) cron2: see above: let's be clear what we are talking about.  "=
topology" only makes limited sense, as we want to get rid of the code (so=
 we'd have that "upgrade-default" thing for exactly one release, and then=
 it's gone anyway, so the breakage for all non-upgraded configs would hap=
pen all the same)
(13:14:53) dazo: but we have closer to 300 options ... all with various d=
efaults defined 20 years ago
(13:15:26) plaisthos: cron2: Do you have bettter ideas?
(13:15:26) cron2: anything where we are no longer supporting "the thing t=
hat used to be default" can not be handled by "option-default $later" wit=
hout just postponing breakage for everybody who has *not* added said opti=
on
(13:15:53) cron2: plaisthos: yeah.  Understand what we're talking about, =
add proper negotiation mechanisms, or deprecate "we want to get rid of th=
at code"
(13:16:07) cron2: cipher, for example, is solved for standard p2mp setups=
 already
(13:16:39) dazo: --tls-cert-profile ... that is still legacy, afair ... t=
hat needs to be bumped to preferred at some point
(13:16:57) dazo: --tls-ciphers, --tls-ciphersuites ... those also needs t=
o be moved forward
(13:17:03) cron2: "legacy" isn't bumped to "preferred" but ripped out :-)=

(13:17:20) cron2: dazo: the take on that is "leave the default to the SSL=
 library, because there is negotiation already"
(13:18:11) dazo: we added tls-cert-profile in the beginning to actually s=
et stricter defaults on what the TLS protocol offered
(13:18:43) dazo: (and providing a fallback to users really needing the le=
gacy mode)
(13:18:50) cron2: ah, that's what you mean with "preferred"
(13:19:01) cron2: indeed, we could upgrade that one eventually
(13:19:52) plaisthos: explicit-exit-notify 1
(13:19:57) dazo: yeah
(13:20:13) plaisthos: enable auth-token by default when you do user-passw=
ord auth
(13:20:17) dazo: disallowing BF-CBC and related ciphers
(13:20:51) cron2: write up a list, agree on what the goal should be, and =
whether we can get there with negotiations or not
(13:21:22) dazo: basically doing lots of the stuff openvpn-nl does now (e=
xcept they remove lots of that in the code instead)
(13:21:41) cron2: (I'm not so sure on "enable auth-token by default" - wh=
y?  This is a cool feature, but if someone is fine with static passwords =
and uses a PAM backend to check user validity, this would actually be a d=
rawback fo rthem)
(13:22:20) cron2: if it turns out said list has like 30 entries, and we c=
an't negotiate 28 of them (and we actually agree on changing the default!=
) I'm in
(13:22:38) cron2: if it turns out to be "cipher" and "topology", I mainta=
in that this is more effort than useful
(13:22:39) dazo: plaisthos and I can discuss internally several default c=
hanges ... and propose an overview in a coming meeting
(13:22:58) cron2: list, wiki, agenda item.  Not just hijacking a meeting =
:)
(13:23:07) dazo: sure
(13:23:19) dazo: so ... 7 minutes for man page discussion? :-P
(13:23:23) cron2: no
(13:23:32) cron2: man page is *not* on the agenda, but 2.5 updates is
(13:23:52) dazo: I did ask for it to hit the agenda yesterday ... but oka=
y
(13:23:53) cron2: so can we please do the agenda items first?
(13:24:12) dazo: well, man page *is* a 2.5 related topic ;-)
(13:24:14) cron2: the agenda is in the wiki, things get there because peo=
ple who want them there put them in...
(13:24:35) mattock: MSI =3D Friday
(13:24:49) cron2: anyway, why am I being so annoying about it? because I =
want agreement on the revised proposed timeline
(13:24:58) plaisthos: btw.
(13:25:00) plaisthos: https://community.openvpn.net/openvpn/wiki/Deprecat=
edOptions#Option:--ifconfig-pool-linear
(13:25:01) vpnHelper: Title: DeprecatedOptions =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(13:25:14) plaisthos: ifconfig-pool-linear has been deprecated since 2.1 =
%)
(13:25:34) cron2: can we manage to get all code in by end of June?
(13:25:50) cron2: which is in 3 weeks
(13:25:51) mattock: "no problem" at my end
(13:26:09) mattock: on June 30th I will be sobbing and fighting MSI proba=
bly after I said that
(13:26:33) dazo: I'm pushing to get the man-page patches ready ... then i=
t is the asym compression + async client-connect script support left
(13:26:48) cron2: the compression part is easy ("I just need to review an=
d merge")
(13:27:04) cron2: ordex, plaisthos: can you get enough focused time to ge=
t async-cc done?
(13:27:12) cron2: I'll help, of course
(13:27:25) cron2: (I'll have to, I'm afraid :) )
(13:27:44) ordex: I guess we have to :D
(13:28:13) cron2: if you think this is not going to work out, we can aim =
for "end of July" but then beta phase would be right in the school holida=
ys here (=3D less focus for me)
(13:28:28) plaisthos: the asym compress has a review from lev, I had some=
 follow up questions to lev about his review and lev went silent
(13:28:50) cron2: lev__ disappeared sort of :(
(13:29:01) cron2: I have questions on some MSVC warning fixes as well
(13:29:02) dazo: 2.5.0 release August 1st might be tight, but not impossi=
ble ... Sept 1 is probably more realistic if we aim for people to properl=
y test the beta
(13:29:33) dazo: July is holiday season for many of us ... so I think tha=
t effectively means some time in August
(13:29:53) cron2: Sep 1 will be complicated for me, I'm on family vacatio=
n Aug 22 - Sep 8
(13:30:14) dazo: well, before Aug 22 then ;-)
(13:30:21) cron2: mattock: what are your vacation plans?
(13:30:41) cron2: beta phase will be also testing the MSI installers, and=
 I think there will be lots of installer building happening
(13:30:50) mattock: I will be on holiday in July
(13:31:00) mattock: starting on 5th July
(13:31:02) dazo: I'll have the openvpn-git RPM repos updated as well
(13:31:30) dazo: mattock: how long will you be out?
(13:31:54) mattock: 5th July - 2nd August (4 weeks as usual)
(13:32:09) mattock: that does not mean I cannot do _anything_, but if pos=
sible, I'll try avoid work
(13:32:14) dazo: alright ... so I would say release Aug 15 as the initial=
 goal
(13:32:34) cron2: works for me
(13:32:46) mattock: initial goal =3D first alpha?
(13:32:54) dazo: no, full release
(13:33:16) mattock: so, first alpha end of this month?
(13:33:18) dazo: Code freeze Jun 30, with beta 1 release .... then releas=
e in Aug
(13:33:20) dazo: no alpha
(13:33:22) mattock: ah ok
(13:33:47) mattock: sounds reasonable
(13:33:55) mattock: I hope things break quickly after that, before my vac=
ation :D
(13:34:07) dazo: Then first rc release Aug 3rd
(13:34:25) dazo: then we see how it goes from there
(13:34:29) cron2: mattock: if you have a MSI installer for people to test=
 early next week, that would be good for your vacation :))
(13:34:56) mattock: that may just be doable if there are no surprises tha=
t require rozmansi to take the lead
(13:36:42) mattock: ok release schedule set and seems like we can actuall=
y make it this time
(13:36:54) mattock: 6 minutes overtime
(13:36:58) mattock: anything else?
(13:37:04) cron2: dazo's man page
(13:37:07) cron2: this is also important
(13:37:10) mattock: ok do it
(13:37:28) dazo: yes, please ... So I've chopped the man page up into pie=
ces and put them in different files ... https://gitlab.com/dazo/openvpn/-=
/tree/dev/man-reformatting/doc/man-sections
(13:37:29) vpnHelper: Title: doc/man-sections =C2=B7 dev/man-reformatting=
 =C2=B7 David Sommerseth / openvpn =C2=B7 GitLab (at gitlab.com)
(13:38:16) dazo: I noticed that the existing groups where really not well=
 defined and strictly client options was found in sections not really tie=
d to client related options and so on
(13:39:09) cron2: yeah
(13:39:11) dazo: These groups I've suggested are not set in stone ... and=
 when generating the man page, all of these parts are "glued" together in=
to a single man page (through ".. include::" statements in the openvpn.8.=
rst file)
(13:39:17) cron2: that's quite a few groups :)
(13:39:37) dazo: yeah .... I'm not completely happy about all of them ...=
 but it's a start :)
(13:40:00) cron2: this generally looks like a good start.  The rendering =
of the individual chunks is fairly good
(13:40:12) cron2: https://gitlab.com/dazo/openvpn/-/blob/dev/man-reformat=
ting/doc/man-sections/advanced-options.rst
(13:40:13) vpnHelper: Title: doc/man-sections/advanced-options.rst =C2=B7=
 dev/man-reformatting =C2=B7 David Sommerseth / openvpn =C2=B7 GitLab (at=
 gitlab.com)
(13:40:44) cron2: oh
(13:40:47) cron2: --bcast-buffers
(13:40:51) cron2: learned something new today
(13:40:54) dazo: so ... we don't need to dive into what should go where .=
=2E. but I would really appreciate if this would get some reviews and I c=
ould get comments on how to improve it further
(13:42:16) dazo: some options are also tricky to categorize as well ... l=
ike --ifconfig-pool ... is that a "network config" option or a "server co=
nfig"
(13:42:49) cron2: I'd group those as "if you can have it on the client or=
 serer, it's 'network', if it's network-options-for-servers, it's "server=
"
(13:42:56) cron2: s/serer/server/
(13:42:57) dazo: I've also merged all the IPv6 stuff into the main catego=
ries ... IPv6 should not be an "additional feature" any more.
(13:43:16) dazo: yeah, that's what I believe I neded up with
(13:43:33) dazo: And I might have overlooked some and pasted wrong :)
(13:43:35) cron2: yeah.  ordex and I were discussing README.IPv6, and whe=
ther to throw that one out
(13:43:49) cron2: (I tend to "leave it in for 2.5.x, throw it out right a=
fter")
(13:43:56) plaisthos: I am off to lunch
(13:44:17) dazo: Also .... I've sorted all options alphabetically ... tha=
t is also something to ponder on ... if we want some priority of certain =
options coming first, or alphabetically is fine
(13:44:24) plaisthos: I will look through the depracted options wiki page=
 later and send patches for those that we really want to remove in 2.5 bu=
t haven't done yet
(13:44:29) dazo: I chose alphabetically now to get a better overview
(13:44:43) cron2: plaisthos: nice.  And enjoy your lunch :)
(13:44:48) dazo: cron2: agreed on README.ipv6
(13:44:54) plaisthos: no-replay is porbably one of the candiates
(13:45:09) dazo: plaisthos: that's already moved to "unsupported" ;-)
(13:45:15) dazo: https://gitlab.com/dazo/openvpn/-/blob/dev/man-reformatt=
ing/doc/man-sections/unsupported-options.rst
(13:45:16) vpnHelper: Title: doc/man-sections/unsupported-options.rst =C2=
=B7 dev/man-reformatting =C2=B7 David Sommerseth / openvpn =C2=B7 GitLab =
(at gitlab.com)
(13:45:40) dazo: We also need to un-deprecate comp-lzo in the wiki
(13:45:55) ***dazo brb
(13:46:00) cron2: dazo: mmmh, need to think about "alphabetically", wheth=
er there's options that should be ordered differently ("related options i=
n a longer section")
(13:46:25) cron2: for the "advanced expert", alphabetical is perfectly fi=
ne, as they are all totally independent
(13:50:44) cron2: yeah, I really need to read all of the sections on that=

(13:51:36) mattock: ok, so "cron2 will read first"
(13:51:49) cron2: nah, we all should read and comment
(13:51:59) mattock: ok "all should read first" :D
(13:52:15) mattock: perhaps we might even get some feedback from openvpn-=
devel list
(13:52:18) ***dazo is back
(13:52:24) cron2: yes
(13:52:26) cron2: and wiscii :)
(13:52:31) mattock: yep
(13:52:56) dazo: yeah, getting some critical reviews now would be really =
good
(13:53:16) cron2: wiscii is always super critical :-)
(13:53:23) dazo: and nothing is set in stone ... the alphabetical order w=
as primarily to not get lost in all the moving of options from one place =
to another
(13:53:34) mattock: makes sense
(13:54:13) mattock: ok, done are we?
(13:54:59) dazo: the alphabetical order makes sense when you know what yo=
u are looking for, then it's easier to locate the part you need ... but i=
f you need to configure something without knowing the option name, it mig=
ht be counter-productive=20
(13:55:04) cron2: JFTR, I intend to merge the non-SSO patches "rsn".  Wan=
ted to get ipv6-only out of the way (which is done for good now, just pus=
hed the last patches)
(13:55:07) dazo: Yeah, I think so
(13:55:25) dazo: cron2: cool!
(13:56:36) mattock: I wrote those things to the record which I will send =
now
(13:56:46) mattock: speak up now if you have something else! :)

--------------EF8425C6AEFC94948D4839F9--

--q5X0naP5K5sAdVcdIdXMIKptGR5Y54lXp--

--qFC7yGJnZaPo556BhdxgHVu0wCZHT6Fa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl7gvTEACgkQKVhNn0CG
RXjGygf+KMdgOiiFlMSjzd1mEc/Z54pWoqXHjOAmpKESWBAhak0/4Y8J5kYJYAue
ChIphkrRMJIPtgaw90VQxzkzZqCGmdfr/FH+MQYqQdxGEv53dExCscYhi+t14aqY
vO9BfHds4ZzWimn2JH1QQebEEQAFi0l6TOch9KaCiG8PE9iwJsXZs0TV9copw9P1
A2126JIL1SUI5NOKmBRyOkzmgIbAgaaoDobtZQk0WxS+GZBhbY8Fil9lRBYALn06
Zmb7316he9QlDEDZTMDYXuAU8t4NO4RllK2f6EqzA7cmzWkjYwvTZiONfwY5QBtY
OjHmcRAujfR9AQT/2ILeZETrH/GbmQ==
=N5Ll
-----END PGP SIGNATURE-----

--qFC7yGJnZaPo556BhdxgHVu0wCZHT6Fa4--

