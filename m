Message-ID: <4C36E333.3000600@...515...>
Date: Fri, 09 Jul 2010 11:52:03 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Buildbot build triggering setup
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

Hi,

As promised in IRC meeting on July 1st
(http://thread.gmane.org/gmane.network.openvpn.devel/3815) I checked if
it's possible to trigger builds by reading the VCS changes from SF.net
Git repository RSS feed. Unfortunately I found nothing 100% usable using
Google or by searching buildbot-devel mailinglist archives. If we still
want go the RSS feed route, we could perhaps build on this Mercurial RSS
feed poller:

<http://buildbot.net/trac/ticket/76>

A simpler alternative supported out of the box would be this:

- add the post-receive-email hook into SF.net git repository and
configure it to send mail to buildbot account on build server
- configure buildbot to trigger a build when it receives an email from
SF.net git

Unlike I previously assumed, there's no need to create a separate
openvpn-commits list. Unless somebody is itching to write a new Python
ChangeSource for Buildbot, I suggest using the MailParser approach. For
more information about that, see these links:

<http://djmitche.github.com/buildbot/docs/0.7.12/#Mail_002dparsing-ChangeSo=
urces>
<http://sourceforge.net/apps/trac/sourceforge/wiki/Git#Commitemailhooksetup>
<http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob;f=3Dcontrib/hooks/post-rec=
eive-email;hb=3DHEAD>

Any thoughts?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


