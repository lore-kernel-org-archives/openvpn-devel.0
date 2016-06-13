MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Mon, 13 Jun 2016 16:22:39 -0400
Message-ID: <CAKuzo_hJ3SV0rDSXcYVRCZDS9wqxbxeedoKi=AaqKfEyjmLM0g@...278...>
Content-Type: multipart/alternative; boundary=001a113ac0968bb7c205352ea746
Subject: [Openvpn-devel] Semaphore locking error on windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113ac0968bb7c205352ea746
Content-Type: text/plain; charset=UTF-8

Hi,

Sometimes the semaphore used to avoid parallel net commands fails to lock
on windows. This happens only when a previous run was terminated (say by
ctrl-C) at a time when the register-dns commands are running -- ie. after
"initialization completed" but before the "net commands" are done.

Could be reproduced only if at least one other openvpn process is up and
running in the background as well. So I suspect this is what happens:

As openvpn forks before running register-dns commands, the semaphore is
locked in the child (not using interactive service). When the parent is
terminated with the child still active, it seems the child terminates
abnormally, leaving the semaphore locked. Subsequent processes cannot
anymore get a lock on it.

As Windows clears semaphores when all open handles to it are gone, this is
a problem only when there is one or more other openvpn processes running.

Any suggestions on how to fix this?

Selva

Bonus question: write a unit test that anticipates this and catches it :-)

--001a113ac0968bb7c205352ea746
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Sometimes the semaphore used to avo=
id parallel net commands fails to lock on windows. This happens only when a=
 previous run was terminated (say by <span>ctrl</span>-C) at a time when th=
e register-<span>dns</span> commands are running -- <span>ie</span>. after =
&quot;initialization completed&quot; but before the &quot;net commands&quot=
; are done.=C2=A0</div><div><br></div><div>Could be reproduced only if at l=
east one other <span>openvpn</span> process is up and running in the backgr=
ound as well. So I suspect this is what happens:</div><div><br></div><div>A=
s <span>openvpn</span> forks before running register-<span>dns</span> comma=
nds, the semaphore is locked in the child (not using interactive service). =
When the parent is terminated with the child still active,=C2=A0it seems th=
e child terminates abnormally, leaving the semaphore locked. Subsequent pro=
cesses cannot anymore get a lock on it.</div><div><br></div><div>As Windows=
 clears semaphores when all open handles to it are gone, this is a problem =
only when there is one or more other <span>openvpn</span> processes running=
.</div><div><br></div><div>Any suggestions on how to fix this?</div><div><b=
r><span>Selva</span></div><div><span><br></span></div><div><span>Bonus ques=
tion: write a unit test that anticipates this and catches it :-)</span></di=
v></div>

--001a113ac0968bb7c205352ea746--

