Message-ID: <4B4DBCE6.2010500@...515...>
Date: Wed, 13 Jan 2010 14:30:30 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020609050809040103060100"
Subject: [Openvpn-devel] Summary of the "OpenVPN development model" meeting
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
--------------020609050809040103060100
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

Here's a summary of the development model meeting we had yesterday. Let
me know if you have any comments.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------020609050809040103060100
Content-Type: text/plain;
 name="openvpn_irc_meeting_2010-01-12.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn_irc_meeting_2010-01-12.txt"

"OPENVPN DEVELOPMENT MODEL" MEETING

Place: #openvpn-discussion on irc.freenode.net
Date: Tuesday, 12th January 2010
Time: 19:00 UTC

Full log available here:

http://secure-computing.net/logs/%23%23openvpn-discussion.log


SUMMARY


Discussed the possibility of having several per-feature tree (Linux kernel style). Alternatively have separate "unstable" (or "experimental") trees. No decisions here one way or another. Also discussed the relative merits of Subversion and Git in painstaking detail.

Agreed that involving the community more in OpenVPN development makes sense for everybody.

Agreed that more transparency, openness and communication is necessary. For example have a public roadmap, bug tracker, feature plans etc. Also there needs to ways for the community to provide input to the project. Discussed the possibility of having community members handle some of the tracker maintenance.

Agreed that keeping the code quality high is extremely important. Agreed that automated regression testing (unit testing, test frameworks) would help in achieving this goal. Discussed the possibility to do some of the automated testing in co-operation with Linux distributors. Also agreed that having more community involvement in patch review/preview process would help, e.g. by enabling us to spot and communicate problems more easily.

Agreed that releases need to made more often. Identified one major problem causing slow release cycles: the long latency between introduction of a bug and the first bug report. Agreed that getting new code to the users as soon as possible helps reduce this latency. Discussed possible means to do this, such as frequent releases, per-feature/unstable/experimental source trees and daily snapshots. Discussed automated packaging and existing/custom software repositories (e.g. Debian, Fedora) as one way to have most up-to-date code always installed on as many computers as possible.

Agreed that having milestones for changing the development model is important. Decided to document the basic processes and create a rough outline of current plans a.s.a.p. (1-7 days). Most other tasks are dependent on the setup of the community site. A somewhat realistic estimate for finishing them is 1-2 months.

Decided to take a look at how other security-related projects handle developers, contributors and patches.

Decided that we need to agree upon how to handle the basic processes. These processes need to be documented properly and most importantly followed. A high priority was given for the "Contributing to OpenVPN" and "Reporting bugs" processes.

Decided that development issues should be discussed primarily in the openvpn-devel mailinglist. IRC can be used, but not as the main communication channel due to timezone differences.

Decided to have a weekly development meeting in the IRC. Weekday or time was not chosen yet.

--------------020609050809040103060100--

