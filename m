MIME-Version: 1.0
References: <Yv9fczYCUEM3i6V4@...1296...>
 <20220819193005.210-1-lstipakov@...277...>
 <YwEGlqATPpa7ATpb@...1296...>
 <CAGyAFMUX9suAfWWsDanhk=ZYbQW2tY8hmpbj3sbsCJf0_qU+tQ@...278...>
In-Reply-To: <CAGyAFMUX9suAfWWsDanhk=ZYbQW2tY8hmpbj3sbsCJf0_qU+tQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 21 Aug 2022 12:28:15 -0400
Message-ID: <CAKuzo_hyreVwf5DEDGQNOXNtci8pE8Kf=tBCnhw0X+Xh0PEEFQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000067f08505e6c2d7f8"
Subject: Re: [Openvpn-devel] [PATCH v102 3/7] dco-win: implement ovpn-dco
 support in P2P Windows code path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, Simon Rozman <simon@...2293...>, =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Antonio Quartulli <a@...2181...>

--00000000000067f08505e6c2d7f8
Content-Type: text/plain; charset="UTF-8"

Hi,

Did a quick test on Windows 10 and appears to work as expected. Some minor
things:

(i) I had persist-tun which caused a fatal error that required opening the
log file to find what's wrong and then fix the config file -- unfortunately
the GUI status window cannot display such early errors. Isn't a warning
that persist-tun is not supported enough?

(ii) windows-driver ovpn-dco   (without the trailing -win) would be better?
"windows" is already there in the option name.

Selva

--00000000000067f08505e6c2d7f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>Did a quick=C2=A0t=
est on Windows 10 and appears to work as expected. Some minor things:</div>=
<div><br></div><div>(i) I had persist-tun which caused a fatal error that r=
equired opening the log file to find what&#39;s wrong and then fix the conf=
ig file -- unfortunately the GUI status window cannot display such early er=
rors. Isn&#39;t a warning that persist-tun is not supported enough?</div><d=
iv><br></div><div>(ii) windows-driver ovpn-dco=C2=A0 =C2=A0(without the tra=
iling -win) would be better? &quot;windows&quot; is already there in the op=
tion name.</div><div><br></div><div>Selva</div></div></div>

--00000000000067f08505e6c2d7f8--

