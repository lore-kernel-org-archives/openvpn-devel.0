Message-ID: <4B6564E1.1000506@...515...>
Date: Sun, 31 Jan 2010 13:09:21 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] New development process ready
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

I discussed the main development process of OpenVPN with James and a few
community developers in the IRC. This is what I ended up with:

http://users.utu.fi/sjsepp/openvpn/getting_code_to_openvpn.png

Let me know what you think - especially if there are problems that need
to be fixed. The diagram itself should be pretty self-explanatory. I'll
summarize the main points here:

- James maintains the "stable" OpenVPN tree and take care of stable releases
- All code goes to "stable" through a "testing" tree
- Merges from testing to stable are discussed on Thursday's meetings
(19:00 UTC, #openvpn-discussion at irc.freenode.net)
- James merges stable patches from "testing" to "stable" on Thu-Fri
- If necessary, invasive new features are tested in separate
feature-testing trees which are kept in sync with testing

Use of automated package building and software repositories should help
reduce the latency between introduction and detection of a bug. I'll
start working on this soon.

Now all we need are people willing and capable of maintaining the
"testing" tree. Any volunteers or suggestions :)?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


