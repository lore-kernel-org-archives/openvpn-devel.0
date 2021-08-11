From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <420f8ab2-24ed-e57d-cc83-1c3b4beaea92@...515...>
Message-ID: <3d413b92-6e87-c52d-8738-1e2b209d96e2@...515...>
Date: Wed, 11 Aug 2021 16:38:58 +0300
MIME-Version: 1.0
In-Reply-To: <420f8ab2-24ed-e57d-cc83-1c3b4beaea92@...515...>
Content-Type: multipart/mixed; boundary="------------4A58E33F3DB00FF3BA53E4E3"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (11th August 2021)
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
--------------4A58E33F3DB00FF3BA53E4E3
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on libera.chat
Date: Wed 11th August 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-08-11>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock, MaxF, ordex, plaisthos and zx2c4 participated 
in this meeting.

---

Ordex has sent a patch to get rid of PF support in openvpn 2.6.

---

Talked about the pluggable transport patchset that was funded by Google 
and implemented by Operator Foundation. Ordex is still in discussion 
with the involved parties.

---

Talked about the new buildbot setup. Mattock attempted to start setting 
up the production dockerized buildmaster, but lacked permissions to 
create the EC2 instance (not being in ops anymore). He created an 
internal ticket about this to get things moving forward.

Mattock also published the buildbot work as a PR to openvpn-vagrant:

<https://github.com/OpenVPN/openvpn-vagrant/pull/18/>

He also started adapting the MSI installer WiX source files to take the 
results of new built-in msbuild buildsystem in OpenVPN as their source.

---

Talked about AutoHCR also known as HLK-CI. It is now testing 
tap-windows6 pull requests automatically. Permissions are handled by a 
separate "openvpn-ci" GitHub user created by mattock who has write 
permissions to tap-windows6. Those permissions are, however, narrowed 
down by providing the HLK-CI guys openvpn-ci's GitHub PAT ("personal 
access token") that only grants "repo:status" permission. Tests results 
are uploaded automatically to a Dropbox share.

Also noted that attempting to resolve all the issues found by HLK(-CI) 
is probably not worth the effort, given that there are already better 
drivers to replace it.

---

Lev gave an update on dco-win. He plans to look into doing crypto 
directly on network buffers without copying, which should make it even 
faster.

---

Talked about Wintun. Zx2c4 mentioned that many people would like to have 
an updated version of Wintun included in OpenVPN. Wintun will continue 
to be maintained despite the fact that a new driver will replace it in 
Wireguard.

---

Talked about profile import functionality for openvpn-gui:

<https://github.com/OpenVPN/openvpn-gui/pull/436>

Noted that while this approach is quite brutal, it is the only one that 
seems to work reliably across all platforms.

-- 

Full chatlog attached

--------------4A58E33F3DB00FF3BA53E4E3
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-08-11.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-08-11.txt"

(15:01:14) MaxF: Hi!
(15:01:19) mattock: hi!
(15:03:37) lev___: hello
(15:05:35) ordex: hi!
(15:05:43) ordex: cron2_: dazo: plaisthos:=20
(15:06:00) ordex: cron2_ will be a bit late
(15:08:52) dazo: Hey!
(15:09:00) cron2_: hy
(15:09:16) ordex ha scelto come argomento: https://community.openvpn.net/=
openvpn/wiki/Topics-2021-08-11
(15:09:58) ordex: please be quiet !
(15:10:11) ordex: it seems we're too much into summer mode
(15:10:16) ordex: mattock: do something! :D
(15:10:48) mattock: hi
(15:10:51) mattock: sorry, got distracted
(15:11:01) mattock: anyhow
(15:11:24) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
1-08-11
(15:11:28) mattock: sync up
(15:11:51) ordex: more patches went in
(15:12:02) ordex: I sent a patch to get rid of PF support in openvpn 2.6
(15:12:06) ordex: as discussed
(15:12:21) cron2_: yes!
(15:13:08) ordex: <o/
(15:13:54) ordex: for the transport-api I am still discussing with the in=
volved parties what are the advantages of pushing for a merge, when an ex=
ternal proxy seems to do the job already
(15:14:06) plaisthos: sorry fore being late
(15:14:14) ordex: and if there are advantages, who will offer 'community =
mainteinance'
(15:14:21) ordex: it's an ongoing discussion at the moment
(15:14:21) cron2_: ordex: proxy will only do TCP mode, right?
(15:14:34) plaisthos: the plugin api was also tcp only iirc
(15:14:41) ordex: cron2_: I don't know what their "proxy" (they call it d=
ispatcher) do=20
(15:14:42) cron2_: well, if the proxy offers a SOCKS interface, it could =
do UDP...
(15:14:52) ordex: nono, it's not a proxy in the real sense
(15:15:00) ordex: but rather a middleware implementing the obfuscation
(15:15:14) ordex: I don't know the low level details, but it should be do=
ing what the plugin in openvpn does
(15:15:16) cron2_: yeah, but openvpn needs to talk to it, in some way
(15:15:21) ordex: right
(15:15:26) ordex: it could just be the remote
(15:15:54) ordex: anyway, if this is a real problem I guess they will poi=
nt it out once they will get back to me
(15:15:54) cron2_: good point ("remote ::1 12345 udp")
(15:16:05) ordex: right
(15:17:02) d12fk ha abbandonato la stanza (quit: Quit: ZNC 1.7.2+deb3 - h=
ttps://znc.in).
(15:17:24) d12fk [~heiko@...2633...] =C3=A8 entrato nella stanza.
(15:18:32) ordex: not much else to add to this topic for now
(15:18:35) ordex: will keep you posted
(15:19:58) mattock: ok
(15:20:23) mattock: I can give a brief update as well
(15:20:28) cron2_: 1
(15:20:30) cron2_: +
(15:21:09) mattock: I tried to start setting up the new production buildm=
aster
(15:21:29) cron2_: I saw your PR, but had no time to look more closely
(15:21:33) mattock: however, I was immediately blocked by the fact that I=
 did not have access to the terraform repository in which I should have a=
dded the EC2 instance
(15:21:46) mattock: so, I filed a ticket asking for permission to the rep=
ository
(15:21:53) mattock: did not yet check if I got an answer
(15:22:03) mattock: meanwhile I created a PR for the dockerized buildbot =
work
(15:22:24) mattock: and started working on adapting WiX to consume the re=
sults of the new msbuild buildsystem
(15:22:44) cron2_: that sounds pretty cool
(15:22:46) mattock: the PR is in a good shape afaics, but WiX is fighting=
 back and does not provide much debugging info to figure out what is wron=
g
(15:23:06) mattock: in theory adapting the WiX source files is easy, ther=
e's probably just some small glitch somewhere
(15:23:41) mattock: anyhow, that's what I'll continue doing
(15:23:54) ordex: may I dare to ask what is WiX?
(15:24:14) mattock: yes, it is the tool that is used to compile WiX XML f=
iles into MSI installer packages
(15:24:27) mattock: so XML is the source and WiX makes it into an install=
er
(15:24:42) ordex: oh I see
(15:24:43) ordex: cool
(15:24:53) mattock: our official MSI installer are built using WiX
(15:24:59) ordex: so to create the MSi we need to only maintain the XML f=
ile ?
(15:25:06) mattock: yes
(15:25:10) ordex: oky, cool
(15:25:34) mattock: also, if this was not mentioned before: the tap-windo=
ws6 automatic HLK/HCK test thing is working
(15:25:59) ordex: oh ok
(15:26:12) cron2_: coool
(15:26:30) cron2_: could you sort out the permission issues for the tap-w=
indows6 repo?
(15:26:42) mattock: the openvpn-ci user in github you see in tap-windows6=
 repo permissions is for that purpose
(15:26:49) mattock: yes
(15:26:57) mattock: the openvpn-ci user was created by me
(15:26:57) cron2_: so what permissions does it need?
(15:27:02) mattock: ok, so
(15:27:13) cron2_: they were asking for permissions last week, I gave the=
m "triage" but did not want to give them "write"
(15:27:14) mattock: openvpn-ci user has "write" access to tap-windows6 re=
po
(15:27:34) mattock: however, it gains the write access via GitHub PAT ("P=
ersonal Access Token") which only grants "repo:status" permission
(15:27:41) mattock: so basically the PAT narrows down the permissions
(15:27:47) cron2_: aha!
(15:27:57) mattock: and we (=3Dme) control the user + PAT, so they can't =
write anything to the repo with the PAT
(15:28:08) mattock: except change the "build failing/succeeding" thing
(15:28:20) cron2_: this is good (and way beyond my understanding of githu=
b things)
(15:28:54) mattock: yes, it seems like a reasonable setup, even though us=
ing personal access tokens for this seems unhygienic :)
(15:29:04) mattock: but apparently that's the easiest (or only reasonable=
?) way to do this
(15:29:21) mattock: that's all from my end
(15:29:59) cron2_: so what does this setup *do*?  Automatic WLK/HLK tests=
 on each commit to tap-windows6, and feedback?
(15:30:05) mattock: yes
(15:30:17) mattock: it also puts all the test logs into a dropbox share
(15:30:36) mattock: I think this is quite useful to spot regressions
(15:30:48) mattock: the dco-win thing is still on the plate I think
(15:30:55) mattock: testing dco-win with HLK/HCR
(15:30:56) mattock: lev?
(15:31:07) cron2_: so we need to commit something to tap6-windows to get =
a HLK test result :)
(15:31:10) cron2_: does it pass nowadays?
(15:31:15) lev___: yeah I haven't heard for a while from those guys about=
 dco-win
(15:31:42) mattock: cron2: yes, exactly
(15:31:47) mattock: it does not pass, but it never has
(15:31:50) mattock: most of the things pass
(15:31:58) mattock: so if more things start failing then that's a regress=
ion
(15:32:01) cron2_: ic
(15:32:08) cron2_: does anyone understand what is failing and why?
(15:32:11) mattock: it seemed like HLK-testing tap-windows6 was a quite d=
ifficult corner-case
(15:32:25) mattock: a driver that did not really fit into any preconceive=
d category
(15:32:36) mattock: no, I spend ages on getting most of the HLK tests pas=
s
(15:32:38) mattock: spent
(15:32:51) mattock: I can't recall all the details, but those are documen=
ted in the Wiki
(15:32:58) lev___: for me HLK is a black box
(15:33:06) cron2_: I do remember the shared pain
(15:33:30) mattock: anyhow, once the perceived need to make the tests pas=
s vanished, so did my efforts to make the tests pass :)
(15:33:58) ordex: is there real interest in "improving tap-windows6" ?
(15:34:07) mattock: probably not a huge amount
(15:34:14) mattock: it works and is stable, even if slow
(15:34:18) mattock: then we have dco-win
(15:34:38) ordex: right
(15:34:42) mattock: microsoft is also slowly getting rid of NDIS
(15:35:11) mattock: I think at that point tap-windows6 will be beyond sal=
vaging
(15:35:38) ordex: yeah
(15:35:51) mattock: lev: aren't you using a completely different framewor=
k for dco-win?
(15:36:03) lev___: NetAdapterCx
(15:37:11) lev___: it is uses NDIS underneath, though, but that's how dri=
ver development works in windows - new stuff is built on top of old stuff=
 (WDF on top of WDM, for instance)
(15:37:16) lev___: *it uses
(15:37:59) lev___: "NetAdapterCx gives you the power and flexibility of W=
DF and the networking performance of NDIS, and makes it easy to write a d=
river for your NIC."
(15:38:38) ordex: well, it won't go EoL with NDIS, no?
(15:38:45) rob0 [~rob0@...1423.../support/rob0] =C3=A8 entrato nella stanza.=

(15:39:09) cron2_: I'm not so sure NDIS will go EOL in the near future...=
  especially if it's used by NetAdapterCx=20
(15:39:29) cron2_: but maybe discouraged for new drivers
(15:39:34) lev___: it won't, but the development focus is in NetAdapterCx=

(15:39:47) ordex: makes sense
(15:39:48) lev___: they're very good at compatibility
(15:40:39) lev___: speaking of ovpn-dco, MaxF did a great job on reproduc=
ible builds
(15:41:16) ordex: cool
(15:41:26) MaxF: thanks :)  I'll have a new pull request ready today for =
more comments, and then I'll send it to the mailing list
(15:41:57) ***cron2_ just merged MaxF's patch
(15:43:09) MaxF: since ovpn-dco-win is only for Windows 10, what are the =
plans for wintun? Do you stick with the old version?
(15:44:14) lev___: so far, yes
(15:44:22) cron2_: oh, I overlooked plaisthos' ACK ("we never have *two* =
ACKs for a patch...") so only recorded ordex'.  Sorry.
(15:44:31) ordex: ah!
(15:44:34) ordex: <o/
(15:46:18) lev___: win10 market share among windows was 78% in june
(15:46:47) lev___: and with coming win11 windows7/8 share should drop
(15:47:53) cron2_: orr... parallels wants 50 EUR for the update to the ne=
xt version...
(15:48:10) cron2_: can't wait for vmware on M1 and kick parallels again
(15:48:46) lev___: for ovpn-dco I plan to look into doing crypto directly=
 on network buffers without copying, which should make it even faster
(15:50:03) lev___: is it already pretty fast, so as soon as plaisthos sen=
ds his dco-win patches I'm going to review/test those=20
(15:52:37) MaxF: interesting. So OpenVPN passes the AES key to the driver=
, and then the driver does the symmetric crypto?
(15:52:41) cron2_: yes
(15:52:54) cron2_: same for dco-linux
(15:53:01) cron2_: which we want to see patches for :)
(15:53:13) ordex: it's the next train on the horizon
(15:53:22) ordex: once we get rid of compat-mode and crresponse
(15:55:00) plaisthos: MaxF: Jason already announced wireguard will eventu=
ally no longer use wintun
(15:55:45) cron2_: huh, what will wireguard use instead?
(15:56:12) plaisthos: so I think for now both users of wintun (that *I* a=
m aware of) still support the non DCO variant and sometime in the feature=
, openvpn will concentrate ovpn-dco-win and wireguard on its WireguardNT
(15:56:14) lev___: wireguard-nt
(15:56:31) plaisthos: cron2_: WireguardNT, also an in kernel driver that =
handles all the data in kernel
(15:56:46) zx2c4: Wintun will continue to be maintained
(15:56:48) plaisthos: might also do the control channel or not, haven't l=
ook deeply at it
(15:56:52) cron2_: ic
(15:57:04) zx2c4: A lot of people would really appreciate if openvpn inco=
rporated the latest
(15:57:12) zx2c4: I get emails about that regularly
(15:57:28) cron2_: why do they mail you, not us, for openvpn feature requ=
ests?
(15:57:50) rob0: "I switched to wg because openvpn ..."
(15:58:16) cron2_: yeah, but *that* is usually not due to "old wintun" bu=
t to openvpn being old and bloated and all that
(15:58:31) zx2c4: cron2_: because your misuse of wintun causes issues tha=
t then come to me
(15:58:46) lev___: it is much more than updating version number, we would=
 have to change the way we talk to the driver, update installer etc
(15:59:07) zx2c4: Either strip it out or do it properly, id say
(15:59:13) zx2c4: Its not hard to do it properly
(15:59:28) zx2c4: Wintun.h is easy to intrgrate
(15:59:59) zx2c4: Integrate (sorry, typing in my phone)
(16:00:30) MaxF: what kind of issues are happening with wintun in openvpn=
?
(16:01:49) plaisthos: cron2_:=20
(16:01:49) plaisthos: NAK to the proposed approach, because that would gi=
ve us incompatible
(16:01:49) plaisthos: (and unfixable-incompatible) versions in between.
(16:02:12) cron2_: plaisthos: to what ordex proposed ("change all the def=
aults first, and then bring in --compat-mode")
(16:02:17) plaisthos: yeah
(16:02:19) cron2_: yeah, maybe not "unfixable"
(16:02:20) plaisthos: I know
(16:02:32) plaisthos: compat-mode is only about easier fix
(16:02:34) ordex: I replied already
(16:02:48) plaisthos: so you could do compat-mode 2.3.0 or tls-version-mi=
n 1.0
(16:02:55) plaisthos: I am trying to understand the problem
(16:03:14) ordex: plaisthos: the problem cron2_ raised is about changing =
the default in patch 1 and then adding compat-mode in patch2
(16:03:26) plaisthos: cron2_: or do you want to have setenv opt compat-mo=
de 2.4 in your config and forget aboutr it
(16:03:31) ordex: between patch1 and patch2 there would be incompatibilit=
y
(16:03:51) mattock: btw. 3 hours over the one hour mark
(16:04:00) mattock: sorry
(16:04:02) cron2_: 3 hours! damn!
(16:04:03) mattock: 3 minutes :)
(16:04:13) mattock: only one time unit can be in my head once
(16:04:20) MaxF: time flies
(16:04:47) ordex: lol
(16:04:57) ordex: the compat-mode discussion can continue on the ml or on=
 openvpn-devel
(16:05:05) ***rob0 grabs the time flyswatter
(16:05:08) cron2_: maybe we need to find a google docs and write a good c=
ommit message together
(16:05:09) ***lev___ is aggressively waiting for comments on https://gith=
ub.com/OpenVPN/openvpn-gui/pull/436
(16:05:31) ***lev___ looks at cron2_=20
(16:05:31) rob0: (a rolled up Time Magaine)
(16:05:36) ordex: cron2_: +1 we can use etherpad
(16:06:03) plaisthos: I am not sure I mentioned it here
(16:06:06) mattock: anything else we should cover in this meeting?
(16:06:14) mattock: or just continue on #openvpn-devel?
(16:06:29) ordex: not from me
(16:06:33) cron2_: lev___: I said I'm not very much interested in that wa=
y of doing things - I won't NAK it, but I am not eager to spend time revi=
ewing it, when ordex is waiting with other stuff
(16:06:35) plaisthos: but I am adding an openvpn://profile-file/https://u=
rl/to/some/profile=20
(16:06:51) cron2_: plaisthos: what is that?
(16:07:13) plaisthos: basically "click on that in browser, client opens a=
nd asks you if want to import that profile"
(16:07:33) ordex: plaisthos: adding where exactly?
(16:08:16) cron2_: plaisthos: I find this a more logical workflow, but te=
chnically, not very nice either.  What is wrong with "just download the t=
hing in the browser, with a mime-type that tells $OS 'this needs to go to=
 the openvpn client for importing'?
(16:08:23) cron2_: This works beautifully on iOS today
(16:08:44) cron2_: so, no need for any http download logic in the client
(16:11:12) cron2_: anyway
(16:11:23) cron2_: I have another meeting rsn and need to prepare... so o=
ff for the moment
(16:11:55) mattock: I need to split as well
(16:11:59) mattock: let's conclude this thing
(16:12:04) mattock: I'll write the summary next

--------------4A58E33F3DB00FF3BA53E4E3--

