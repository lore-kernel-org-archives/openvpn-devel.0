MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Fri, 10 Jun 2016 16:18:03 -0400
Message-ID: <CAKuzo_iFCFMnECD2cnu_ZYrD7VuMp2j0j4fiWuCz_Up7RhgMpQ@...278...>
Content-Type: multipart/alternative; boundary=001a1147f47e8832910534f23dc5
Subject: [Openvpn-devel] On the --management-external-cert option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1147f47e8832910534f23dc5
Content-Type: text/plain; charset=UTF-8

Hi,

Commit 39e3d336d4eeab847a3395ddeb430e0a9ca387b9 introduced this feature but
I am not able to get past this parsing error:

With --management-external-cert xxx --management-external-key
and no --cert or --key in the config I get

Options error: If you use one of --cert or --key, you must use them both
Use --help for more information.

Looks like a bug in the parsing logic. Has anyone successfully used this
option?

Combinations like
'--management-external-key --cert filename' parses fine,
'--management-external-cert xxx --key somefile' gives the same error as
above

Thanks,

Selva

--001a1147f47e8832910534f23dc5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Commit 39e3d336d4eeab847a3395ddeb43=
0e0a9ca387b9 introduced this feature but I am not able to get past this par=
sing error:<br></div><div><br></div><div>With --management-external-cert xx=
x --management-external-key</div><div>and no --cert or --key in the <span>c=
onfig</span> I get=C2=A0</div><div><br></div><div><div>Options error: If yo=
u use one of --cert or --key, you must use them both</div><div>Use --help f=
or more information.</div></div><div><br></div><div>Looks like a bug in the=
 parsing logic. Has anyone successfully used this option?<br></div><div><br=
></div><div>Combinations like=C2=A0</div><div>&#39;--management-external-ke=
y --cert filename&#39; parses fine,=C2=A0</div><div>&#39;--management-exter=
nal-cert xxx --key somefile&#39; gives the same error as above</div><div><b=
r></div><div>Thanks,</div><div><br></div><div><span>Selva</span></div></div>

--001a1147f47e8832910534f23dc5--

