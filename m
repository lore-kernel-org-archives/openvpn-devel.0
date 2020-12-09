From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <9cbe2737-df06-c921-1052-3dabe3fb4141@...515...>
Message-ID: <f0acf9e2-f43d-427b-a099-ab4cd28d71ef@...515...>
Date: Wed, 9 Dec 2020 19:48:00 +0200
MIME-Version: 1.0
In-Reply-To: <9cbe2737-df06-c921-1052-3dabe3fb4141@...515...>
Content-Type: multipart/mixed; boundary="------------42114475FC4393349E10F088"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (9th December 2020)
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
--------------42114475FC4393349E10F088
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 9th December 2020
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-12-09>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, ordex and plaisthos participated in
this meeting.

---

Noted that plaisthos has implemented AES-CCM.

---

Cron2 had tagged 2.4.10 before the meeting. It was released later the
same day.

---

Discussed the data-channel offload module (DCO) in context of OpenVPN
2.5. The current ovpn-dco only works with p2p but the current p2p model
is not easily extendable to p2mp. Therefore plaisthos and ordex agreed
that they will switch to a newer model in ovpn-dco that will also
support p2mp befor they continue with DCO and 2.5.

---

Discussed the OpenSSL bug fixed in OpenSSL 1.1.1i (CVE-2020-1971):

<https://www.openssl.org/news/vulnerabilities-1.1.1.html>

There seemed to be agreement that this does not really affect OpenVPN.
Basically somebody would have to be able to place a messed-up CRL on
your OpenVPN server, in which case you have bigger problems than a
vulnerable OpenSSL version. OpenVPN also does not download CRLs
dynamically, which reduces the impact.

Moreover, this problem is only a problem with OpenVPN running as server
on Windows. It is also possible, even if not very convenient, to replace
the OpenSSL library inside the OpenVPN installation directory
(C:\Program Files\OpenVPN) to patch this vulnerability.

Due to above the consensus (for the most part) was that we can wait
until 2.5.1 that is due in a few weeks before fixing this. If needed, we
can backpedal and do a separate OpenVPN 2.5.0 Windows installer release
before 2.5.1.

OpenVPN 2.4.10 has now been released - it has the fixed OpenSSL version
(1.1.1i).

---

Full chatlog attached


--------------42114475FC4393349E10F088
Content-Type: text/plain; charset="utf-8"; name="openvpn_irc_meeting_chatlog_2020-12-09.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-12-09.txt"

(12:28:52) ordex: hi
(12:31:35) plaisthos: moin
(12:32:59) dazo: Hey!
(12:33:29) cron2: I am sort of here
(12:33:38) cron2: have the window open but focus is elsewhere sorry
(12:33:50) dazo: "sort of" is still better than not at all :)
(12:36:03) cron2: seems mattock got lost in the 2.4.10 windows build fight
(12:36:12) dazo: yeah ...
(12:36:17) dazo ha scelto come argomento: https://community.openvpn.net/openvpn/wiki/Topics-2020-12-09
(12:42:28) cron2: internal chat?
(12:42:39) dazo: trying
(12:43:51) plaisthos: So I implemented AES-CCM :P
(12:46:44) cron2: that sounds like a 2.6 update :-)
(12:46:50) cron2: any news on dco? 2.5?
(12:47:02) plaisthos: But on a more serious note, I am considerinng introducing XOR-ing our packet id with a shared secret
(12:47:13) cron2: on the 2.4 front - I have tagged and pushed 2.4.10 this morning, and mattock is working on release building
(12:47:48) plaisthos: so an observer doesn't know how many packets have already been sent by looking a single packet
(12:48:23) plaisthos: and also avoids a purely theoretical precomputation attack ;)
(12:49:31) dazo: cron2: nice!  I'll kick off the Fedora/EPEL builds once the tarball + sigs are in place
(12:49:51) plaisthos: I think I will look into the client with --bind bug next
(12:50:34) dazo: what's that bug?
(12:51:56) dazo: cron2: DCO ... I'm about to push out an updated openvpn3-linux client ... with TCP and IPv6 transport support implemented, just waiting for some regression testing to complete ... ordex might have more details on what else on his roadmap now :)
(12:52:20) plaisthos: new client connection reuses old context on the server and since we don't run the new connect logic we don't generate a key since the ncp code assumes that key_id==0 is always a new session
(12:52:32) dazo: ahh
(12:52:53) mattock: damn
(12:52:59) mattock: meeting slipped my mind completely
(12:53:20) ordex: *boom*
(12:53:27) mattock: anyhow, I will start the release machinery now, a surprise lunch interrupted that one
(12:54:07) ordex: not a bad surprise
(12:54:31) cron2: plaisthos: sounds good
(12:55:11) plaisthos: For DCO and 2.5, the current ovpn-dco only works with p2p but the current p2p model is not easily extendable to p2mp
(12:55:50) plaisthos: So ordex and I agree that we switch to a newer model in ovpn-dco that will also support p2mp beforr I continue with dco and 2.5
(12:56:02) ordex: things are undergoing big changes on the kernel side, to accommodate p2mp
(12:56:07) ordex: yap
(12:56:11) ordex: that's where I Am right now
(12:56:20) ordex: (which also simplifies the code, in a sense)
(12:56:29) cron2: good to know
(12:56:46) cron2: plaisthos: have you shared your repo with bz?
(12:56:53) cron2: (the RFC repo)
(12:57:07) plaisthos: I sent an invite
(12:58:29) plaisthos: https://bfy.tw/Psjf
(12:58:30) vpnHelper: Title: LMGTFY (at bfy.tw)
(12:58:33) plaisthos: https://bfy.tw/Psjf
(12:58:35) plaisthos: https://bfy.tw/Psjf
(12:58:37) plaisthos: https://bfy.tw/Psjf
(12:59:06) plaisthos: argh
(12:59:28) cron2: plaisthos: thanks.  Haven't heard anything, just wanted to be sure its not stuck on our side
(12:59:31) plaisthos: right mouse click windows terminal and nonsense in cliboard
(12:59:43) ordex: :D
(12:59:58) ordex: that was not nonsense
(13:00:07) dazo: :D
(13:04:00) dazo: so ... that's all for 2.5/2.6 updates?
(13:04:05) cron2: a bit nonsense-ish it was :)
(13:04:30) cron2: well, there is this openssl bug and "does it affect us, do we need a 2.5 (re-)release"?
(13:05:12) dazo: ahh, right!
(13:12:12) cron2: anyone? plaisthos?
(13:15:01) dazo: https://www.openssl.org/news/vulnerabilities-1.1.1.html ... so the 1.1.1i release yesterday seems at first glance to be critical for us
(13:15:01) vpnHelper: Title: /news/vulnerabilities-1.1.1.html (at www.openssl.org)
(13:15:38) plaisthos: it is one of these. I not sure what exactly needs to be done to crash issues
(13:15:59) becm [~becm@...2589...] è entrato nella stanza.
(13:16:18) plaisthos: probably not an issue in most setups but I am not understanding the issue well enough to say "we don't that openssl version"
(13:16:38) ordex: hm it seems the attacker also needs to control the CRL format
(13:16:49) ordex: so for locally generated CRLs this is not a very big deal
(13:16:55) ordex: IIUC
(13:18:42) cron2: that was my assessment of the writeup - "if someone can put a messed-up CRL on your openvpn server and have openvpn read it, your old openssl might not be your biggest problem"
(13:19:08) cron2: so - no 2.5.0 re-release?  and 2.5.1 "in a few weeks"?
(13:21:23) plaisthos: since CRLs are not really usable that well in openvpn (you need to fetch them) manually, we are not really affected by this bug
(13:21:26) plaisthos: ;P
(13:21:58) dazo: I would say we should probably kick off a 2.5.0 update for Windows with a new OpenSSL .... " Note that an unrelated bug means that affected versions of OpenSSL cannot parse or construct correct encodings of EDIPARTYNAME. However it is possible to construct a malformed EDIPARTYNAME that OpenSSL's parser will accept and hence trigger this attack." ... since OpenVPN often uses client cert based auth, we cannot trust the clients.
(13:21:58) dazo: There might be a possibility that clients may send a malicious cert which might be able to abuse this to gain access
(13:22:04) mattock: I would say "2.5.1 in a few weeks"
(13:22:12) mattock: if possible, at least
(13:22:27) mattock: people will ask about this, so better have an explanation ready
(13:23:31) dazo: Which is why I'm voting for a re-spin of 2.5.0 on Windows with the latest OpenSSL update ... "We're not 100% convinced OpenVPN is affected by this bug, but we don't want to take any risks"
(13:24:30) dazo: I agree that most OpenVPN setups are most likely not affected, but the details and scope isn't that clear in the description
(13:25:01) ordex: that sentence about the unrelated bug is quite cryptic
(13:25:02) ordex: to me
(13:27:20) dazo: yes, and that's what makes me concerned
(13:29:45) ordex: by re-reading the upper part, I think this is simpl saying: openssl affected by this bug cannot really construct a working EDIPARTYNAME value, but if you try hard enough you can still do that and trigger the crash
(13:29:47) dazo: I know the windows building can be a hassle and that it's easy for me to say "re-spin" not being involved in the build process ... but I don't want to compromise the security for an unclear issue.  This was important enough for OpenSSL to do a pre-announcement without any details last week
(13:30:00) ordex: but still under the assumption that you have provided both CRL *and* certificate to check
(13:30:54) ordex: so if the CRL is not malformed, there is nothing to crash in any case
(13:31:18) dazo: Unless the attacker manages to inject a malicious CRL
(13:31:40) ordex: right
(13:32:06) ordex: in the openvpn case, that means full access to the file system where the CRL is stored
(13:32:32) dazo: Yeah, we don't do CRL downloads on-the-fly, so that's "good"
(13:32:34) ordex: I can see that other apps may download the CRL from the web, so they don't know what they are using. but for openvpn I don't think that case exists
(13:32:39) ordex: right
(13:32:57) ordex: so imho this can wait for 2.5.1
(13:33:33) ordex: (and the problematic platform is OpenVPN ran as server on windows)
(13:33:41) ordex: conclusion? :D
(13:33:49) ordex: anybody in favour or re-doing 2.5.0 now?
(13:34:21) mattock: not me, because I would take the hit :D
(13:34:24) ordex: :D
(13:34:26) cron2: I do not read this as critical, but I'm not the one having to do the work either
(13:34:29) dazo: I'm still thinking "better safe than sorry"
(13:34:35) mattock: installers are easier than full release, but still an effort 
(13:35:11) mattock: I could do 2.5.0 windows installer release later this week, if needed
(13:35:13) ordex: can't people update openssl on their own ?
(13:35:18) ordex: (on windows)
(13:35:23) mattock: they could, yes
(13:35:25) ordex: or will openvpn always use the bundled one?
(13:35:36) dazo: mattock: I'm considering to request Andrew to release you from all your work except improving and fully automating Windows builds
(13:35:47) mattock: I suppose you could put openssl you've obtained from openssl.org to openvpn directory
(13:35:55) mattock: dazo: that request will fail miserably
(13:36:00) mattock: that much I can tell :)
(13:36:03) ordex: ah ok - not super easy though
(13:36:09) ordex: anyway I have to run for lunch
(13:36:27) ordex: I'd sitck to "not upgrade now", but I leave to you the final decision
(13:36:30) dazo: mattock: I can be persistent in my requests if I want to :-P
(13:36:32) ordex: *stick
(13:36:46) mattock: dazo: you know how well cron2's IPv6 + community crusade has progressed, right?
(13:36:48) mattock: :P
(13:37:32) mattock: that said, it would be nice to get some help with automating openvpn 2.x releases and all that
(13:37:43) cron2: dazo: can I use that for my ipv6 crusade? :-)
(13:37:50) mattock: requesting that from andrew could be more beneficial than trying to detach me from ops work
(13:38:36) mattock: there are simply too many junior guys in the ops team, so a large part of the harder stuff lands on my plate anyways
(13:39:38) cron2: I need to leave now, sorry.  I'll read the backlog, or bring up the other topics again later
(13:39:39) dazo: cron2: Core team has geared up the IPv6 attention and making more noise as well ... so the attention is increasing steadily
(13:39:46) cron2: \o/
(13:39:52) cron2: ok *wave*
(13:39:59) mattock: ok, let's end this thing

--------------42114475FC4393349E10F088--

