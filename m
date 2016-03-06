MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Sun, 6 Mar 2016 15:17:40 -0500
Message-ID: <CAKuzo_jrTKkAWGv7gRoADPWz5VTDFPqfrHxUDppPuQ63Y+RFKA@...278...>
Content-Type: multipart/alternative; boundary=001a11c2b46465ed93052d670baf
Subject: [Openvpn-devel] operations that still require elevation on windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11c2b46465ed93052d670baf
Content-Type: text/plain; charset=UTF-8

Hi,

There at least two more things on windows that the interactive service has
to support:

(i)  register-dns
(ii) ipv6 address and route setup

Is there anything else? For (ii)  can't it be done using the IP Helper API
on vista+ -- is the use of net command required? If not, it should be easy
to delegate it to the service.

Thanks,

Selva

--001a11c2b46465ed93052d670baf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi, <br><br>There at least two more things on windows=
 that the interactive service has to support:<br><br>(i)=C2=A0 register-dns=
<br>(ii) ipv6 address and route setup<br><br></div><div>Is there anything e=
lse? For (ii)=C2=A0 can&#39;t it be done using the IP Helper API on vista+ =
-- is the use of net command required? If not, it should be easy to delegat=
e it to the service.<br><br></div><div>Thanks,<br><br></div><div>Selva</div=
><div><div><div><div><br><br></div></div></div></div></div>

--001a11c2b46465ed93052d670baf--

