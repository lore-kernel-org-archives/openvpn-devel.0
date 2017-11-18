MIME-Version: 1.0
From: Selva <selva.nair@...277...>
Date: Fri, 17 Nov 2017 22:25:09 -0500
Message-ID: <CAKuzo_jBysn9U0BfWPb0m_D2J9Sg3UFLnUUbjiow0wcv0ZiUeg@...278...>
Content-Type: multipart/alternative; boundary="94eb2c043d88b619ff055e39674a"
Subject: [Openvpn-devel] input validation for username, password etc.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c043d88b619ff055e39674a
Content-Type: text/plain; charset="UTF-8"

Hi,

I want to add some form of validation for user input in the GUI so that the
user can be alerted when username, password etc. contains characters that
may not work.

So far the only characters that appear to be problematic are new line
('\n') and embedded '\0'.  As the management interface uses a line based
protocol with '\n' as the delimiter, it can't be a part of input strings
and breaks quoting.

Is there any other character that should be disallowed?

Thanks,

Selva

--94eb2c043d88b619ff055e39674a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I want to add some form of validati=
on for user input in the GUI so that the user can be alerted when <span cla=
ss=3D"" id=3D":1me.1" tabindex=3D"-1" style=3D"">username</span>, password =
etc. contains characters that may not work.</div><div><br></div><div>So far=
 the only characters that appear to be problematic are new line (&#39;\n&#3=
9;) and embedded &#39;\0&#39;.=C2=A0 As the management interface uses a lin=
e based protocol with &#39;\n&#39; as the delimiter, it can&#39;t be a part=
 of input strings and breaks quoting.</div><div><br></div><div>Is there any=
 other character that should be disallowed?</div><div><br></div><div>Thanks=
,</div><div><br></div><div><span class=3D"" id=3D":1me.2" tabindex=3D"-1" s=
tyle=3D"">Selva</span></div></div>

--94eb2c043d88b619ff055e39674a--

