References: <6c0ea9bb-351e-1c5a-eb2e-ed8a301ececf@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <d6bc8749-5ebf-e8f4-f311-e13a02b61684@...515...>
Date: Mon, 22 Aug 2016 23:00:49 +0300
MIME-Version: 1.0
In-Reply-To: <6c0ea9bb-351e-1c5a-eb2e-ed8a301ececf@...515...>
Subject: [Openvpn-devel] Summary of today's (Monday,
	22nd Aug 2016) community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

Here's the summary of today's IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Monday 22nd August 2016
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2016-08-22>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron3, dazo, jamesyonan, mattock, OSTIF-Derek, syzzer, Thermi and=20
valdikss participated in this meeting.

---

Discussed the Mozilla SOS grant which OSTIF.org wishes to apply for on=20
behalf of the the OpenVPN project. The goal is to have an external party=20
(of Mozilla's choosing) do an audit of the OpenVPN codebase. It was=20
agreed that this plan makes sense, and that the audit should focus on=20
late OpenVPN 2.4 beta or RC version, instead of current stable versions=20
(e.g. 2.3.12). If the grant application is rejected, then OSTIF.org will=20
resort to their backup plan, which is to raise money from VPN providers=20
using OpenVPN.

A secure channel for discussing any found zero-day exploits is required,=20
and several alternatives were proposed.

---

Discussed an issue with .ovpn file associations in Windows. It would be=20
best if clicking on a .ovpn file would bring up a gui that asks "do you=20
want to import this, or start it right away". Valdikss has planned on=20
doing a GUI such as that, and will hopefully provide a patch soon.

---

Discussed OpenVPN 2.3.12 release. It was agreed that the release/2.3=20
branch contains enough "stuff" for a release. It was decided to make the=20
release tomorrow (Tue) afternoon.

---

Discussed [=E2=80=8BPATCH v2]: Drop recursively routed packets from Lev:

<https://sourceforge.net/p/openvpn/mailman/message/34737757/>

Cron3 gave the patch an ACK. It was agreed to merge it to "release/2.3"=20
and "master" branches, so that it can go to 2.3.12, and to optimize and=20
refactor the patch later in "master" branch. Cron3 volunteered to do the=20
refactoring.

---

Discuss the "Do not pass env for system commands on Linux/Windows/OS X=20
patchset from valdikss":

<https://sourceforge.net/p/openvpn/mailman/message/35265481>

Cron3 had given the current implementation a NACK earlier, and dazo gave=20
his during the meeting. An alternative implementation was also=20
suggested. The pre-meeting discussion is also available in the attached=20
chatlog.

---

Discussed "=E2=80=8Bblock-outside-dns and multiple tunnels":

<https://sourceforge.net/p/openvpn/mailman/message/35263770/>
<https://community.openvpn.net/openvpn/ticket/718>

It was agreed to move this forward by looking into the approaches=20
suggested by Selva, and by giving him feedback.

---

Discussed testing on Windows. There is one particular patch which needs=20
careful testing:

<https://sourceforge.net/p/openvpn/mailman/message/35180749/>

While this one can be tested manually, we should automate testing=20
Windows-specific features such as "--ip-win32", netsh, api, service=20
later. Test automation was not seen as a blocker for 2.4.0.

Mattock will create a Wiki page for Windows testing, and content will be=20
added there by others as needed. The Windows testing project will be=20
announced in a separate email to openvpn-devel mailing list.

--

Discussed various ways to archive our emails now that Gmane is gone.=20
Dazo has added our mailing lists to mail-archive.com. Mattock will see=20
if he could export some of the emails from SF.net archives and import=20
them to mail-archive.com. Meanwhile ecrist is looking into self-hosting=20
our email archives using pipermail.

--=20

Full chatlog has been attached to this email.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


