Message-ID: <4BC96C50.1060604@...515...>
Date: Sat, 17 Apr 2010 11:07:44 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000005040009000101010600"
Subject: [Openvpn-devel] Summary of the IRC meeting (15th Apr 2010)
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
--------------000005040009000101010600
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 15th March 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<http://www.secure-computing.net/wiki/index.php/OpenVPN/IRC_meetings/Topics=
-2010-04-15>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Mattock gave an update on status of the community site/services. Trac is
publicly available here:

<https://community.openvpn.net/openvpn>

Decided to start using Trac instead of Secure-computing Wiki for
developer documentation. Agreed that moving trackers or user content
does not make sense until users can register themselves.

Trac git-plugin browsing performance / CPU consumption seems pretty bad
and something has to be done about it. Using (and linking to)
Sourceforge's git browser was one option.

The user self-service registration service (pwm) is in pretty good shape
with Java/Tomcat/LDAP directory issues mostly sorted out. Forum server
is waiting for the user registration service before work on it continues.

Discussed migrating user accounts from ovpnforums.com to
forums.openvpn.net when it's up. Given phpbb's custom hashing scheme
agreed that it makes sense to migrate user accounts to LDAP, but send
the users new random passwords which they can then change.


Discussed the "Openvpn dies on boot with "Out of Memory" error when
using mlock" issue:

<http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D406895>

As this bug is Linux-specific, agreed that a reasonable solution is to
add a default limits file to /etc/security/ and let users modify it if
they need. Agi is working on this.

Discussed the "Possibly symlink attack due to client-connect script" issue:

<http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D534908>

Agreed that temporary file creation needs some hardening. Dazo already
provided a patch.

Discussed the "--multihome broken in latest version" issue:

<http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D562099>

This should be fixed, but mattock will verify this from our users
mailinglist.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------000005040009000101010600
Content-Type: text/plain; name="openvpn_irc_meeting_chatlog_2010-04-15.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-04-15.txt"

13:05 < agi> hiya!
13:05 <@dazo> agi:  hi!
13:05 <@dazo> uh ... 20:05 already ...
13:06 < agi> yep
13:06  * dazo need to quickly grab some food
13:06 <@mattock> hi
13:06 <@mattock> james, where art thou? ;)
13:07 < ecrist> good afternoon
13:08 <@mattock> hi eric
13:09 -!- jamesyonan [~jamesyona@...1320...] has joined #openvpn-devel
13:09 <@dazo> \o/
13:10 <@mattock> hi james!
13:10 <@dazo> mattock:  JJK would join today as well
13:10 <@mattock> that's great!
13:10 <@dazo> (he's hopefully soon here)
13:10 <@mattock> perhaps we can discuss the duplicate-cn issue
13:10 <@mattock> if he has any further input on that
13:11 < jamesyonan> Hi
13:11 <@dazo> I've updated the agenda with 2 of JJK's issues as well
13:11 <@mattock> shall I begin with a brief community site status update?
13:11 <@dazo> please! :)
13:12 <@mattock> ok, so the Trac instance is public as you probably know: https://community.openvpn.net/openvpn/wiki
13:12 < vpnHelper> Title: OpenVPN (at community.openvpn.net)
13:12 <@mattock> there's not any content there yet, and I don't think there should be until users can register themselves
13:12 <@mattock> what do you think?
13:13 <@mattock> I managed to sort out the Java Security Manager issues with Tomcat + pwm (the user self-service registration service) 
13:13 <@dazo> we could probably begin to move over some of the more "static" wiki stuff
13:13 <@dazo> bug trackers, etc need to wait
13:14 <@mattock> yep, that's doable
13:14 <@mattock> how many people have been writing to secure-computing wiki?
13:14 <@mattock> me, dazo, who else?
13:14 < ecrist> half dozen or so
13:14 <@mattock> to the OpenVPN section?
13:14 <@dazo> http://www.secure-computing.net/wiki/index.php/Special:RecentChanges
13:15 < vpnHelper> Title: Recent changes - Secure Computing Wiki (at www.secure-computing.net)
13:15  * agi just used it to write possible bugs/issues for this meeting
13:15 < jamesyonan> re: wiki -- looks pretty good.  I see that you integrated it with source control.
13:15 <@mattock> we _could_ move the -devel documentation stuff to trac 
13:16 <@dazo> definitely
13:16 <@mattock> jamesyonan: git integration is pretty slow, drains 50% of the CPU
13:16 <@mattock> and takes a couple of seconds
13:16 < ecrist> mattock: you and dazo use the wiki mostly for devel related stuff, krzee and I have most of the 'meat'
13:17 <@dazo> ecrist:  so devel stuff is not juicy enough for you to be called meat? :-P
13:17 < ecrist> nope. 
13:17 < ecrist> I'm looking at it more from  a user standpoint
13:17 <@dazo> boring guy :-P
13:17 <@dazo> :)
13:18 <@mattock> anyways, the self-service registration service is in pretty good shape, I'm currently debugging what LDAP operations it actually tries to do
13:18 <@mattock> meaning it does not work yet, but tomcat + security manager are in pretty good shape 
13:19 <@mattock> if I'm lucky, it might take 1-2 full workdays to configure pwm properly
13:19 <@dazo> great! ... so hopefully ready until next meeting then?
13:19 <@mattock> the forum server is partially configured, but there's little point in doing more work until pwm is up
13:19 <@mattock> dazo: possibly, depending on how many distractions there are
13:19 <@mattock> if I don't open IRC or email then perhaps ;)
13:20 <@dazo> okay, a couple of more weeks then :)
13:20 <@mattock> that's more probable
13:20 <@mattock> ecrist: so you run ovpnforums? 
13:20 < ecrist> yes
13:21 <@mattock> I don't think we've discussed whether you'd be willing to migrate them to forums.openvpn.net... so would you? ;)
13:22 <@mattock> given root of course
13:23 <@mattock> and if possible, migrate the user accounts to LDAP, too
13:23 < ecrist> we had discussed that and iirc, I was fine with it.
13:23 <@mattock> oh, good
13:23 <@mattock> any ideas how to do the user migration?
13:24 <@mattock> I'm guessing some nasty scripting is required
13:24 < ecrist> we'd just have to figure out how passwords are stored in mysql and migrate them to ldap
13:24 < ecrist> there aren't that many users
13:24 <@mattock> how many?
13:24 < ecrist> gimme a sec and I'll get a number
13:25 <@dazo> I'd suggest not migrating the passwords ... rather send them a new temp password which they can change ... the password hashing might be too different to be able to migrate that
13:25 <@mattock> I noticed you haven't got account on forums yet, I'll create one
13:25 <@dazo> only exception is if both uses the exact same implementation
13:25 <@mattock> dazo: yes, that might become a problem
13:26 < ecrist> 133 users with more than 0 posts
13:26 <@mattock> definitely worth migrating, though
13:27 <@mattock> unless it becomes extremely difficult for some reason
13:27 <@dazo> migrating user accounts without passwords makes sense
13:27 <@dazo> (or rather, with new passwords, that is)
13:27 <@mattock> if the user accounts are not migrated, there might be problems with the database
13:28 < ecrist> phpbb3 uses a custom-written password hash based on urandom and md5
13:28 <@mattock> if a non-existent user is referenced in the tables
13:28 < ecrist> there are other dependency accounts within phpbb that are required, such as google bot and other accounts
13:29 <@mattock> so in a nutshell we (or I?) need to do some more research
13:29 < ecrist> indeed
13:30 <@dazo> ecrist:  does phpbb3 do more magic?  hash=md5(salt + password) or does it do some looping as well?  or other trickery like hash=md5(md5(salt+password)+salt)
13:30 <@mattock> ecrist: do you want to be "ecrist" on forums.openvpn.net?
13:31 < ecrist> entire function is here: http://www.pastebin.org/152553
13:31 < ecrist> mattock: ecrist is fine
13:32 <@mattock> ok
13:32 <@dazo> mattock:  btw ... the source browser in trac, is not so useful when it doesn't show all branches - only the master branch ... and what it shows is a mixture between last commits and what's found in the master tree index 
13:33 <@dazo> it will work fine though from tracker items where the commit ID is referenced, as that is unique among all commits
13:33 <@mattock> dazo: ok... and it might DOS the server if more than one user clicks on "Browse source" at once ;)
13:33 <@mattock> simultaneously I mean
13:33 -!- d12fk_ [~quassel@...1346...] has joined #openvpn-devel
13:33 <@dazo> mattock:  I'm suggesting to rather use cgit or git-web for browsing the code ... or redirect that to sf.net site ...
13:34 <@mattock> perhaps redirecting SF.net would be best
13:34 < ecrist> then there's no point in using trac, really
13:34 < d12fk_> re
13:34 <@mattock> except as a bug tracker and wiki
13:34 < ecrist> sure, but there's a working bugtracker on sf.net and other wiki software.
13:34 <@mattock> I think it's possible to do some git->svn trickery to get better performance
13:34 <@dazo> yes, it is ... because if you reference commit IDs in tracker items, it can do commit lookups better ... but when browsing the source, it's not efficient (and wrong)
13:34  * ecrist feels like we're back where we left off
13:35 <@dazo> no, not at all :)  we just need to tune the pieces we have better
13:36 <@dazo> or to put a proxy-server like varnish in from
13:36 <@mattock> dazo: so the git integration does serve some purpose even if browsing is slow?
13:37 <@dazo> yes, because you can reference commits in tracker items ... and then you can click on those refs and see the actual commit ... I do find that useful
13:37 <@mattock> does that work properly even now?
13:38 < ecrist> you could do that with a custom wiki markup, though
13:38 <@dazo> yes!  Because the commit ID's are unique, across all branches
13:38 <@mattock> great
13:38 < ecrist> [id]foobean1[/id]
13:38 <@mattock> ok, so need to throw in the towel ;)
13:39 <@dazo> ecrist:  could be useful, and could work as well ... and then that could lead to the sf.net git-web instead
13:39 <@mattock> so let's start moving/copying the developer content to Trac and see how it holds together
13:39 <@mattock> bug reports and "user" content needs to wait
13:40 <@dazo> agreed :)
13:40 <@mattock> shall we move on?
13:40 <@dazo> agi:  what about your stuff now?
13:41 <@dazo> (as JJK has not arrived yet)
13:42 < agi> dazo: sure, fine
13:43 <@mattock> ecrist: do you have OpenPGP support in your mail client?
13:43 < agi> re: debian ipv6 patch, no news (I still have to ping the reporter)
13:43 < agi> next :)
13:43 < ecrist> mattock: no
13:43 <@mattock> ok
13:43 < ecrist> Apple Mail fails at PGP integration
13:44 < agi> OOM when using mlock, no idea, wanted to bring it here since it seems to be reproduceable by other user in the latests version
13:44 < agi> should I ask them for dumps just like with the ipv6 report?
13:44 < ecrist> mattock: if you're looking to send me a password, stick it in the upload directory of the backup server in a text file via ssh
13:46 <@dazo> agi:  the OOM is most probably caused due to the init scripts not having ulimit values high enough
13:46 <@dazo> (we're talking about: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=574164 )
13:46 < vpnHelper> Title: #574164 - openvpn: Assertion fails in socket.c:429 in p2p mode due to Debian ipv6 patch - Debian Bug report logs (at bugs.debian.org)
13:46 <@dazo> nah
13:46 <@dazo> wrong link
13:47 <@dazo> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=406895
13:47 <@dazo> this one
13:47 < vpnHelper> Title: #406895 - openvpn dies on boot with "Out of Memory" error when using "mlock" - Debian Bug report logs (at bugs.debian.org)
13:48 <@dazo> agi: as far as I can see, the implementation in OpenVPN is correct ... so it's not a programming error, but it is system dependent
13:48 < agi> dazo: I could add a recommended value to the README.Debian file, or a suggestion could be made in openvpn's README
13:48 <@dazo> jamesyonan:  what would you say would be a proper RLIMIT_MEMLOCK value?
13:49 <@dazo> agi:  or you could even add the needed 'ulimit -l' line in the startup script ... or have a change to /etc/security/limits.conf 
13:50 <@dazo> agi:  f.ex. Fedora got a /etc/security/limits.d/ directory where you could create a openvpn.conf ... which would be set upon startup, afaik
13:51 < jamesyonan> difficult to say.  I would take a base memory size (a few megs) + n_bytes_per_client * number_of_expected_clients
13:51 < agi> dazo: there's limits.d in Debian too
13:51 < jamesyonan> n_bytes_per_client tends to be around 200KB
13:52 <@dazo> agi:  and then you could give the openvpn user/group ... a decent amount of memlock
13:52 < agi> since it depends greatly on the number of clients
13:52 < agi> i'd rather document that, and let the users set a value for themselfs
13:53 < agi> *selves
13:54 <@dazo> agi:  I'd probably suggest adding a default file, which then can be modified on need ... the config line could be hashed out, of course
13:54 < agi> ok, sounds good
13:55 < agi> next is http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=534908
13:55 < vpnHelper> Title: #534908 - possibly symlink attack due to client-connect script - Debian Bug report logs (at bugs.debian.org)
13:55 <@dazo> I struggle to see how this one could be misused, except if the sysadmin really messes up his own config file ....
13:56 <@dazo> there is no way, afaik, that a client connection could make this happen ... or am I wrong?
13:57 < agi> looks a bit paranoid to me, but could be doable
13:58 <@dazo> well, then I just don't really see how ....
13:59 < agi> being faster in creating the temp's file as a symlink to something else than the script called by --client-connect
13:59 <@dazo> but that already means you have a config on the server side which are already messed up, right?
14:00 < agi> why?
14:01 < agi> your config just calls a script, the temporary file name is not specified in it
14:01 <@dazo> because, if you look at  misc.c:1168:create_temp_filename() ... here it's a counter which can't be messed up which is used in addition to the filename ... so already here we should have a safe filename 
14:01 <@dazo> this filename is then passed on to the script .... whatever that script does, is IMHO, out of OpenVPN's control ....
14:02 < jamesyonan> I think this issue would only be of concern if OpenVPN is being run to use /tmp as the temporary directory (which is world writable -- hence the concern)
14:02 < agi> right
14:03 <@dazo> jamesyonan:  would it be an better solution to make use of mkstemp() as well?
14:04 < jamesyonan> dazo: not really
14:04 < agi> if the temp file is just to let the script write some parms
14:04 < jamesyonan> the problem is not with the temp filename generation
14:05 < agi> wouldn't it be possible to read the script's stdout for those parms?
14:05 < jamesyonan> it's that the temp filename is then passed on the command line to the script, so ps can see it
14:05 <@dazo> I know ... but mkstemp(3) would not make use of an already existing file name
14:05 <@dazo> aha
14:06 < jamesyonan> so if the temp filename is in a world-writable directory, a malicious process could quickly create the link before the script has a chance to create the file
14:07 < jamesyonan> the solution is not to point --tmp-dir at a world writable directory
14:08 < jamesyonan> I believe by default, OpenVPN does NOT set --tmp-dir to point to /tmp
14:09 <@dazo> mm
14:10 <@dazo> jamesyonan:  but would it also make sense to add a check that it does not try to create a temp filename which already have an existing file in that directory?
14:11 < jamesyonan> it wouldn't hurt, but the chances of a filename collision is vanishingly small -- create_temp_filename uses 16 bytes of entropy to create the filename
14:12 < agi> maybe issue a warning when tmp_dir is world writeable?
14:12 < jamesyonan> that makes sense
14:13 <@dazo> agreed, it's not a big chance ... but still 16 bytes random is not making it impossible ... and if an external malicious process tries to quickly create a link before the script manages ... it would fail, as long as umask() is set correctly
14:14 <@dazo> (and unless, the malicious process runs with the same privileges as openvpn ... excluding root, as if this malicious process is running as root, you got a completely different problem on the server)
14:15 < agi> uninvited guess
14:15 < agi> guest
14:15 <@dazo> yeah
14:15 < jamesyonan> dazo: are you saying that OpenVPN should pre-create the temp file?
14:15 <@dazo> yes
14:16 <@dazo> that's what mkstemp() does, which makes it race safe as well
14:16  * agi has to leave
14:16 < agi> I couldn't test next bug report yet, we can leave it for next meeting if you want to
14:17 < jamesyonan> right, that makes sense... as long as the file is pre-created before the filename is placed on a command line that ps can see, we're safe
14:17 <@dazo> agi:  sounds good to me ... it's good to have you involved in these things, as you know more about it
14:17 <@dazo> jamesyonan:  want me to poke into a patch here?
14:18 < jamesyonan> sure
14:18 < agi> dazo: actually I don't think I know much about anything compared to anyone here :)
14:18 <@dazo> agi:  I meant ... you might know ;-)
14:18 < agi> gotta go now :)
14:18 <@dazo> agi:  have fun!
14:19 < agi> see you next week!
14:19 <@mattock> next one? :)
14:19 <@mattock> bye agi!
14:19  * dazo begins to run out of time as well
14:20 <@mattock> how about a quickie: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=562099
14:20 < vpnHelper> Title: #562099 - openvpn: --multihome broken in latest version - Debian Bug report logs (at bugs.debian.org)
14:20 <@mattock> or is it a quickie?
14:20 <@dazo> heh :)
14:20 <@dazo> let's see! :)
14:21 <@mattock> james: any idea whether this is still an issue?
14:21 <@mattock> I remember seeing this first many moons ago
14:23 < jamesyonan> I haven't exhaustively tested it, but I do believe it's working
14:24 <@mattock> I can send a mail to -users and ask if people use this
14:24 <@mattock> if they do, we can then close the bug report
14:24 < jamesyonan> sounds good
14:25 <@mattock> ok, that was pretty quick...
14:25 <@mattock> enough for today, everyone?
14:26 <@dazo> think so!
14:26 <@dazo> jamesyonan:  I'll have a patch for you during tomorrow or so
14:26 < jamesyonan> great
14:27 <@mattock> ok, that concludes our meeting for today
14:27 <@mattock> I'll summarize the meeting tomorrow and link to the email from our new, shiny Trac instance
14:28 <@mattock> when we manage to discuss the roadmap, we could perhaps start creating tasks to Trac
14:28 <@dazo> mattock:  yes ... and it would be great to use the roadmap/milestone module in Trac for that as well
14:29 <@mattock> so it's more advanced than the one installed by default?
14:30 <@dazo> I honestly don't remember which one does what ... the important thing is the feature :)
14:30 <@mattock> I may have disabled the "Roadmap" feature for authenticated users (God knows why :)
14:30 <@dazo> one of them gives you possibility to set deadlines as well, and to see how the progress is going for each of the milestones, based on task status
14:31 <@mattock> then we only need somebody who can meet the deadlines :)
14:31 <@mattock> and will
14:31 <@dazo> :)
14:32 <@mattock> ok, but let's use Trac from now on for devel docs
14:32 <@mattock> without using it it's difficult to improve it
14:33 <@mattock> anything else?
14:35 <@dazo> Sounds like that's it :)
14:36 <@mattock> ok, bye all!
14:36 <@dazo> bye!

--------------000005040009000101010600--

