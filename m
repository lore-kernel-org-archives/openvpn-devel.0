Message-ID: <4B87BF4A.1050400@...515...>
Date: Fri, 26 Feb 2010 14:32:10 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090709060507080001000802"
Subject: [Openvpn-devel] Summary of the IRC meeting (25th Feb 2010)
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
--------------090709060507080001000802
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-discussion on irc.freenode.net
Date: Thursday, 25th January 2010
Time: 18:00 UTC

Next meeting on Thu 4th Feb 2010. Same place, same time.

SUMMARY

Discussed distro-specific content such as init-scripts. Agreed that they
should not be included in the "testing" tree - or at least they should
be clearly separated (e.g. in their own directory).

Discussed the "Feature Deprecation Process" (FRP). Agreed that we need
James' comments and/or blessing for it.

Discussed the packaging status of OpenVPN "testing" tree. FreeBSD port
is available, Gentoo is coming and Debian Experimental packages should
be coming. Mape2k volunteered to create OpenWRT/Freetz packages.

Agreed that we should try to make bug reporting as easy as

 $ make bugreport

Agreed that OpenVPN should be able to output it's configuration (e.g.
version, ./configure options) automatically. It was also agreed that
this functionality should be easy to disable (for embedded systems).

Decided that the community site Trac instance will be opened as "beta"
when SSL-certificate is installed (and Trac LDAP auth configured). User
accounts need to be requested from Samuli, but everybody has read access
to the contents. When the self-service user registration service ("pwm")
is configured properly the site can be opened officially and forum
software added.


--

Full chatlog as an attachment


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------090709060507080001000802
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-02-25.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-02-25.txt"

(20:00:05) ***dazo gets ready=20
(20:00:30) mattock: me too
(20:01:05) |Mike| [mike@...1306...:1af8:2:444::2] =EF=BF=BD=EF=BF=BD entrat=
o nel canale.
(20:02:25) dazo: mattock:  do we have an agenda for today?
(20:02:25) |Mike|: discussion about what exactly?
(20:02:57) mattock: dazo: I think we should discuss the FRP a little
(20:02:57) dazo: |Mike|:  in general, development and testing stuff ... Jam=
es Yonan also joins usually
(20:03:19) mattock: dazo: do we have any patches we should discuss with Jam=
es (when he arrives)
(20:03:42) dazo: mattock:  Yeah, I got one patch which Gentoo includes=20
(20:04:00) mattock: the easyrsa thingy?
(20:04:28) dazo: nope ... #define _GNU_SOURCE .... seems to be related to o=
lder glibc's
(20:04:35) mattock: ok
(20:04:52) dazo: easyrsa thing in Gentoo seems to be related to openssl bui=
lds without pkcs11 support
(20:06:13) dazo: mattock:  I'm also looking into some patches Fedora includ=
es ... mostly updating the init script ... I'm considering if we should pul=
l in some of the more generic patches here as well
(20:06:38) mattock: has everybody taken a look at the FRP dazo and I have d=
rafted:
(20:06:38) mattock: http://www.secure-computing.net/wiki/index.php/OpenVPN/=
Developer_documentation#Feature_deprecation
(20:06:40) vpnHelper: Title: OpenVPN/Developer documentation - Secure Compu=
ting Wiki (at www.secure-computing.net)
(20:07:00) mattock: dazo: ok
(20:07:17) mattock: what other patches does fedora include?
(20:08:01) dazo: mattock:  for F-12, only sample-scripts/openvpn.init updat=
es
(20:08:45) mattock: what do you think about having the distro-specific stuf=
f upstream (=3Din the "testing" tree)?
(20:08:50) mattock: e.g. init script stuff
(20:09:07) mattock: it would perhaps help in reusing the generally useful p=
arts
(20:09:48) dazo: mattock:  I would try to avoid it as much as possible ... =
make it as generic as possible, distro-specific which only they need stuff =
should be patched by patched by them, IMHO
(20:11:09) dazo: mattock:  if we get stuff for specific distros, I'd rather=
 give them a separate directory
(20:11:35) mattock: yes, the stuff needs to be at least clearly separated f=
rom the generic stuff
(20:12:28) dazo: agreed :)
(20:12:44) mattock: what about the FRP? Is it something we all can agree on?
(20:13:39) ***dazo would like to have James' accept on FRP as well ... and =
also his comment on the "nag logging patch" cron2 acked yesterday
(20:14:03) mattock: dazo: I'd like to hear his thoughts, too
(20:14:18) mattock: and we need to sort out how exactly stuff moves from te=
sting to stable
(20:15:15) dazo: yes
(20:15:27) mattock: my agent is after James
(20:15:40) mattock: (thanks Kasx)
(20:15:50) Kasx: np
(20:16:31) mattock: regarding the community site...
(20:17:17) mattock: the LDAP server is now up, I've configured access contr=
ol settings and built a schema
(20:17:43) mattock: I started working on the user registration webapp (http=
://code.google.com/p/pwm/) but did not get it working (yet)
(20:17:46) vpnHelper: Title: pwm - Project Hosting on Google Code (at code.=
google.com)
(20:18:19) mattock: ecrist: are you available?
(20:18:22) mattock: =3Dthere
(20:18:28) ecrist: for now, yes
(20:18:41) mattock: may I ask a quick question about LDAP
(20:18:42) mattock: ?
(20:18:53) ecrist: certainly
(20:18:58) mattock: ok
(20:19:09) mattock: I currently have something like this
(20:19:29) mattock: user accounts are in ou=3DAccounts, dc=3Dopenvpn, dc=3D=
net
(20:19:38) mattock: groups are in ou=3DGroups, dc=3Dopenvpn, dc=3Dnet
(20:20:04) mattock: each account implements objectclasses posixAccount and =
inetOrgPerson
(20:20:14) mattock: groups are of the posixGroup type
(20:20:25) mattock: I'm guessing this is kind of basic setup
(20:20:46) mattock: however, what do you think about putting the Accounts i=
nside the Group tree?
(20:21:03) ecrist: what do you mean?
(20:22:18) mattock: so that the dn for an account would be cn=3DFirstname L=
astname, ou=3DGroupname, ou=3DGroups, dc=3Dopenvpn, dc=3Dnet
(20:22:20) mattock: or something like that
(20:22:30) mattock: is there any advantage to that approach?
(20:22:44) Schlaubi [~daniel@...1307...] =EF=BF=BD=EF=BF=BD entrato nel can=
ale.
(20:23:02) ecrist: not really, it's all cosmetic
(20:23:25) ecrist: the hier really only helps with ACL generation and menta=
l picturs. ;)
(20:23:42) mattock: how do you handle group membership for users? do you ha=
ve a member list attribute inside the group definition?
(20:24:04) ecrist: myself, I have ou=3Dgroups,ou=3Dpeople,dc=3Dcompany,dc=
=3Dcom and ou=3Dstaff,ou=3Dpeople,dc=3Dcompany,dc=3Dcom
(20:24:08) ecrist: and similar trees within
(20:24:39) ecrist: groups can be handled two ways, either you have a group =
object, with members listed within, or you list membership in the user obje=
ct
(20:24:47) ecrist: it's simply a matter of how you structure your query
(20:24:57) ecrist: I opted for the group object listing membership
(20:25:09) ecrist: there are advantages and disadvantages to both
(20:25:36) mattock: ok, thanks
(20:25:42) ecrist: on one side, you need to query each user to find a group=
s' members, and on the other, you need to query each group to find which gr=
oups a user belongs to
(20:26:24) mattock: btw. I stumbled upon an interesting article regarding L=
DAP schema design: http://www.informit.com/articles/article.aspx?p=3D28786
(20:26:25) ecrist: for my use, we use object classes top, inetorgperson, po=
sixaccount, shadowaccount, and a couple in-house ones.
(20:26:28) vpnHelper: Title: InformIT: Principles of LDAP Schema Design > T=
ypical Problems with LDAP Schema Design (at www.informit.com)
(20:27:06) mattock: it seems possible to normalize the LDAP schema similarl=
y to what you can do with databases=20
(20:27:25) ecrist: ldap is simply a database grossly optimized for reads
(20:27:52) mattock: kind of, yes
(20:28:35) mattock: btw. what LDAP client do you use for management (if I m=
ay ask)?
(20:28:48) ecrist: I deal with raw ldif
(20:28:51) mattock: ok
(20:29:16) mattock: I've used phpldapadmin which works nicely... however, I=
've heard horror stories about it's code from coders
(20:29:26) ecrist: however, you being on a mac, apache has a really nice on=
e, Apache Dirctory Studio I use from time to time
(20:29:48) mattock: I'm on Mac which runs Linux :)
(20:29:51) ecrist: actually, that one is in java, so it's cross platform
(20:31:30) mattock: should we wait for James for a while?
(20:31:57) ***dazo got only about another 30min available unfortunately
(20:31:59) mattock: or do we have any other topics to discuss?
(20:32:05) dazo: testing?
(20:32:09) ecrist: I'm unavailable in 20 mins
(20:32:15) mattock: ok, testing
(20:32:33) mattock: in fact, we could make a list of things we need the s.c=
. "dedicated testers" to document
(20:32:36) dazo: what's the status here?  FreeBSD is in place ... Gentoo is=
 on the way ... Debian?
(20:32:49) mattock: agi: are you there?
(20:33:02) ***dazo has located the Fedora packager on #fedora-devel .... si=
lug
(20:33:14) mattock: dazo: great!
(20:33:50) mattock: dazo: is there any documentation for packagers?
(20:33:50) dazo: do we have anyone inside Mandrake and openSuSE?
(20:33:56) mape2k: i'll try to build the git-code for OpenWRT and Freetz (M=
IPS, Fritzbox, uclibc) these days
(20:34:09) dazo: mape2k:  perfect!
(20:34:12) mattock: mape2k: great
(20:34:37) dazo: mattock:  not explicit ... but they should pay attention t=
o the testers doc, especially the compile and configure section
(20:34:37) mape2k: i've to prepare for an oral exam, hope i'll find some fr=
ee time ;)
(20:34:58) dazo: mape2k:  it's not *that* urgent that we expect it before y=
our exams ;-)
(20:35:06) mape2k: hehe
(20:35:19) mattock: I think it makes sense to move the compile & configure =
section to it's own page
(20:35:28) mattock: it's useful to developers, testers and packages
(20:35:43) dazo: yeah, we can do that ... I plan to keep that updated in re=
gards to disable deprecated features=20
(20:37:23) Schlaubi ha abbandonato il canale (quit: Quit: Verlassend).
(20:37:26) dazo: I'm also planning to do something more clever with the ./b=
ootstrap.sh script ... so that it can be used for more than just ecrist Fre=
eBSD packager as well
(20:38:14) ***dazo is actually really excited that we will get ovpn-testing=
 on embedded also
(20:38:16) mattock: regarding testing setup documentation... what exactly d=
o we need? At least OS, ./configure output (=3Dused features)
(20:39:10) dazo: We do need the ./configure line .... openvpn --version ...=
 and configuration files=20
(20:39:57) dazo: But I've been thinking if we should have some kind of stan=
dard config files in addition ... a couple of different test suites which c=
an do really the most important feature testing of OpenVPN
(20:40:26) mattock: I think we have two separate needs... part of that docu=
mentation can wait until problems are encountered, but part of it is useful=
 to have online to see what setups are being tested actively
(20:40:40) dazo: yes
(20:41:09) mattock: I think we decided that we _can_ assume testers use the=
 latest OpenVPN version=20
(20:42:14) dazo: yes, but it's good to keep track of the openvpn --version =
... when I got a more clever bootstrap script up, it will put the HEAD comm=
it ID in the version string
(20:42:15) mattock: should the ./configure line be in the Wiki?
(20:42:25) mattock: (I assume yes)
(20:42:37) dazo: giving is a good possibility to track which commit which g=
ives troubles or is known to work
(20:43:08) dazo: ./configure in wiki ... I don't quite understand?
(20:43:40) mattock: I mean, if we want to see what features are (supposedly=
) being tested (or covered) testers should probably put their ./configure l=
ine to the Wiki
(20:43:46) mattock: to their own tester page
(20:43:56) dazo: yes, as a part of their report, yes, definitely!
(20:44:34) dazo: that's good for historical reasons ... as the requirement =
for that will change over time ... but good to know when looking on older r=
eports
(20:45:15) ecrist: is there an option for the openvpn binary to list out co=
nfigure and compile-time options?
(20:45:25) dazo: ecrist:  nope
(20:45:30) mattock: that'd be quite useful
(20:45:30) ecrist: might be useful, at least in dev versions
(20:45:46) mattock: wouldn't that be easy to implement, too?
(20:45:55) dazo: agreed ... I'll look into that ... could actually be a par=
t of the --version screen
(20:45:56) mattock: doesn't sound like black magic to me
(20:45:58) ecrist: so, if configure is run with debug or devel mode, add a =
-pr option or some-such to output that data
(20:46:15) ecrist: dazo, it may be too much for --version, keeping in mind =
embedded systems
(20:46:40) ecrist: with all the ifdefs, etc, that's a long set of strings t=
o store.
(20:46:46) dazo: ecrist:  well, there is a --enable-small configure arg whi=
ch these systems should use ... that can disable it on them
(20:47:00) ecrist: ok
(20:47:13) ***ecrist not a developer, so just typing idea.
(20:47:34) dazo: but ... that info should mainly only be visible when a kin=
d of --debug mode is enable
(20:47:35) dazo: d
(20:47:40) mattock: I think we should make bug reporting as easy as possible
(20:47:54) dazo: $ make bugreport
(20:47:54) dazo: ?
(20:48:02) dazo: ;)
(20:48:11) mattock: yep ;)
(20:48:20) ecrist: openvpn -pr
(20:48:22) mattock: anyways, I think ecrist's idea is good
(20:49:03) mattock: the less manual steps are required for bug reporting (e=
specially in "testing") the better
(20:49:16) dazo: yup
(20:49:18) mattock: perhaps "make bugreport"?
(20:49:25) mattock: as dazo said, actually :)
(20:49:28) mattock: didn't get it earlier
(20:49:38) dazo: heh :)
(20:50:23) dazo: that was my thought yeah ... but adding make specific targ=
ets with autotools can be an adventure and experience ... but not impossible
(20:50:41) ***dazo will look into that in the near future
(20:51:16) mattock: I created a _very_ limited section about bug reporting:=
 http://www.secure-computing.net/wiki/index.php/OpenVPN/Documentation_for_t=
esters#Reporting_bugs
(20:51:17) vpnHelper: Title: OpenVPN/Documentation for testers - Secure Com=
puting Wiki (at www.secure-computing.net)
(20:51:53) mattock: I think we can safely assume James is not coming today
(20:51:54) mattock: too bad
(20:52:23) mattock: dazo: could you mail him directly about the patches?
(20:52:28) mattock: I can do the same for FRP
(20:52:39) dazo: Will do!
(20:52:57) mattock: I'll add reminders about reminding James to my selfphon=
e=20
(20:53:11) mattock: otherwise he might forget these meetings too often ;)
(20:53:29) dazo: mattock:  can you please also add a link to the "[PATCH] F=
RP: Present a warning on deprecated features during start-up" patch as well?
(20:53:41) mattock: ok, will do
(20:54:22) dazo: then I'll pick up the Gentoo patch as well
(20:54:54) mattock: regarding Debian Experimental... it seems "agi" is abse=
nt even though he's present
(20:55:17) mattock: he said he could put "testing" into Debian Experimental=
 ~once a week
(20:55:17) dazo: yeah :)
(20:55:44) dazo: that's more than fair enough ... that's about the same as =
what ecrist will do with FreeBDS
(20:55:47) mattock: when the community site stuff is mostly done, I can mov=
e to packaging issues (e.g. daily snapshots)
(20:56:07) mattock: one more thing...
(20:56:22) mattock: what do you guys think about opening up the community s=
ite Trac instance as "beta"
(20:56:31) mattock: meaning that you need to send me mail to get accounts
(20:56:39) dazo: mattock:  have you spotted any SuSE or Mandrake users?  I'=
d like to have more RPM distros tested as well
(20:56:46) dazo: mattock:  that sounds like a good idea
(20:56:59) mattock: the "pwm" stuff (user self-service registration) will t=
ake a while
(20:57:28) mattock: all that is needed then is getting a SSL cert and doing=
 some hardening
(20:57:34) dazo: it's better to get it tested under a controlled environment
(20:57:35) mattock: then it's "ready"
(20:57:54) dazo: as long as read-only access will be available for the rest=
=20
(20:57:56) mattock: dazo: I don't know of any SuSE or Mandriva users
(20:58:04) mattock: dazo: yep, it will be
(20:58:22) ***dazo don't think there are many "writers" on secure-computing=
 wiki today
(20:58:27) mattock: true
(20:58:38) mattock: the self-service registration becomes an issue when for=
ums open
(20:58:39) dazo: I think that will work out then
(20:58:44) dazo: yes
(20:59:16) mattock: ok, I'll open the community site when SSL certs are in =
place
(20:59:27) mattock: there won't be any fancy themes or anything
(20:59:29) mattock: but it should work
(20:59:51) mattock: in fact, it can remain "beta" forever, like Google's se=
rvices
(21:00:05) dazo: :)
(21:00:17) dazo: nah ... we can do better than Google :-P
(21:00:33) mattock: yeah, we even have more muscle and brainpower
(21:00:35) mattock: :)
(21:00:48) mattock: oh, do you mean having it in "alpha" state always?
(21:00:54) mattock: or in the "ship it if it builds"-state?
(21:01:18) dazo: :)
(21:01:32) mattock: ok, so a summary
(21:01:42) dazo: compiles? check ... pass smoke-test?  check ... shipped?  =
check!
(21:01:58) mattock: optionally smoke test can be skipped
(21:02:03) dazo: :)
(21:02:03) mattock: if busy
(21:02:27) mattock: and even if it does not build, you can add the files th=
at _did_ compile to an earlier version
(21:02:31) mattock: it might work
(21:02:52) mattock: anyways, I'll take care of FRP+James
(21:03:04) mattock: and dazo will send mail to James about the patches
(21:03:30) dazo: yup!
(21:03:32) mattock: and community site will be opened when SSL cert is conf=
igured
(21:03:39) mattock: and Trac LDAP auth is in place
(21:03:47) mattock: we can then start adding Trac plugins to see how they w=
ork
(21:03:59) mattock: I'll mail Francis about ecrist's root access
(21:04:49) mattock: I guess we're done
(21:05:36) mattock: I'll write the real summary tomorrow and this time add =
the full chatlog to the email
(21:05:49) mape2k: ;)
(21:06:34) mattock: see you later, guys!
(21:07:53) mattock: time for desert...
(21:07:53) dazo: c'ya!
(21:07:56) mattock: no, just kidding, dessert
(21:07:57) mattock: :)
(21:08:06) dazo: :)

--------------090709060507080001000802--

