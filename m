References: <4B4DBCE6.2010500@...515...>
In-Reply-To: <4B4DBCE6.2010500@...515...>
Mime-Version: 1.0 (Apple Message framework v1077)
Message-Id: <3677B3CA-EAB8-4CF6-AE12-94EE040B848C@...1286...>
From: Eric F Crist <ecrist@...1286...>
Date: Wed, 13 Jan 2010 07:13:51 -0600
Subject: Re: [Openvpn-devel] Summary of the "OpenVPN development model"
	meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Logs for this conversation have been placed at http://secure-computing.net/=
logs/openvpn-20090112.log.

Eric

On Jan 13, 2010, at 06:30:30, Samuli Sepp=E4nen wrote:

> Hi all,
>=20
> Here's a summary of the development model meeting we had yesterday. Let
> me know if you have any comments.
>=20
> --=20
> Samuli Sepp=E4nen
> Community Manager
> OpenVPN Technologies, Inc
>=20
> irc freenode net: mattock
>=20
> "OPENVPN DEVELOPMENT MODEL" MEETING
>=20
> Place: #openvpn-discussion on irc.freenode.net
> Date: Tuesday, 12th January 2010
> Time: 19:00 UTC
>=20
> Full log available here:
>=20
> http://secure-computing.net/logs/%23%23openvpn-discussion.log
>=20
>=20
> SUMMARY
>=20
>=20
> Discussed the possibility of having several per-feature tree (Linux kerne=
l style). Alternatively have separate "unstable" (or "experimental") trees.=
 No decisions here one way or another. Also discussed the relative merits o=
f Subversion and Git in painstaking detail.
>=20
> Agreed that involving the community more in OpenVPN development makes sen=
se for everybody.
>=20
> Agreed that more transparency, openness and communication is necessary. F=
or example have a public roadmap, bug tracker, feature plans etc. Also ther=
e needs to ways for the community to provide input to the project. Discusse=
d the possibility of having community members handle some of the tracker ma=
intenance.
>=20
> Agreed that keeping the code quality high is extremely important. Agreed =
that automated regression testing (unit testing, test frameworks) would hel=
p in achieving this goal. Discussed the possibility to do some of the autom=
ated testing in co-operation with Linux distributors. Also agreed that havi=
ng more community involvement in patch review/preview process would help, e=
.g. by enabling us to spot and communicate problems more easily.
>=20
> Agreed that releases need to made more often. Identified one major proble=
m causing slow release cycles: the long latency between introduction of a b=
ug and the first bug report. Agreed that getting new code to the users as s=
oon as possible helps reduce this latency. Discussed possible means to do t=
his, such as frequent releases, per-feature/unstable/experimental source tr=
ees and daily snapshots. Discussed automated packaging and existing/custom =
software repositories (e.g. Debian, Fedora) as one way to have most up-to-d=
ate code always installed on as many computers as possible.
>=20
> Agreed that having milestones for changing the development model is impor=
tant. Decided to document the basic processes and create a rough outline of=
 current plans a.s.a.p. (1-7 days). Most other tasks are dependent on the s=
etup of the community site. A somewhat realistic estimate for finishing the=
m is 1-2 months.
>=20
> Decided to take a look at how other security-related projects handle deve=
lopers, contributors and patches.
>=20
> Decided that we need to agree upon how to handle the basic processes. The=
se processes need to be documented properly and most importantly followed. =
A high priority was given for the "Contributing to OpenVPN" and "Reporting =
bugs" processes.
>=20
> Decided that development issues should be discussed primarily in the open=
vpn-devel mailinglist. IRC can be used, but not as the main communication c=
hannel due to timezone differences.
>=20
> Decided to have a weekly development meeting in the IRC. Weekday or time =
was not chosen yet.
> -------------------------------------------------------------------------=
-----
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and e=
asy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev _____________________________________=
__________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

---
Eric Crist





