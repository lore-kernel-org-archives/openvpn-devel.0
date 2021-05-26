From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <5913da48-b476-7922-4248-8700ba21aa61@...515...>
Message-ID: <7d41c6b1-e495-840a-d296-d861295a1549@...515...>
Date: Wed, 26 May 2021 16:35:00 +0300
MIME-Version: 1.0
In-Reply-To: <5913da48-b476-7922-4248-8700ba21aa61@...515...>
Content-Type: multipart/mixed; boundary="------------932F998662AD09224488F0E3"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (26th May 2021)
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
--------------932F998662AD09224488F0E3
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit


Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 26th May 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-05-26>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, d12fk, ecrist, lev, mattock, ordex, plaisthos and syzzer 
participated in this meeting.

---

Talked about the "Add detailed man page section to setup a OpenVPN setup 
with peer-fingerprint" patch:

<https://patchwork.openvpn.net/patch/1823/>

Agreed that we should be consistent in what certificate and key file 
extensions we use in our documentation. Also agreed that this patch 
should be considered as-is, without thinking about all the other cases 
where our usage of file extensions might be inconsistent.

-- 

Talked about OpenVPN 2.5.2 and Windows ARM64. Once a few patches and PRs 
related to MSVC/MSI/building are merged we could release 2.5.2 for ARM64.

--

Talked about the Freenode vs. Libera controversy. Agreed to keep the 
bridge between these networks active until things possibly blow over. 
We'll revisit this topic next week.

--

Mattock gave an update on the dockerized Buildbot environment. It is now 
fully functional (in Vagrant) with buildmaster and about 11 latent 
(on-demand) containerized workers. T_client tests are working on a basic 
level, but for reasons unknown there's lot of packet loss, which 
apparently makes t_client tests fail. This could be a local problem so 
mattock won't debug it further.

The next step is to upgrade openvpn-vagrant's "msibuilder" VM to Windows 
Server 2019 to support WiX toolset 3.14, then use the same automation 
code to spin up on-demand (latent) EC2 Windows worker for buildbot. This 
allows us to get MSI snapshots as well.

---

Full chatlog attached



--------------932F998662AD09224488F0E3
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-05-26.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-05-26.txt"

(12:50:37) cron2: I might be late for the meeting today, a few minutes
(12:53:33) cron2: meeting right now seems to overrun, and what I need to =
get done "in between" is tight
(12:55:03) cron2: I do not have any specific points anyway (except IPv6!)=

(15:00:19) mattock: hi
(15:01:24) lev__: Hello
(15:01:46) dazo: hey!
(15:03:59) cron2: hi
(15:03:59) ***d12fk waves hello
(15:04:45) cron2: i am actually not here.. stuck i  the woods, 35 min hom=
e by bike and rain
(15:04:57) cron2: so just nexus7
(15:05:13) d12fk: at least you got net int he woods
(15:07:25) ***ordex is here
(15:07:26) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
1-05-26
(15:07:28) ***ordex waves fist
(15:08:31) plaisthos: I want to ask about the key/crt vs pem thing
(15:10:10) cron2: i think selva makes good points
(15:10:30) ordex: yeah
(15:10:32) ordex: think so too
(15:11:10) dazo: anyone got a pointer to his points?
(15:11:11) plaisthos: so I change that to key/crt that is used on the ser=
ver side
(15:11:34) plaisthos: we still also use conf instead of ovpn on linux so =
it is not consistent anyway
(15:11:54) plaisthos: but I don't have a strong enough feeling to fight f=
or pem file extensions
(15:12:00) ordex: right, but that'e less problematic imho
(15:12:13) ordex: key/crt/pem are really black boxes for most users, so e=
asier to mess up
(15:12:30) ordex: dazo: there is somee mail on the -devel ml - plaisthos =
what was the subject ?
(15:12:54) dazo: I vaguely recall seeing it, but I can't find it
(15:13:26) plaisthos: the tutorial of the peer-fingerprint v2 patch
(15:13:33) ordex: Re: [Openvpn-devel] [PATCH v2 2/2] Add detailed man pag=
e section to setup a OpenVPN setup with peer-fingerprint
(15:14:25) dazo: found it! thx!
(15:15:03) ordex: np
(15:16:23) dazo: I don't have any strong opinions either way.  I commonly=
 use $(prefix)-{cert,key}.pem ... as there are a few times it's been easi=
er to search for files that way and some tools have picked up the files o=
nly with .pem extension; but I acknowledge that Windows might prefer .crt=
 instead.
(15:17:42) cron2: personally i do not care much eithet way. we must be co=
nsistent, but this can be done either way
(15:17:59) dazo: This is essentially just a color of bikeshed variant ...=
=2E and it relates to whether we see the file extension as the "content" =
or "format" of the file
(15:18:11) dazo: cron2++
(15:18:48) ***dazo votes for consistency, whatever extension is preferred=

(15:18:50) d12fk: Windows display nice icons if you have the file extensi=
on right. it is all about that
(15:19:04) cron2: as well
(15:19:31) ordex: I also have no strong opinion, but vote for consistency=

(15:19:33) d12fk: thou shalt shall inline </discussion>
(15:19:47) dazo: :-D
(15:19:50) ordex: but it seems that .key/.crt is what has been out there =
longer (regarding openvpn files)
(15:20:14) plaisthos: the tutorial uses inline fo clients but not for the=
 server
(15:20:30) plaisthos: also what section is right one for the openvpn-exam=
ple man page
(15:20:31) cron2: ok, swimming home now... afk
(15:20:35) plaisthos: iirc I used 5 in my patch
(15:21:59) d12fk: i vote for do anything, do it consistently. file extens=
ions usually are no hurdle for ppl who (can) read man pages
(15:22:29) ordex: Section 5: File Formats and Conventions=20
(15:22:44) d12fk: foo-key.pem =3D=3D foo.key
(15:22:46) ordex: https://www.commandlinux.com/man-pages-sections
(15:24:12) d12fk: no extension would also be a good salomonian verdict ->=
 foo-key
(15:24:12) ordex: I guess section 5 is good then ?
(15:24:30) ordex: d12fk: and filename should be the fingerprint itself
(15:24:32) ordex: :p
(15:24:35) dazo: ordex: we could move our file format (and extension) sec=
tions into an openvpn(5) man page easily now=20
(15:24:53) ordex: yeah
(15:25:39) dazo: it's the matter of creating an openvpn.5.rst file, add t=
he appropriate ..include and add openvpn.5 to Makefile.am; and done.
(15:26:40) dazo: (well, I see we can add some improvements to Makefile.am=
 to make it very easy there, but that's a different topic)
(15:26:58) ordex: plaisthos: what else do you need to proceed with that p=
atch ?
(15:28:43) ***ordex shoots in the air
(15:30:45) mattock: I hope the bullet did not strike plaisthos on the way=
 down
(15:32:06) ordex: he'd be on the ground by now if I got him
(15:32:35) plaisthos: dazo: there is already a patch for that on the mail=
ing list
(15:32:55) dazo: plaisthos: I'll have a closer look, or was it the one I =
already commented on?
(15:33:17) plaisthos: and while man pages in multiple section with the sa=
me name are okay I most times find them rather user unfriendly
(15:33:47) plaisthos: dazo: no, the v2 has a add openvpn-examples 1/2 and=
 the actual tutorial in 2/2
(15:34:03) dazo: alright, I'll give it a look
(15:34:31) vpnHelper ha abbandonato la stanza (quit: Quit: Limnoria 2021.=
05.24).
(15:34:37) ordex: cool
(15:35:21) dazo: agreed that same-name man pages can be confusing unless =
you know the section you want in advance .... and I see other projects us=
e their commonly used config name or similar concepts to avoid this
(15:35:28) dazo: openvpn-examples are fine too
(15:36:02) vpnHelper [~limnoria@...1423.../vpnHelper] =C3=A8 entrato nella s=
tanza.
(15:36:43) mattock: anything else on this?
(15:37:21) dazo: I'd say we consider the current patches as is, and then =
we clean up extension usage across all documentation afterwards
(15:38:01) ordex: yap
(15:38:24) mattock: next topic?
(15:39:08) mattock: anything else on 2.6 or 2.5?
(15:39:45) ordex: not much I think - I have more patches on my shoulders =
to review
(15:39:50) ordex: going through those
(15:40:01) mattock: ok
(15:40:11) ordex: IPv6? :>
(15:40:12) ***lev__ is waiting for arm64/dco patches review
(15:40:15) dazo: I think 2.5 can sit on the fence a bit more to collect m=
ore fixes; nothing really urgent there currently
(15:40:31) dazo: and get 2.6 related work moving forward
(15:40:48) ordex: yap yap
(15:40:49) mattock: +1
(15:40:53) ordex: train is moving forward
(15:40:55) ordex: chooo chooo
(15:40:56) lev__: with a few patches acked, we could get 2.5.2 arm64 rele=
ase
(15:41:17) ordex: lev__: are the arm64 patches touching just the msvc pro=
ject files or code too ?
(15:41:37) lev__: msvc only, plus openvpn-build/msi=20
(15:41:59) ordex: ok
(15:42:04) ordex: well, may nt be a bad idea then
(15:42:06) ordex: *not
(15:42:18) ordex: are there really people out there asking for windows/ar=
m64 support?
(15:42:40) lev__: MSFT=20
(15:42:46) ***d12fk fears it could go like Windos Phone
(15:43:18) ordex: up up up and then .. forgotten?
(15:43:19) ordex: :D
(15:43:27) mattock: maybe newer arm64 windows hardware is better
(15:43:39) mattock: the one I and lev have is not a speed daemon
(15:43:49) mattock: ok-ish, but not blazingly fast
(15:44:01) mattock: if there _is_ newer hardware, that is :D
(15:44:12) mattock: if not, I tend to share d12fk's fears :)
(15:44:24) ordex: hehe
(15:44:27) ordex: what's next on the list?
(15:44:40) ordex: freenode vs libera
(15:45:10) mattock: I think so
(15:45:10) d12fk: let freenode die quickly
(15:45:12) mattock: IPv6 =3D no
(15:45:16) mattock: +1
(15:45:23) d12fk: mattock: have you fixed the freenode mentions in the cr=
m?
(15:45:36) mattock: no
(15:45:37) mattock: yet
(15:45:56) ordex: imho we should just mute the channel (optional), mentio=
n libera on our community website and put that link in freenode as topic
(15:45:57) mattock: by crm you mean meeting invitations etc?`:)
(15:46:00) d12fk: should be done soon so google can pick it up
(15:46:13) d12fk: for ppl searching for "openvpn irc"
(15:46:19) mattock: yep
(15:46:23) plaisthos: with the episode that they deregistered #openvpn-de=
vel for some policy violation (liberia in the topic) I lost hope in freen=
ode
(15:46:35) ordex: *libera* :D
(15:46:44) ordex: same here
(15:47:01) d12fk: they did, l=C3=B6l
(15:47:08) d12fk: diggin faster
(15:49:21) d12fk: we could stop the bridge and have a bot in the channels=
 pinting ppl in the right direction
(15:49:41) d12fk: *the freenode channels
(15:49:52) ordex: yeah
(15:50:04) ordex: or just the topic, after all a link is a link, can't vi=
olate the policy per se
(15:50:24) ordex: but I would also stop the bridge - otherwise people wil=
l continue using freenode
(15:50:34) d12fk: depends if you can say jehova
(15:51:06) ordex: :D
(15:51:13) dazo: blasphemy!
(15:51:18) syzzer [~steffan@...2615...] =C3=
=A8 entrato nella stanza.
(15:51:26) ordex: ah!
(15:51:29) ordex: syzzer!
(15:52:04) syzzer: yeah! was totally surprised to see libera forwarded me=
ssages on freenode
(15:52:17) mattock: hi!
(15:52:22) ecrist [~ecrist@...2616.../ecrist] =C3=A8 entrato nella stanza.
(15:52:30) ecrist: hola
(15:52:46) dazo: so brought in ecrist here as he does the irc bot and up =
stuff=20
(15:52:55) ordex: hola
(15:52:56) dazo: and freenode has been discussed here for a few minutes
(15:53:04) ordex: we were discussing what to do with freenode
(15:53:08) syzzer: it's been years since I've touched my IRC / bouncer se=
tup, need to figure out again how to make it connect to libera :')
(15:53:24) ordex: syzzer: we've all gone through that in the past 3 days
(15:53:24) ordex: :D
(15:53:28) syzzer: hehe
(15:53:33) dazo: ordex suggest muting freenode channels ... d12fk suggest=
s having a bot replying to messages asking them to move over to libera.ch=
at
(15:54:11) syzzer: I have no opinion on this, so I'll just lurk a bit
(15:54:15) d12fk: iff freenode censors libera in / topic
(15:54:17) mattock: start with the bot, then in a month mute?
(15:54:28) dazo: wfm!
(15:54:49) ecrist: I think we simply update our external links/etc pointi=
ng to libera and I finish setting up the wormhole and we leave it at that=

(15:55:15) ordex: ecrist: the downside is that people joining freenode wi=
ll not be pushed to move to libera if the worm continue to work all time =
long, no?
(15:55:23) ordex: *continues
(15:55:27) ecrist: really, from everyone but my own perspective, there's =
nothing to do
(15:55:39) ecrist: why do we have to push people anywhere?
(15:56:00) ecrist: I still have a bunch of channels I'm not leaving that =
will remain on freenode
(15:56:06) d12fk: fundamentalism
(15:56:12) mattock: well said!
(15:56:28) ecrist: what fundamental? =20
(15:56:48) mattock: the mentality that we have to move to libera.chat bec=
ause freenode is now on the dark side
(15:56:54) ecrist: I've read through all the statements from both "sides"=
 of this squabble and I'm not convinced the opers are right
(15:57:04) mattock: http://techrights.org/2021/05/19/freenode-and-cancel-=
culture/
(15:57:08) vpnHelper: Title: The Panic Over Freenode Isn=E2=80=99t Justif=
ied and Its Reaction Mostly Disproportionate | Techrights (at techrights.=
org)
(15:57:23) mattock: I did not research enough to know if that articles ma=
kes good arguments or not
(15:58:11) dazo: I'm also not convinced opers are fully right, but I also=
 don't trust tomaw=20
(15:58:14) ecrist: my understanding is the crux of the argument is that t=
he owners of freenode want to decentralize it and hand control of linked =
servers to their sponsors (who own the server/etc) like IRC used to do ba=
ck "in the day"
(15:58:18) d12fk: my point is, I was happy with the ops so far, so I'll s=
tick with them, i.e. move to libera
(15:58:29) ecrist: the freenode opers didn't want to lose control
(15:58:47) ecrist: d12fk: nothing wrong with that at all
(15:59:14) ecrist: keeping our wormhole open doesn't really cause any tro=
uble (once I finish the bot config), so why do we as a group really care?=

(16:00:00) d12fk: mostly because: [09:14] <vpnHelper> mattock has quit fr=
eenode (Quit: ZNC 1.6.6+deb1ubuntu0.2 - http://znc.in)
(16:00:03) vpnHelper: Title: ZNC (at znc.in)
(16:00:21) ecrist: d12fk: I'm working to get rid of those messages
(16:00:24) d12fk: if freenode would be silent on libera, fine
(16:00:38) ecrist: what do you mean?
(16:00:54) plaisthos: all the joins etc message are pretty annoying
(16:01:04) ordex: my question would be: why did we move if we want to kee=
p the connection to freenode?
(16:01:25) ordex: plaisthos: when they are notices, you can easily ignore=
 them
(16:01:31) ordex: (most clients can)
(16:01:41) ecrist: even when they aren't notices, you can easily filter t=
hem
(16:01:53) ecrist: being notices makes it easier, though
(16:02:22) ordex: yeah
(16:02:49) ecrist: and again, as I've stated multiple times now, I'll get=
 the bot upgraded and fixed so those notices go away
(16:03:15) mattock: sounds good
(16:04:07) plaisthos: the good old IRC days where one server operator was=
 so bad that people creates Eris free network? :D
(16:04:09) ecrist: I have some amount of attachment to the openvpn channe=
ls on freenode as I founded them back in 2008 with krzee
(16:04:26) ecrist: for whatever that's worth
(16:04:31) mattock: so: ecrist fixes the bot, nothing else will happen fo=
r now?
(16:04:51) mattock: we'll wait a while until this things blows over or if=
 it does not, finalize the move to libera?
(16:05:11) d12fk: try to link libera again in / topic?
(16:05:12) ecrist: "finalize" should be discussed
(16:05:34) ecrist: I do not plan on leaving freenode, and will keep those=
 channels open
(16:05:39) ecrist: I will also be here
(16:05:56) ecrist: we are not going to mention libera in /topic on freeno=
de
(16:06:42) dazo: to get another view on this freenode conflict: https://g=
ist.github.com/prawnsalad/4ca20da6c2295ddb06c1646791c61953
(16:08:58) mattock: I think we're done here
(16:09:10) mattock: let's not do anything hasty (anymore)
(16:09:11) syzzer_ [~syzzer@...2615...] =C3=
=A8 entrato nella stanza.
(16:09:36) ***ecrist recalls being the voice of reason between open sourc=
e and OpenVPN Tech back in the day, too
(16:09:50) ecrist: especially once mattock was hired
(16:10:13) mattock: yep
(16:10:21) mattock: let's see where we are at next week
(16:10:35) mattock: ok I need to split
(16:10:40) ecrist: later
(16:10:42) ecrist ha abbandonato la stanza (thanks).
(16:10:43) mattock: just a quick update on buildbot
(16:10:44) dazo: ecrist and krzee are the guys who convinced me not to fo=
rk openvpn right before that ... as I got no response to patches on -deve=
l list for months ......
(16:11:09) mattock: dockerized buildmaster + ~11 worker is fully function=
al with t_client.sh tests and all
(16:11:20) dazo: \o/ great work!
(16:11:48) mattock: for reasons unknown I get lot of packet loss in t_cli=
ent tests, which seems to result in test failures
(16:11:58) mattock: but that may be a local problem and I won't debug it =
further right now
(16:12:11) mattock: the next step is to work on the Windows MSI worker
(16:12:19) mattock: which will build us MSI packages
(16:12:23) mattock: snapshots
(16:13:02) mattock: actually, first upgrade openvpn-vagrant's "msibuilder=
" VM to Windows Server 2019 to support WiX toolset 3.14, then use the sam=
e automation code to spin up on-demand (latent) EC2 Windows worker
(16:13:03) dazo: mattock: this is run inside docker containers?  could it=
 be lacking privileges to get access to raw sockets (which ping requires)=
?
(16:13:10) syzzer ha abbandonato la stanza (quit: Quit: leaving).
(16:13:11) mattock: no
(16:13:16) ordex: what a drama btw
(16:13:16) ordex: :D
(16:13:29) mattock: well, NET_RAW is missing, but ping works on a basic l=
evel, just packet loss
(16:13:39) dazo: okay
(16:13:46) mattock: anyhow, that's all on  buildbot
(16:13:52) mattock: we're done for today?
(16:13:55) mattock: 13 minutes overtime
(16:13:57) dazo: sounds so :)
(16:15:47) mattock: ok, I'll have to write the summary later
(16:15:59) mattock: unless I'm really quick, let's see

--------------932F998662AD09224488F0E3--

