From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <de2ff642-df3f-c0a9-c6b0-10584555a4ac@...515...>
Message-ID: <e4a86cc6-1b24-c70d-1020-7e0af3ce1872@...515...>
Date: Wed, 19 Feb 2020 13:28:13 +0200
MIME-Version: 1.0
In-Reply-To: <de2ff642-df3f-c0a9-c6b0-10584555a4ac@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="t0kekqNBGG9awO4pUVy8OXbxIoI4FJ8Y8"
Subject: [Openvpn-devel] Summary of the community meeting (19th Feb 2020)
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
--t0kekqNBGG9awO4pUVy8OXbxIoI4FJ8Y8
Content-Type: multipart/mixed; boundary="Lqknv7mkgAgdhVCEB4BJsHcGA82QCCq0Q"

--Lqknv7mkgAgdhVCEB4BJsHcGA82QCCq0Q
Content-Type: multipart/mixed;
 boundary="------------08F3B75065A1184494363043"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------08F3B75065A1184494363043
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 19th February 2020
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-02-19>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

dazo, lev, mattock, plaisthos and syzzer participated in this meeting.

---

Dazo will try to get the ACKed (2.5) patches applied this week.

--

Syzzer will review the "Warn about insecure ciphers also in
init_key_type" patch from plaisthos.

--

Discussed moving people away from --cipher bf-cbc. One option is to make
--ncp-ciphers and --cipher aes-256-cbc the default via the
openvpn-server@...1685... unit file, but that would break static key
configurations unless we make an expection for them.

--

Agreed that deprecating current static key implementation in OpenVPN 2.5
would be a reasonable thing to do. Later, in 2.6 or later it would
probably be replaced by a new "static key" mode where certificates are
used as static keys. This would allow a high degree of code reuse.

--

Full chatlog attached

--------------08F3B75065A1184494363043
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-02-19.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-02-19.txt"

(12:35:02) lev__: meeting?
(12:35:08) lev__: ping mattock=20
(12:35:43) mattock: hi!
(12:35:44) dazo: w00t! .... Even I managed to appear here in time :-P
(12:36:07) mattock: I almost forgot, but fortunately I received a friendl=
y beep from Pidgin :D
(12:36:17) mattock: thanks to lev!
(12:36:35) lev__: I am the one who beeps
(12:36:35) mattock: so, cron2 probably won't make it today
(12:36:39) mattock: indeed you are
(12:38:34) mattock: so
(12:38:38) syzzer: Short agenda today
(12:38:48) syzzer: morning all :)
(12:39:05) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
0-02-19
(12:39:08) mattock: yes, a short one
(12:39:30) mattock: topic #1: "OpenVPN 2.5. updates/planning"
(12:39:35) mattock: I've seen tons of patches fly by
(12:39:49) mattock: generally that indicates progress :)
(12:40:45) mattock: anyone else besides cron2 who knows what is still mis=
sing?
(12:41:15) dazo: plaisthos: you around?
(12:41:45) dazo: I know plaisthos has been going through the devel-ml and=
 picked up some missing patches as well
(12:42:07) plaisthos: yepp
(12:42:15) dazo: the struct argv patches are all ACKed, iirc
(12:42:38) plaisthos: yeah and I think you also have the rights to commit=
 them right?
(12:43:25) dazo: Yeah, technically I do ... but since it's a long time si=
nce I've done it .... I don't know what else I'll break in the process ..=
=2E. (like an elephant in a glass store)
(12:44:21) plaisthos: Was more thinking to get load off cron2
(12:44:41) dazo: I know ... I can try to take a stab at it this week
(12:44:50) dazo: look at all acked patches and get them applied
(12:45:32) plaisthos: syzzer: to make all the hyper active kids happy, I =
also implemnted chacha poly in openvpn3 ;)
(12:45:49) syzzer: plaisthos: ah, nice!
(12:45:55) mattock: :)
(12:48:47) mattock: so dazo will attempt to get patches applied
(12:48:58) mattock: anything else on 2.5? any blockers?
(12:49:17) plaisthos: there is a still a few of my patches pending iirc
(12:49:32) plaisthos: the async compress, warn if blowfish-cbc is in --ci=
pher
(12:50:14) mattock: pending as in "needs review"?
(12:50:20) plaisthos: yes
(12:50:22) syzzer: I'll check that last one
(12:50:46) plaisthos: [Openvpn-devel] [PATCH] Warn about insecure ciphers=
 also in init_key_type
(12:52:18) plaisthos: but we also need some plan forward to get rid of --=
cipher bf-cbc without forcing everyone to add cipher aes-256-gcm to their=
 configs
(12:54:53) dazo: Since Fedora 27-ish, I applied some --ncp-ciphers and --=
cipher aes-256-cbc (iirc) as the default via the openvpn-server@...1685... =
unit file ... no one has complained about that
(12:55:12) dazo: https://fedoraproject.org/wiki/Changes/New_default_ciphe=
r_in_OpenVPN
(12:55:13) vpnHelper: Title: Changes/New default cipher in OpenVPN - Fedo=
ra Project Wiki (at fedoraproject.org)
(12:55:46) dazo: oh, aes-256-gcm is the "default" with some more ciphers =
in ncp-ciphers
(12:58:56) syzzer: dazo: thanks only works for tls-client / tls-server, n=
ot for static keys
(12:59:10) syzzer: how do you handle configs with --secret ?
(13:00:40) dazo: syzzer: right, you need a tls setup for this to work, in=
deed
(13:02:20) syzzer: but I like this approach, we might just make 2.5 act l=
ike this by default
(13:03:12) syzzer: that will break --secret configs. So we should conside=
r whether we care enough to make en exception for --secret (fallback to B=
F-CBC, or use AES-256-CBC)
(13:03:30) dazo: perhaps it's about time to deprecate static key tunnels?=
  ... or that we "fix" the --secret key approach by deriving a pubkey out=
 of it, and switch to TLS mode regardless?
(13:05:07) syzzer: dazo: I think that last approach is too much magic, an=
d hard to get right in a backwards-compatible way
(13:05:16) dazo: yeah
(13:05:28) dazo: and I do see some pitfalls though .... as you need to au=
thenticate the remote end somehow, as there wouldn't be any CA involved
(13:05:54) syzzer: we might deprecate static keys in 2.5 indeed (though n=
ot *remove* yet)
(13:06:08) dazo: but having a simpler operation mode which replaces the s=
tatic key without needing a full fledged PKI setup would be good
(13:06:39) syzzer: dazo: that would be an ssh-like (or wireguard-like, if=
 you want) mode
(13:06:46) syzzer: where you just provide the pubkey of the other end
(13:06:53) dazo: (and "replaces" as in, not needing to be  compatible wit=
h static key)
(13:07:00) dazo: yeah, exactly
(13:07:21) mattock: mmm, so we'd have an openvpn that is "as easy as wire=
guard"
(13:07:27) syzzer: let's postpone that to after 2.5
(13:07:30) mattock: +1
(13:07:36) dazo: yupp!
(13:07:46) mattock: but deprecating static keys in 2.5 would be acceptabl=
e?
(13:08:06) plaisthos: I think for deprecating them we should have the eas=
y mode
(13:08:14) syzzer: we should really involve cron2 in that discussion
(13:08:14) plaisthos: so we have a good replacement
(13:08:28) mattock: I can mention this on agenda so that cron2 and others=
 can chime in
(13:08:35) syzzer: mattock: +1
(13:08:58) syzzer: plaisthos: has a good point too, but let's discuss thi=
s further when cron2 can chime in :)
(13:09:24) dazo: I think deprecating static mode is reasonable ... it is =
non-PFS capable, with devastating results if the shared key gets leaked .=
=2E. meaning: capture the traffic and save it until you get a copy of the=
 shared private key and you have the keys to the kingdom
(13:09:27) plaisthos: even if the easy mode is just openvpn generates a s=
elf-signed cert and you put the public key of the other side in openvpn2 =
client/server config to make it very easy from implementation perspective=

(13:10:38) syzzer: plaisthos: interesting thought, that might actually al=
ready work right now
(13:10:55) syzzer: just add the self-signed certificate from you peer as =
a CA
(13:11:47) dazo: plaisthos: but it would be smoother from a user's perspe=
ctive just include the remote end's finger print instead of a full certif=
icate in the config
(13:12:07) dazo: (similar to what --verify-x509 does today)
(13:12:50) syzzer: plaisthos: my review should be on the list
(13:13:05) plaisthos: syzzer: yeah. In the end users do not really care h=
ow it works on the hood as long as it is very easy to use
(13:13:31) plaisthos: will do a rebased version real quick
(13:14:19) plaisthos: but having this "use certificates as static keys" u=
nder the hood would avoid implementing some other static key mode
(13:17:40) dazo: agreed, reusing as much as possible would be ideal
(13:19:03) syzzer: I guess that was it for today?
(13:21:50) dazo: seems so :)
(13:22:52) mattock: yes
(13:22:56) mattock: I'm busy writing the summary

--------------08F3B75065A1184494363043--

--Lqknv7mkgAgdhVCEB4BJsHcGA82QCCq0Q--

--t0kekqNBGG9awO4pUVy8OXbxIoI4FJ8Y8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl5NG80ACgkQKVhNn0CG
RXjNIggAo4UjlN0i7/3aKf+HyqJ1IZAHsXRv25JTfc3E8vC4He+SzYcm25RaNEQs
WXNlkhI3lzmJ5LsA/bS4uXjLkkwVrnhj7eKhijv8hmZSkeDGi7zoe9zBeaEwjZY0
KkHXHMUnzQFBolpnCA3Id664ulI7jnfO84I87VIub68T+Wcb1ynKsZJgS5dq+1Uu
0ZKtlsmbfXE6rcs/0eXaqvp7K9ek/G946WrlYlgd1QQ7c7/HtqZ9OxsqGdkE83JA
MhD7TqdkepmNUyUeyo/Y+/ohyMlH3vyKfItRxiYBw2U9Wl9CHC6W1WGOplDn0wVn
WcCA0A/PauXZT+wjtDmajvJMt4HL2w==
=2bHf
-----END PGP SIGNATURE-----

--t0kekqNBGG9awO4pUVy8OXbxIoI4FJ8Y8--

