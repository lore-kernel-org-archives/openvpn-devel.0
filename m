Message-ID: <4B6C17D5.2020701@...515...>
Date: Fri, 05 Feb 2010 15:06:29 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4B6C169A.4020608@...515...>
In-Reply-To: <4B6C169A.4020608@...515...>
Content-Type: multipart/mixed; boundary="------------070208020801070101030006"
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (4th Feb 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------070208020801070101030006
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable


> Here's a summary of yesterday's meeting. This and earlier meeting
> summaries are linked to from here:
>
> http://www.secure-computing.net/wiki/index.php/OpenVPN/IRC_meetings
>
>=20=20=20

Oops, and the actual summary here :).

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------070208020801070101030006
Content-Type: text/plain;
 name="openvpn_irc_meeting_2010-02-04.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn_irc_meeting_2010-02-04.txt"

COMMUNITY MEETING

Place: #openvpn-discussion on irc.freenode.net
Date: Thursday, 4th January 2010
Time: 19:00 UTC

Full log available here:

http://secure-computing.net/logs/%23%23openvpn-discussion.log

Next meeting on Thu 11th Feb 2010. Same place, same time.

SUMMARY

Decided to follow David Sommerseth's plans regarding the development process, described in detail in this thread:

 http://sourceforge.net/mailarchive/forum.php?thread_name=20100204190039.GU857%40greenie.muc.de&forum_name=openvpn-devel

Some of the basic ideas are incorporated into this process (swimlane) diagram:

 http://users.utu.fi/sjsepp/openvpn/getting_code_to_openvpn.png

Decided to host David's Git trees in SF.net under the "openvpn" project. James will take care of granting the necessary permissions for David to do that.

Decided to start writing basic developer documentation (e.g. coding conventions, the rules outline in David's email...). This content will be hosted in the Secure Computing Wiki (http://www.secure-computing.net/wiki/index.php/OpenVPN) until the OpenVPN Community site Wiki is up.

Decided to start testing the new development process by integrating the existing IPv6 patchsets to David's Git tree.

Discussed compile-time enablement/disablement of features (#ifdef'd segments in code):
- usage of #ifdefs is necessary to avoid bloat, which hurts OpenVPN's usage especially in embedded systems
- heavy use of #ifdef's can make the code hard to understand
- use of #ifdef's can cause problems when a feature requires extra arguments to function, which leads to more code to maintain

Agreed that code near the core itself should be #ifdef'd sparingly, whereas code at the periphery (e.g. new features) should be #ifdef'd. 

Agreed that the basic development process should go like this:
 - At least 2 developers have to accept each patch (ACK) before it gets to testing tree(s) to weed out obviously bad stuff
 - After initial testing the somewhat stable patchces are merged to the s.c. "stable" SVN tree maintained by James
 - Each release goes through a "feature freeze" where no new functionality is added so most bugs can be weeded out 

Agreed that there is a need to organize the people doing testing because the absense of bug reports (in, say 2 weeks) does not prove that a piece of new code does not have serious problems. In a nutshell, lack of bug reports tells us that
 a) there are no problems with the (new) code
 b) nobody is using the (piece of the) code which has the problem

Agreed that there should be active testers who inform the developers if new code works for them - not just report problems if they encounter them. This helps detecting b), above.

Agreed that developer versions of the application should visibly display them as such, e.g. by printing "This is a devel branch, report your bugs [here] or we'll hunt you down" to STDERR.

---

Discussed forums/mailinglist and packaging topics after the hard-core developer portion was over...

Decided that Samuli will take a look at available OSS forum applications before next meeting. Eric will take a look at commercial alternatives.

Decided to use Debian Experimental repository to redistribute OpenVPN packages built from David's "testing" tree (allmerged?) to Debian users. Alberto volunteered to do the building and uploading to the Debian experimental (~ once per week).

Discussed the need for building "testing" packages each day and distributing them using our own (Debian/Fedora/whatever) repositories. The official Debian repositories require manual work, so fully automated system is not possible without a custom apt repo.

Eric volunteered to provide FreeBSD binaries (from "testing"?) on a weekly basis.

--------------070208020801070101030006--

