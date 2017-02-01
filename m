MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 1 Feb 2017 17:19:53 +0500
Message-ID: <CAFHpkQHcC4o5RWhmz58Q2sKE1a89QDg=r9QuJa3uM4zOvShNVw@...278...>
Content-Type: multipart/alternative; boundary=001a1148e7c2e3385c05477710cd
Subject: [Openvpn-devel] pushing some IV_xxx on "There are no TAP-Windows
 adapters on this system." ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1148e7c2e3385c05477710cd
Content-Type: text/plain; charset=UTF-8

Hello,

Tue Jan 31 19:38:32 2017 MANAGEMENT: Client disconnected
Tue Jan 31 19:38:32 2017 There are no TAP-Windows adapters on this system.
You should be able to create a TAP-Windows adapter by going to Start -> All
Programs -> KonturVPN -> Add a new TAP-Windows virtual ethernet adapter.
Tue Jan 31 19:38:32 2017 Exiting due to fatal error


it happens from time to time (people use regcleaner, disable tap-adapter,
etc....)
from the server point of view, everything looks ok, user is authorized....

what if we will push some IV_xxx message ?
it will help us to detect such problem on the server side...

actually, it should be handled better on client side as well.
I like the SoftEtherVPN approach, it creates separate adapter per
connection, and specifies adapter name explicetly. so, you can know for
sure, whether adapter is available or not.

well, the described issue "no tap adapter available" seems to be the most
recent in our case, I'm going to do something with it


Cheers,
Ilya Shipitsin

--001a1148e7c2e3385c05477710cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>Tue Jan 31 19:38:32 2=
017 MANAGEMENT: Client disconnected</div><div>Tue Jan 31 19:38:32 2017 Ther=
e are no TAP-Windows adapters on this system.=C2=A0 You should be able to c=
reate a TAP-Windows adapter by going to Start -&gt; All Programs -&gt; Kont=
urVPN -&gt; Add a new TAP-Windows virtual ethernet adapter.</div><div>Tue J=
an 31 19:38:32 2017 Exiting due to fatal error</div><div><br></div><div><br=
></div><div>it happens from time to time (people use regcleaner, disable ta=
p-adapter, etc....)</div><div>from the server point of view, everything loo=
ks ok, user is authorized....</div><div><br></div><div>what if we will push=
 some IV_xxx message ?</div><div>it will help us to detect such problem on =
the server side...</div><div><br></div><div>actually, it should be handled =
better on client side as well.</div><div>I like the SoftEtherVPN approach, =
it creates separate adapter per connection, and specifies adapter name expl=
icetly. so, you can know for sure, whether adapter is available or not.</di=
v><div><br></div><div>well, the described issue &quot;no tap adapter availa=
ble&quot; seems to be the most recent in our case, I&#39;m going to do some=
thing with it</div><div><br></div><div><br></div><div>Cheers,</div><div>Ily=
a Shipitsin</div></div>

--001a1148e7c2e3385c05477710cd--

