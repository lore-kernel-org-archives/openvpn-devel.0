From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <c64336dd-09d7-4920-a841-419d14aa7793@...515...>
Message-ID: <8be0d1d1-fc02-4200-2cbc-099a7bb8daec@...515...>
Date: Wed, 25 Oct 2017 20:46:31 +0300
MIME-Version: 1.0
In-Reply-To: <c64336dd-09d7-4920-a841-419d14aa7793@...515...>
Content-Language: en-US
Subject: [Openvpn-devel] Summary of community meeting (Wed, 25th Oct 2017)
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
Date: Wednesday 25th Oct 2017
Time: 19:00 CET (17:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2017-10-25>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

dazo, mattock, ordex and syzzer participated in this meeting.

--

Discussed ways to avoid user fingerprinting in tls-crypt-v2. Agreed that
at best we could offer pseudo-anonymity. Thus it was agreed that instead
of spending time anonymizing tls-crypt-v2 we should put work into
allowing transport layer plugins. The plugins could then handle the
anonymity part, e.g. via traffic obfuscation.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

