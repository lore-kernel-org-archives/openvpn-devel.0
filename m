From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <6a623f26-a30c-eb91-204b-8f938cad2994@...515...>
Message-ID: <d63b9729-a866-bb3b-43df-eba72a3d8660@...515...>
Date: Thu, 9 Apr 2020 21:50:29 +0300
MIME-Version: 1.0
In-Reply-To: <6a623f26-a30c-eb91-204b-8f938cad2994@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ch8MmOaCH4u4Q1eF11jYQfzMCcdE30WYj"
Subject: [Openvpn-devel] Summary of the community meeting (9th April 2020)
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
--Ch8MmOaCH4u4Q1eF11jYQfzMCcdE30WYj
Content-Type: multipart/mixed; boundary="d8rDuBIsyJHbgRknIfCeDgUPTqaXImraF"

--d8rDuBIsyJHbgRknIfCeDgUPTqaXImraF
Content-Type: multipart/mixed;
 boundary="------------E418FAE02615BE2D6DED576C"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------E418FAE02615BE2D6DED576C
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 9th April 2020
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-04-09>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

krzee, lev and mattock participated in this meeting.

---

Talked about having mod_cloudflare installed on Trac and Phpbb. This
would affect logging and not do any man in the middle stuff:

<https://support.cloudflare.com/hc/en-us/articles/200170916-Restoring-origi=
nal-visitor-IPs-Option-1-Installing-mod-cloudflare>

Nobody was opposed to this, but many key people were missing so no
decision could be reached.

---

Talked about OpenVPN 2.5 MSI work. The OpenVPN patches are now all in,
so it is possible to (more easily) move to testing the MSI packaging,
see bottom of this page:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25>

The last time mattock touched MSI he created a vagrantied build
environment/process

<https://github.com/OpenVPN/openvpn-vagrant/pull/7>

It has not been touched in a while so testing is needed to see if it
still works.

Mattock and lev will have a session next week about Vagrant and this
environment in particular, so that lev can also participate in the MSI work.

---

Discussed the option of having OpenVPN 2.5 packages in the same apt
repository as OpenVPN 3 packages. Nobody was against this.

--

Talked about "python3-openvpn-connector-setup". It was originally
designed for an OpenVPN Inc product, but it is fairly general purpose
tool which other projects and people could use.

What it does is for setup a connector - essentially an OpenVPN 3 client
- which could be a VPN traffic exit node or, for example, used for
sharing an AWS VPC. It was agreed that it makes sense to have such code
open source. This is the case today, but the code has not been
officially released except in the form of an Debian package as far as we
know.

Dazo could fill in the blanks here, including giving URLs to any Git
repositories there might be.

--

Full chatlog attached


--------------E418FAE02615BE2D6DED576C
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-04-09.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-04-09.txt"

(20:56:37) mattock: almost meeting time
(20:56:49) krzee: \o/
(20:59:41) lev__: guten aben
(21:00:44) mattock: guten abend herr lev
(21:01:23) lev__: gutt gutt
(21:01:50) krzee: hyavaa illta
(21:02:02) mattock: hyv=C3=A4=C3=A4 iltaa!
(21:02:15) mattock: I guess we can have this meeting in Finnish
(21:02:21) krzee: :D
(21:02:32) lev__: joo, anna menn=C3=A4 vaan
(21:02:33) mattock: krzee knows several words
(21:02:36) mattock: tehd=C3=A4=C3=A4n niin
(21:02:42) krzee: perkele!
(21:02:48) mattock: aamen!
(21:03:10) mattock: poronkusema is another one he knows
(21:03:14) mattock: very useful
(21:03:24) krzee: that is the best word ever btw
(21:03:56) mattock: btw. "best" is probably the only word in english that=
 is pronounced as it is written
(21:04:05) mattock: just occurred to me
(21:04:24) mattock: well, "is" is another :D
(21:04:33) krzee: and "well"
(21:04:40) mattock: +1
(21:05:14) mattock: seriously - do we have any other participants?
(21:05:15) krzee: english will throw a few softballs and then come with t=
he "tough" curveball out of nowhere
(21:06:11) mattock: inglish will throu a fjuu softbools =C3=A4nd then kam=
 with t=C3=B6 "taf" k=C3=B6=C3=B6rvbool aut of noveer?
(21:06:44) krzee: "tuf"
(21:06:50) krzee: haha
(21:07:16) mattock: ok maybe we can try to have a meeting of sorts
(21:07:21) mattock: if somebody joins that's good
(21:07:24) mattock: so I have one topic
(21:08:04) mattock: we (the ops team at openvpn) would like to install mo=
d_cloudflare on Trac and forums - that would allow blocking DDoS attacks =
more effectively
(21:08:24) mattock: all it does it affect the logging format - there is n=
o MITM stuff going on there
(21:08:43) krzee: prolly no fair if the only people here to talk about it=
 is you me and lev :D
(21:08:58) mattock: well it will end up in meeting minutes so people can =
complain
(21:09:00) mattock: :)
(21:09:11) krzee: nice
(21:09:24) mattock: lev: anything on 2.5?
(21:12:24) mattock: I don't have any updates on my part there
(21:12:30) lev__: well, msi-installer related code has been merged to ope=
nvpn repo
(21:12:36) mattock: good!
(21:12:47) mattock: I will need to find time to start the MSI build tests=
 again
(21:13:03) lev__: so we could srart testing openvpn-build msi branch
(21:13:10) mattock: yeah, we should definitely do that
(21:13:22) mattock: I have a Vagrant VM in a feature branch of openvpn-va=
grant which can be used
(21:13:28) mattock: getting link
(21:14:06) mattock: https://community.openvpn.net/openvpn/wiki/StatusOfOp=
envpn25
(21:14:09) mattock: at the bottom
(21:14:18) mattock: https://github.com/OpenVPN/openvpn-vagrant/pull/7
(21:14:19) vpnHelper: Title: Add MSI build support by mattock =C2=B7 Pull=
 Request #7 =C2=B7 OpenVPN/openvpn-vagrant =C2=B7 GitHub (at github.com)
(21:14:29) mattock: that's what I used the "last time" for testing MSI bu=
ilding
(21:15:30) mattock: basically when one runs "vagrant up msibuilder" the r=
esult should be a fully configured MSI builder Windows instance
(21:15:49) mattock: untested in recent months, so it might not work
(21:16:53) mattock: the build process requires two steps:
(21:16:53) mattock: - build with openvpn-build (VM: openvpn-build-bionic)=

(21:16:53) mattock: - package to MSI (VM: msibuilder)
(21:17:08) mattock: need to pick that up again
(21:17:22) mattock: lev: if you want to play with MSI as well just let me=
 know and I'll help
(21:20:48) lev__: do we have a build system which produces those MSI pack=
ages
(21:21:00) mattock: only in Vagrant, see my comments above
(21:21:06) mattock: do you use Vagrant?
(21:21:14) lev__: hm, no (not yet)
(21:21:31) mattock: want to try? we could have a session some of these da=
ys
(21:21:43) mattock: I use it heavily
(21:21:48) mattock: very useful
(21:21:59) mattock: thoughts?
(21:22:24) lev__: yeah that makes sense
(21:22:32) mattock: any preferences when?
(21:22:41) lev__: not today :)
(21:22:55) mattock: I could do tomorrow morning for example, but I'm not =
in a hurry
(21:23:40) lev__: I have some (more or less) urgent corp stuff for tomorr=
ow, so lets move it to next week
(21:24:14) mattock: ok sounds good
(21:24:57) mattock: generally I'm able to work between 9:00-12:30 EEST on=
 weekdays, then it becomes more sporadic for the rest of the day (child r=
unning around the house)
(21:25:45) mattock: krzee: one thing that came to mind: the apt repositor=
ies we discussed in the ops meeting - I did not manage to speak up, but s=
hould consider consolidating both openvpn 2.5 and openvpn 3 packages in t=
he same repo
(21:25:49) mattock: in my opinion
(21:25:58) mattock: thoughts?
(21:26:17) krzee: im not against that, what do you think about python3-op=
envpn-connector-setup
(21:26:38) mattock: I don't understand what it is, so I have no opinion :=
D
(21:27:16) krzee: its a pgmt usecase where the user wants to setup a conn=
ector which could be an exit node or maybe a client for sharing the VPC
(21:27:25) krzee: it'll setup the node all the way
(21:27:43) krzee: i think give it some token from your pgmt stuff and it'=
ll even configure the vpn for you
(21:28:10) mattock: as this is not really community-related I'd discuss t=
he details elsewhere :)
(21:28:11) krzee: it'll be USED by pgmt users, but itself its open source=
 and could contain code that other projects may want to use
(21:28:15) mattock: ah
(21:28:17) mattock: I see the connection
(21:28:51) mattock: well, if it is reusable then I don't see a reason why=
 we should keep it private
(21:29:18) mattock: does it contain open source code from somewhere else?=

(21:29:23) krzee: which is why its now on a community repo, (swupdate)
(21:29:23) krzee: or well im getting it there
(21:29:23) krzee: (dazo said to put it there)
(21:29:23) krzee: also, it depends on openvpn3
(21:29:28) krzee: i would not know
(21:29:30) mattock: like GPLv2 licensed stuff that "makes" it automatical=
ly open source
(21:29:39) krzee: oh ya its gpl for sure
(21:29:43) krzee: dazo said that
(21:29:53) krzee: but i dont think its because of deps
(21:30:05) mattock: I'm all for open sourcing everything that does not ne=
ed to be proprietary
(21:30:13) krzee: itself its nothing proprietary
(21:30:20) mattock: ok
(21:30:21) krzee: the mesh it helps you use it where our value is
(21:30:34) krzee: is where*
(21:31:01) krzee: (this is what ive been told, and i tend to agree)
(21:31:11) mattock: so basically it is a tool for setting up certain type=
s of openvpn 3 clients, right?
(21:31:20) mattock: for specific use-cases
(21:31:28) krzee: i believe it even sets up the aws node
(21:31:32) krzee: configures it
(21:31:35) mattock: ah ok
(21:31:36) krzee: sets up the vpn
(21:31:40) krzee: vonfigures VPC
(21:31:43) krzee: configures*
(21:32:07) mattock: ok
(21:32:25) mattock: is the code "out there" already?
(21:32:34) krzee: this is first release
(21:32:40) mattock: no public git repos?
(21:32:45) krzee: swupdate
(21:32:50) krzee: oh git, not that i know of
(21:32:53) mattock: ok
(21:32:54) krzee: but i wouldnt know
(21:32:57) krzee: dazo may have one
(21:33:42) mattock: ok, I'm onboard
(21:33:44) krzee: all i *really* know about this is im putting it in a re=
po, the stuff ive answered with i probably know the least about out of an=
ybody who could possibly answer :D
(21:33:56) mattock: :)
(21:34:08) krzee: but i think ive answered correct
(21:34:32) mattock: your explanation does sound plausible
(21:34:47) mattock: I'll note this in the meeting minutes so dazo can giv=
e the most correct answer
(21:35:05) mattock: I don't have anything else for today - anything from =
you guys?
(21:35:13) mattock: or shall we call this a day?
(21:35:23) mattock: or for those not in EEST timezone, call it a meeting
(21:35:25) mattock: :)
(21:35:47) krzee: haha ya ill call it a midday
(21:36:23) krzee: back to "why the F doesnt apt see this package when cur=
l shows its in packages and the file from packages exists too
(21:36:26) krzee: haha
(21:36:32) krzee: g'nite guys
(21:38:07) mattock: good midday and night!
(21:38:12) mattock: talk to both of you later!
(21:40:33) wiscii [~tct@...1336.../slypknot] =C3=A8 entrato nella stanz=
a.
(21:41:31) ***wiscii is too late
(21:46:23) mattock: yup, summary is almost out

--------------E418FAE02615BE2D6DED576C--

--d8rDuBIsyJHbgRknIfCeDgUPTqaXImraF--

--Ch8MmOaCH4u4Q1eF11jYQfzMCcdE30WYj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl6PbnYACgkQKVhNn0CG
RXhPLQgAxSMKK6GIbplQzFoKwj1h9nACXdzeUjuRuuqjo8Kc9Xw3sBOAXTww+I/s
shvay1HZ0UdJd3vFMorIspAPWhgZFwfKyHhepUF7d/qbyYrUfkwMY4KOtqteS8ib
kYsak/7IXeSA/TfbmJE32uFRJrG3QEaMiBVUHT/xmo8uUB1YrbrndnnE2BkfOU0l
Hc5FtVsOafb9mht8r1HB8dXR8gFnRUbcuw+eGmcVdPO79yevV1V5roQLd2FMEdOF
7M57z2RPfzBAulgvNN+8oNTvFtTCaF683Rpkwb3vGvH1627lJ7qCvyUX+yOofWbL
zPIOTsHj50nWtFyPB5Kr3A22+tMIKg==
=MsbM
-----END PGP SIGNATURE-----

--Ch8MmOaCH4u4Q1eF11jYQfzMCcdE30WYj--

