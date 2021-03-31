From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <3898de1c-1799-46f3-2ec2-55f70fa04679@...515...>
Message-ID: <8a546d30-85f8-c14a-6751-3f248fbb2350@...515...>
Date: Wed, 31 Mar 2021 14:10:17 +0300
MIME-Version: 1.0
In-Reply-To: <3898de1c-1799-46f3-2ec2-55f70fa04679@...515...>
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (31st March 2021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net / Jitsi
Date: Wed 31st March 2021
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-03-31>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, d12fk, lev, mattock and plaisthos participated in this meeting.

---

Noted that plaisthos is about sixty patches ahead of "master" in 
Patchwork. He also has additional local patches that will be published 
later. Antonio has reviewed many of these which helps cron2 a lot as 
he's only able to review on weekends. Sending DCO patches makes little 
sense before plaisthos' work is merged.

--

Discussed the OpenVPN 2.5.2 release:

- Agreed make the release next Wednesday (7th April 2021)
- It will also include the latest OpenSSL with security fixes

--

Talked about the OpenVPN security issue for which we have a CVE. Agreed 
that we may need to release 2.4.11 too as 2.4 is fully supported until 
May 2022.

--

Discussed the dco-win MSI installer. Noted that the current code 
originates from Wintun. As Wintun license is not compatible with OpenVPN 
Connect (proprietary) we should write our own MSI installer that could 
be shared between OpenVPN (community versions) and OpenVPN Connect 
(proprietary). The OpenVPN Connect team can probably build a replacement 
MSI installer in a way that is compatible on code and license level with 
community OpenVPN.

--

Discussed kicking out Wintun from OpenVPN 2.6. Noted that the new Wintun 
versions do not support the API we're currently using in OpenVPN's 
Wintun integration. So, if security issues are found in Wintun we would 
have to backport them to our old Wintun version. Also, the new driver is 
only available as a DLL and we prefer to build our dependencies 
ourselves. Also, because we have tap-windows6 (slower, but supports all 
use-cases) and dco-win (faster, but more limited use-cases) available, 
having a third driver makes little sense. One motive to keep Wintun is 
that dco-win will only work on Windows 10 20H1, so Windows Server is 
unable to use it yet.

--

Noted that the "remove LZ4 from openvpn-build" PR failed Travis tests:

<https://github.com/OpenVPN/openvpn-build/pull/210>

Mattock will trigger a new build to see if that helps.

--

Agreed that Travis CI's new open source policies are unclear enough to 
force us to move to GitHub Actions. Mattock agreed to ask chipitsine if 
he wants to add GitHub actions support to our GitHub repos.

--

Lev will build an installer that includes Selva's patch that rips out 
OpenVPNServiceLegacy from openvpnserv.exe. The 2.5.x MSIs do not install 
OpenVPNServiceLegacy so no MSI changes are needed.

--

Played with the idea of using IPSec as the data channel for OpenVPN. On 
some high-end NICs this would allow reaching wire speeds.

---

This was a video meeting so there's no chat backlog.

