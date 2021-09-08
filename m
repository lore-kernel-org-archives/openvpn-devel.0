From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <604d3782-646c-4f12-b789-2ae9ebbae069@...515...>
Message-ID: <5a4b02da-4703-585f-27d8-c719a983a7f6@...515...>
Date: Wed, 8 Sep 2021 16:15:26 +0300
MIME-Version: 1.0
In-Reply-To: <604d3782-646c-4f12-b789-2ae9ebbae069@...515...>
Content-Type: multipart/mixed; boundary="------------0D4137D3CB75D12D87950F5E"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (8th September
 2021)
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
--------------0D4137D3CB75D12D87950F5E
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on libera.chat
Date: Wed 8th September 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-09-08>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock, MaxFm, ordex, plaisthos and rob0 participated 
in this meeting.

---

Plaisthos is fixing the Ubuntu GitHub Actions.

---

Mattock got distracted by some Access Server packer work and is still 
waiting for access to the Terraform repo he needs to spin up an updated 
buildmaster. Agreed to start discussions with OpenVPN Inc. ops team to 
facilitate quicker infrastructure deployments. Right now waiting time is 
very long for the core team and community.

---

The compat mode patches are being reviewed. They're quite important to 
get the review of dco going.

Ordex is reviewing dco patches from plaisthos so that he can start 
sending them to the mailing list.

---

Lev implemented zerocopy for Tx datapath in dco-win. He's now working on 
Rx datapath. This won't affect the driver API.

---

Noted that there is no progress on the IPv6 front.

---

Talked about the issue with Red Hat / CentOS 8 in FIPS mode:

<https://patchwork.openvpn.net/patch/1915/>

Agreed that the code is good enough for now. When OpenSSL 3.0.0 becomes 
a thing the code paths can be changed again.

Dazo will look into the patch on a fresh Red Hat 8 box.

-- 

Full chatlog attached

--------------0D4137D3CB75D12D87950F5E
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-09-08.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-09-08.txt"

(15:01:47) mattock: hello
(15:02:32) MaxF: hi!
(15:02:47) ordex: hi!
(15:02:49) lev__: hello
(15:02:56) ordex: **buurp**
(15:03:07) ***ordex summons cron2=20
(15:03:37) ordex: **buuuuuuurp**
(15:03:39) ***ordex summons cron2 !!
(15:04:06) ordex: ECONNREFUSED
(15:04:21) cron2: wat
(15:04:35) ordex: there you go
(15:04:55) ordex: I guess dazo won't be able to join
(15:05:01) ordex: plaisthos should be in the surroundings
(15:05:06) ordex: maybe hiding in the bushes
(15:05:23) plaisthos: moin=20
(15:06:01) rob0: shhhh I was trying to sleep
(15:06:23) mattock: hi all
(15:06:45) plaisthos: I am doing a patch to fix the Ubuntun github action=
 thingy ...
(15:09:04) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
1-09-08
(15:09:42) ordex: regarding 2.5 - do we have anything in the pipe?
(15:11:33) dazo: hey!
(15:11:35) dazo: sorry ... just forgot about time today
(15:13:20) cron2: good morning, sir :-)
(15:13:44) dazo: :)
(15:13:47) mattock: I don't have anything about 2.5 or 2.6, got distracte=
d by some AS packer work and still waiting for access to the terraform re=
po I'd need to spin up updated buildmaster
(15:14:01) ***cron2 has nothing on 2.5 either
(15:14:24) plaisthos: nothing for 2.5 on my side
(15:14:30) dazo: mattock: lets bring that terraform issue up internally .=
=2E.. this is being delayed too long now
(15:14:35) mattock: yes
(15:14:48) MaxF: what's that?
(15:15:04) mattock: I think this has to do with the more generic problem =
of ops team not being able to provision infrastructure for the core team =
in a timely manner
(15:15:15) dazo: +1
(15:15:28) mattock: MaxF: I need access to an operations' repository in o=
rder to be able to create the new production buildmaster
(15:18:32) ordex: ok
(15:18:40) ordex: for 2.6 I think some progress can be seen on the mailin=
g list
(15:18:58) ordex: compat mode is being reviewed - that is quite important=
 to get the review of dco going
(15:19:09) ordex: (that is the next thing on the radar)
(15:19:21) ordex: I am checking arne's dco patches before he can start se=
nding them to the ml
(15:21:09) lev__: on dco-win I implemented zerocopy for Tx datapath, now =
working on Rx datapath
(15:21:52) lev__: this is obviously internal change, doesn't affect drive=
r API
(15:23:01) MaxF: faster drivers are good!
(15:23:26) cron2: +1
(15:24:12) MaxF: I guess I should check now and then if reproducible buil=
ds still work in dco-win
(15:25:02) lev__: I haven't committed anything to master yet, although th=
ere is "zerocopy" branch in my fork
(15:28:27) mattock: anything else noteworthy?
(15:28:38) cron2: ipv6?
(15:28:47) mattock: no progress
(15:30:38) ordex: :(
(15:30:50) mattock: can we conclude the meeting?
(15:31:05) cron2: wait :-)
(15:31:30) cron2: dazo, ordex: how shall we proceed with the FIPS thing? =
 Maybe dazo has a CentOS 8 test environment ready?
(15:31:44) cron2: https://patchwork.openvpn.net/patch/1915/
(15:31:45) cron2: this one
(15:32:01) ordex: I was just commenting
(15:32:05) ordex: I don't like this patch
(15:32:14) dazo: cron2: it's already on my todo-list ... just need to cle=
ar some time getting a testbox configured with FIPS and test it.  Code lo=
oks reasonable, just wanted to test it before ACK
(15:32:21) ordex: FIPS_mode() exists only in openssl-1.0.2, that is even =
dead for upstream
(15:32:26) plaisthos: I can spawn an AWS instance for whoever wants to te=
st that
(15:32:39) plaisthos: ordex: RHEL8 fips also has FIPS_mode()=20
(15:32:49) ordex: in openssl-1.1.1 there is no such function and in opens=
sl-3.0.0 they dropped it in favour of something else
(15:33:09) ordex: then we should check for something more specific, becau=
se this code is gonna change as soon as we try openssl-3.0.0
(15:33:25) plaisthos: but on rhel8 you do 'fips-mode-setup --enable'=20
(15:33:33) plaisthos: and then the system always puts openssl into fips m=
ode
(15:33:49) dazo: ordex: I suspect RHEL builds of openssl got a backport o=
f that function; fips is a big thing for the US gov users - where RHEL is=
 quite dominant
(15:33:59) plaisthos: dazo: it is more a forward port
(15:34:00) ordex: dazo: what openssl version does it ship?
(15:34:11) plaisthos: dazo: fips in openssl 3 is completely different
(15:34:11) dazo: plaisthos: ahh, right :)
(15:34:12) ordex: 1.1.1 with fips?
(15:34:15) plaisthos: yeah
(15:34:20) plaisthos: + ton of patches for that
(15:34:35) ordex: mah, this will break with openssl-3.0.0
(15:34:41) ordex: so well have to change this code again
(15:34:49) plaisthos: https://git.centos.org/rpms/openssl/blob/c8s/f/SOUR=
CES
(15:34:53) plaisthos: ordex: probably not
(15:35:07) ordex: you mean it won't break ?
(15:35:11) plaisthos: openssl will likely just say "algorithm not found" =
and return null if only the fips provider is loaded
(15:35:17) plaisthos: since it doesn't know about non fips algorithms
(15:35:20) ordex: FIPS_mode is not defined in openssl-3
(15:35:27) ordex: FIPS_mode()
(15:35:34) ordex: doc/man7/migration_guide.pod:561:The function calls FIP=
S_mode() and FIPS_mode_set() have been removed
(15:35:35) dazo: openssl-3.0.0 will most likely be relevant for RHEL-9 ..=
=2E so I wouldn't rush any conclusion in regards to RHEL+FIPS yet
(15:36:25) ordex: so his FIPS_mode() call will only compile on openssl-1.=
0.2 and openssl-1.1.1 on rhel8
(15:36:29) ordex: *this
(15:36:53) ordex: unless we define a compat function, which calls FIPS_mo=
de() only for openssl < 3
(15:37:00) dazo: yeah, that's how I see it
(15:37:07) ordex: while for >=3D 3 it calls something else
(15:37:14) ordex: and then in our code we do openvpn_fips_mode()
(15:37:23) ordex: (where openvpn_fips_mode() is the compat function)
(15:37:43) plaisthos: I think we will not need FIPS_mode in openssl 3
(15:37:53) dazo: I would say we can fix this once openssl-3.0.0 settles a=
nd is available in Linux distros
(15:38:05) plaisthos: since the concept of you get a cipher by name but d=
oesn't work is not really a thing
(15:38:30) ordex: plaisthos: FIPS_mode() won't be needed in openssl-3 and=
 it has been removed indeed :)
(15:38:36) ordex: that is my concern
(15:38:56) ordex: dazo: so you want to keep the patch as it is and deal w=
ith the fallouts of openssl3 later?
(15:40:01) dazo: yeah
(15:40:18) ordex: I am fine with that - I just wanted to point out that t=
his has to change soon - because arne is already playing with openssl-3 :=
)
(15:40:27) ordex: but yeah
(15:40:38) ordex: if we agree this code has to change somewhat soon, then=
 the bandage is good as is
(15:40:49) cron2: there will be extra patches for openssl-3 anyway
(15:40:55) dazo: openssl 3.0.0 isn't going to kick in as an issue right n=
ow .... one step ahead
(15:41:04) ordex: right right
(15:41:26) ordex: can I at least propose a variation of the patch that hi=
des the ifdef in some header instead of having it in the .c file?
(15:41:39) ordex: or you think it's not worth it ?
(15:41:56) cron2: not sure if that is worth it... if at all it makes the =
code flow less clear
(15:42:03) cron2: #ifdef OPENSSL_FIPS
(15:42:06) cron2: is clear enough
(15:42:09) cron2: (I find)
(15:42:35) ordex: sure - I am just allergic to ifdefs :D
(15:42:44) ordex: let's keep it as it is then
(15:43:05) dazo: Yeah, I'm leaning towards the same as cron2 ... and thes=
e two blocks are small.  Had it been lots of code inside, it would trigge=
r my anti-ifdef too
(15:43:08) plaisthos: there is no OPENSSL_FIPS define in OpenSSL 3.0
(15:43:14) cron2: I find "hidden #ifdef" worse, because you try to unders=
tand some parts of the code, only to discover that "ah, this is not relev=
ant at all"
(15:43:28) dazo: yeah
(15:43:29) cron2: but generally, I share the #ifdef dislike
(15:44:04) ordex: plaisthos: yeah, indeed the change to support openssl-3=
 will have to account for that too
(15:44:13) plaisthos: For the dco patch should I try to avoid some of the=
 ifdefs in favour of calling dummy functions istead?
(15:44:20) plaisthos: thinkgs like dco_install_keys etc
(15:44:33) ordex: cron2: I'd say it depends "how they are hidden", but ye=
ah, let's not put more effort on this as the coe is pretty small, like da=
zo said
(15:45:08) ordex: plaisthos: it depends on the code :D
(15:45:09) cron2: plaisthos: dunno, that really "depends"
(15:45:11) cron2: hah :)
(15:45:13) ordex: :p
(15:47:22) ordex: dazo: will you be able to give a shot to this patch on =
your RHEL8 thingo? :)
(15:47:29) dazo: yes, I will
(15:48:10) dazo: well, I will spin up a new rhel-8 box to test with, so I=
 won't mess up things locally with fips restrictions ... but yes, I will =
dive into it
(15:48:19) ordex: okyzz
(15:48:54) ordex: anything else at this point?
(15:48:55) cron2: *like*
(15:49:05) cron2: not from me...
(15:49:10) dazo: me neither
(15:49:24) mattock: nothing from me either
(15:49:42) ordex: <o/
(15:49:56) mattock: is that "I have something teacher!"
(15:50:31) mattock: that is, one hand up, wanting to say something :)
(15:51:48) dazo: mattock: you embarrassed ordex so much now he doesn't wa=
nt to say anything :-P
(15:52:01) cron2: he's italian, he cannot talk without waving his hands
(15:52:31) dazo: :-D
(15:53:36) mattock: I think ordex muted himself
(15:53:38) mattock: :D
(15:53:45) cron2: :-)
(15:53:46) mattock: "your mic is off"
(15:54:02) cron2: anyway - good timing, I need to get a cup of coffee and=
 then videoconf in 7 minutes...
(15:54:07) ordex: lol
(15:54:07) mattock: anyhow, let's conclude this
(15:54:08) dazo: +1
(15:54:17) ordex: I was just enjoying the show
(15:54:19) ordex: :D
(15:54:23) ordex: cheers!
(15:55:36) mattock: bye!
(15:55:56) MaxF: bye!
(15:56:44) rob0: :)

--------------0D4137D3CB75D12D87950F5E--

