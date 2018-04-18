MIME-Version: 1.0
In-Reply-To: <3ed13a6a-07fd-3f0c-100c-148099bc8971@...277...>
References: <c113c9a5-198e-775b-c183-f319c35bdb28@...515...>
 <3ed13a6a-07fd-3f0c-100c-148099bc8971@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 17 Apr 2018 21:45:24 -0400
Message-ID: <CAKuzo_haG86HMg8+Wet0=m6O9tzU_c92TQSBgJy7NncPv+3=GQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000001ccbe056a159da2"
Subject: Re: [Openvpn-devel] New tap-windows6 driver (9.21.3) available for
 testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000001ccbe056a159da2
Content-Type: text/plain; charset="UTF-8"

Hi,

A couple of things I noticed

(i) On a slightly outdated Windows 7 box (last update in Sep 2017),
previously running 2.4.5, the install appeared to succeed but the tap
adapter was no longer usable -- openvpn errors out with CreateFile()
failure when opening the adapter. Reinstalling or recreating the adapters
did not work. Evenlog showed

Fault bucket , type 0
Event Name: PnPDeviceProblemCode
Response: Not available
Cab Id: 0

Problem signature:
P1: x64
P2: tap0901
P3: {4d36e972-e325-11ce-bfc1-08002be10318}

Anyway, on bringing the system up to date,  reinstalling fixed it. Probably
a one-off thing or gremlins.... So much for that.

(ii) The driver version shows up as 9.0.0.21 -- this is apparently taken
from the inf file. Why is it not 9.21.3? The file version is 9.21.3 9/21 as
expected.

(iii) On Win7, the interface gets metric 20 --- implying a speed < 200 Mbps
as per the Windows automatic metric assignment table. Isn't this supposed
to get detected as a 1Gbps adapter now? The link speed patch is in master
and this one is one point ahead of it (9.21.3), so expected to see it here.

Not even (i) may be related to the signature, so the use of sha256 digest
looks like a non-issue.

Selva

--00000000000001ccbe056a159da2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>A couple of things I noticed</div><=
div><br></div><div>(i) On a slightly outdated Windows 7 box (last update in=
 Sep 2017), previously running 2.4.5, the install appeared to succeed but t=
he tap adapter was no longer usable -- openvpn errors out with CreateFile()=
 failure when opening the adapter. Reinstalling or recreating the adapters =
did not work. Evenlog showed</div><div><br></div><div><div>Fault bucket , t=
ype 0</div><div>Event Name: PnPDeviceProblemCode</div><div>Response: Not av=
ailable</div><div>Cab Id: 0</div><div><br></div><div>Problem signature:</di=
v><div>P1: x64</div><div>P2: tap0901</div><div>P3: {4d36e972-e325-11ce-bfc1=
-08002<wbr>be10318}</div></div><div><br></div><div>Anyway, on bringing the =
system up to date, =C2=A0reinstalling fixed it. Probably a one-off thing or=
 gremlins.... So much for that.</div><div><br></div><div>(ii) The driver ve=
rsion shows up as 9.0.0.21 -- this is apparently taken from the inf file. W=
hy is it not 9.21.3? The file version is 9.21.3 9/21 as expected.</div><div=
><br></div><div>(iii) On Win7, the interface gets metric 20 --- implying a =
speed &lt; 200 Mbps as per the Windows automatic metric assignment table. I=
sn&#39;t this supposed to get detected as a 1Gbps adapter now? The link spe=
ed patch is in master and this one is one point ahead of it (9.21.3), so ex=
pected to see it here.</div><div><br></div><div>Not even (i) may be related=
 to the signature, so the use of sha256 digest looks like a non-issue.</div=
><div><br></div><div>Selva</div></div>

--00000000000001ccbe056a159da2--

