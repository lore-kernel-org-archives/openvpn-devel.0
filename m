From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <4bf0a788-1a6a-34a8-7ecf-587d23c3eb6b@...515...>
Message-ID: <9e3b8aac-a1df-f4c5-0de1-e3e20b1b5deb@...515...>
Date: Wed, 28 Oct 2020 14:48:11 +0200
MIME-Version: 1.0
In-Reply-To: <4bf0a788-1a6a-34a8-7ecf-587d23c3eb6b@...515...>
Content-Type: multipart/mixed; boundary="------------57427AFDAAA60647127986C8"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (28th October 2020)
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
--------------57427AFDAAA60647127986C8
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 28th October 2020
Time: 11:30 CEST (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-10-28>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock, plaisthos and syzzer participated in this 
meeting.

---

Crafted the release announcement for OpenVPN 2.5.0.

-- 

Full chatlog attached

--------------57427AFDAAA60647127986C8
Content-Type: text/plain; charset="utf-8"; name="openvpn_irc_meeting_chatlog_2020-10-28.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-10-28.txt"

(12:29:46) dazo: hey!
(12:30:14) mattock: hello, release meeting
(12:30:24) dazo: mattock: so ... have you pushed?
(12:30:25) mattock: dazo: the release files are on swupdate
(12:30:32) cron2: ho
(12:30:34) mattock: depends on what "push" means
(12:30:40) cron2: working on the release announcement text
(12:30:41) dazo: yes, to s3
(12:30:43) mattock: yes
(12:30:46) cron2: https://etherpad.mit.edu/p/sjdhfksdhk
(12:30:47) vpnHelper: Title: Etherpad@...2583... (at etherpad.mit.edu)
(12:33:23) dazo: Hmm ... we might have been just to late to put 2.5 into the main Fedora 33 repositories; it got released yesterday :/
(12:33:50) dazo: Fedora 34 will be the first shipping it in distro packages .... but I'll add Copr repos for the other
(12:34:01) ***dazo need to create a new Copr repo for releases
(12:34:57) mattock: +1
(12:35:09) cron2: dazo: argh, how annoying... Monday would have been easily doable if we had known
(12:35:26) dazo: yeah, well, Fedora releases arrives every 6 months
(12:35:31) ***plaisthos is here 
(12:35:37) mattock: hi
(12:35:41) plaisthos: BUt I will leave in about 20 minutes for lunch
(12:35:55) mattock: I mean, we could have _tagged_ the release a few days ago easily
(12:36:30) cron2: plaisthos: can you have a look at the etherpad and see if that makes sense?
(12:36:58) dazo: well, there's no point at grieving over the past now
(12:39:30) mattock: dazo: +1 :)
(12:39:57) dazo: mattock: https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-release/   <<<< this is where I will put the packages; preparing for the builds now
(12:39:58) vpnHelper: Title: dsommers/openvpn-release Copr (at copr.fedorainfracloud.org)
(12:40:13) mattock: +1 again
(12:40:42) mattock: so does the release announcement look good to all?
(12:40:49) lev__: mattock: will you remove 2.5beta1 -> 2.5rc3 from https://openvpn.net/community-downloads/ ?
(12:40:50) vpnHelper: Title: Community Downloads | OpenVPN (at openvpn.net)
(12:41:32) mattock: lev: yes, I shall now
(12:43:59) cron2: mattock: we do seem to have MSI twice in the new feature list "we support building it, and we have it"
(12:44:16) mattock: yep, let's get rid of one
(12:44:53) plaisthos: cron2: I edited the etherpad
(12:45:05) plaisthos: and added the note that PIA always generated warning in the logs
(12:45:10) plaisthos: so it is not really a new problem
(12:45:55) cron2: yeah
(12:50:45) syzzer: hi :)
(12:50:47) mattock: nothing is happening the the pad
(12:50:52) cron2: wohoo
(12:50:54) mattock: is the announcement good now?
(12:50:56) mattock: hi syzzer!
(12:50:58) cron2: I just added something :-)
(12:51:01) plaisthos: the FAQ text in my app is less nice:
(12:51:03) plaisthos: Last but not least, there is a popular VPN provider that has a broken server that always says it is using \'BF-CBC\' because its developer thought it would be a good idea to create a proprietary cipher negotiation patch that is incompatible with standard OpenVPN.
(12:51:32) cron2: I am good with the announcement, but maybe it would be good to have syzzer have look, with fresh eyes
(12:52:52) dazo: cron2: VLAN support .... I'm fuzzy on the details, is that for TAP only, or also TUN?
(12:53:08) cron2: tap only
(12:53:55) plaisthos: need to go for lunch now, sorry :(
(12:54:59) syzzer: "Debian and Ubuntu packages are available in the official apt repositories." sounds like the debian and ubuntu repos, but you mean the openvpn apt repos right/
(12:55:25) dazo: "    but if you need to keep a 2.3 (or even older) OpenVPN around, and need to stay on BF-CBC, the 2.5 end of that session needs a config file change to add the formerly-default cipher"  <<< this sounds odd
(12:55:40) dazo: syzzer: yeah, that apt repo sentence needs to be clarified
(12:56:58) mattock: please note that copying the text broke the links
(12:57:01) mattock: that's why it is confusing
(12:57:07) mattock: but we can also reword it a bit
(12:57:11) mattock: that is, I can
(12:57:41) mattock: done and somebody else was there before me :)
(13:00:06) mattock: pippin on #openvpn-devel suggests adding a link to the easy-rsa 3 howto (https://community.openvpn.net/openvpn/wiki/EasyRSA3-OpenVPN-Howto)
(13:00:08) cron2: aynthing else on the announcement text?
(13:00:13) mattock: ^^^
(13:00:16) mattock: I would not mind
(13:00:20) dazo: do we require FreeNode registration to access #openvpn these days?
(13:00:20) mattock: it's new to most
(13:00:32) mattock: not sure as I'm always logged in anyways
(13:01:09) syzzer: "unless BF-CBC is included in --data-ciphers or there is a "--cipher BF-CBC" in the 2.5 config" <- should this not mention something about --data-cipher-fallback /
(13:01:33) Pippin_ [Pippin_@...2315.../vpn/protonvpn/pippin/x-75792076] è entrato nella stanza.
(13:02:21) syzzer: "a 2.3 server or a 2.3 client are not capable to negotiate something better" <- what about poor-mans NCP? Changing the 2.3 config to include "AES-something" should work too, right/
(13:03:11) cron2: yeah, but that still means "unless you touch the config on one side, it's broken"
(13:03:34) cron2: and if you have a 2.3 server with 2.3/2.4/2.5 clients *and* BF-CBC, your 2.5 clients are broken
(13:03:43) cron2: (and "default BF-CBC")
(13:03:53) cron2: valdikss ran into this
(13:04:41) syzzer: interesting
(13:06:51) syzzer: plaisthos probably needs to take a final look at the whole cipher section, to be sure it still represents the truth
(13:06:52) dazo: plaisthos: Which openssl release is needed for CHACHA-POLY1305 support?  1.1.1?
(13:07:26) ***dazo sees that syzzer tries to shift the crypto expertise label over to plaisthos :-P
(13:07:40) mattock: :P
(13:07:51) lev__: msi installers still mentioned twice in etherpad
(13:08:12) dazo: lev__: not any more :-P
(13:08:40) cron2: syzzer: I think it's ok
(13:09:13) lev__: "Improved Windows 10 detection" not sure it _that_ important to deserve mentioning in release announcement
(13:09:53) mattock: I'm not sure what that even means
(13:10:26) mattock: I'll start updating the download page now
(13:15:27) mattock: ready except for the release announcement
(13:21:17) mattock: people still editing the announcement?
(13:25:45) L'account è disconnesso e non sei più in questa chat. Sarai reinserito in questa chat alla riconnessione dell'account.
(13:27:04) L'argomento di #openvpn-meeting è: Agenda at https://community.openvpn.net/openvpn/wiki/Topics-2020-10-22
(13:27:04) L'argomento per #openvpn-meeting è stato impostato da dazo a 21:16:51 su 22/10/2020
(13:27:04) ***: Buffer Playback...
(13:27:04) syzzer: TLS 1.3 support isn't a new feature, right?
(13:27:04) syzzer: I think it's a lot more complete now
(13:27:04) dazo: syzzer: ahh, then I will re-add "Improved"
(13:27:04) cron2: too late
(13:27:04) cron2: :)
(13:27:04) dazo: hehe
(13:27:04) dazo: I think this begins to look reasonable ... not sure if we've forgotten anything .... going back to complete the Copr repos now
(13:27:04) syzzer: This is looking pretty good!
(13:27:04) ordex: nice!
(13:27:04) cron2: +1
(13:27:04) syzzer: I need to get lunch some lunch now though, before my next meeting starts. TTYL!
(13:27:04) ordex: btw we have some "v2." and sometimes just "2."
(13:27:04) ordex: which one do we prefer ?
(13:27:04) ordex: bye syzzer !
(13:27:04) cron2: I have no strong preference but it should be consistent
(13:27:04) ordex: agreed
(13:27:04) dazo: ordex: we agreed long ago that it is "OpenVPN X.Y" or "vX.Y"
(13:27:04) ordex: o.o
(13:27:04) ordex: well...if it was agreed
(13:27:04) ordex: ok
(13:27:04) dazo: there's a commit long down in the git history where we changed this everywhere
(13:27:04) ordex: even though I find it weird :D
(13:27:04) cron2: I can't remember, but that's my old age showing
(13:27:04) ordex: especially this: OpenVPN 2.3/2.4 and v2.5
(13:27:04) ordex: cron2: :p
(13:27:04) dazo: We had all kinds of variations in docs and code .... OpenVPN X.Y, OpenVPN vX.Y, X.Y and vX.Y .... so it was agreed on "OpenVPN X.Y[.Z]" (as version reference is implied) and "vX.Y[.Z]" to indicate a version vs a floating number
(13:27:04) cron2: anyway, I'm good with what we have now, and need to find food for $wife now, otherwise, bad things will happen
(13:27:04) ordex: :D
(13:27:04) ordex: very baaad!
(13:27:04) dazo: If needing version references more times in the same sentence, it was preferred to use first "OpenVPN X.Y[.Z]" and just "vX.Y[.Z]" in the following references, as it implies a OpenVPN version
(13:27:04) ordex: [/me is moving too]
(13:27:04) ***: Playback Complete.
(13:28:32) mattock: it seems I got silently disconnected but good that everyone is happy with the announcement!
(13:28:37) mattock: I can finish the download page now

--------------57427AFDAAA60647127986C8--

