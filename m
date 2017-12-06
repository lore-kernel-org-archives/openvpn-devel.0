From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <0e05c2dd-0b20-4ddd-bd16-dbd2426d38b1@...515...>
Message-ID: <b850b34d-bf9c-f4e2-5142-3437045e2c54@...515...>
Date: Wed, 6 Dec 2017 14:02:23 +0200
MIME-Version: 1.0
In-Reply-To: <0e05c2dd-0b20-4ddd-bd16-dbd2426d38b1@...515...>
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (Wed, 6th Dec 2017)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net


Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 6th Dec 2017
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2017-12-06>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

dazo, mattock and ordex participated in this meeting.

--

Discussed patchwork's inability to change patch state using hint headers:

<https://patchwork.readthedocs.io/en/latest/usage/headers/>

Mattock and ordex looked into patchwork code, which is available here:

<https://github.com/getpatchwork/patchwork>

Looking at parser.py it seems that the state is only set when Patchwork
creates the initial internal representation of the patch. In other words
changing the patch state by replying to patch emails does not work.

Mattock will search the Patchwork mailing list archives to see if there
is a common workaround for this. If not, he will send a query to the
patchwork mailing list.

--

Went through the list of patches in Patchwork:

<https://patchwork.openvpn.net/project/openvpn2/list/>

Patch 115 needs more thorough review from dazo:

<https://patchwork.openvpn.net/patch/115>

Patch 130 was ACKed earlier by syzzer so dazo can merge it:

<https://patchwork.openvpn.net/patch/130>

Patch 50 would require review from somebody who understands Windows:

<https://patchwork.openvpn.net/patch/50/>

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

