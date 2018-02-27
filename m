MIME-Version: 1.0
From: =?UTF-8?Q?Erik_Lark=C3=B6?= <erik@...2382...>
Date: Tue, 27 Feb 2018 19:47:58 +0100
Message-ID: <CADReyb2aGWw2iFJWh=VStOAbHq-kr6V-JD6bVBYYVv_CB+9ggw@...278...>
Content-Type: multipart/alternative; boundary="001a113eba0cc23474056636103c"
Subject: [Openvpn-devel] Patch submission : AUTH_FAILED event for plugins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001a113eba0cc23474056636103c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We're developing a new version of our client at =E2=80=8BMullvad
<https://mullvad.net/en/guides/beta-app/> and we're using a plugin to
listen to events from OpenVPN. We have found however that we very much
would like to receive an event when authentication fails.

The patch at =E2=80=8Bhttps://github.com/mullvad/openvpn/pull/1 basically c=
opies
the same event on the management interface side but sends it to plugins
instead.

Please note that I'm not a C developer and might be doing some very silly
mistakes. I apologize in advance for any glaring faults and humbly accept
any feedback you might have.
Cheers!

--001a113eba0cc23474056636103c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>
We&#39;re developing a new version of our client at <a class=3D"ext-link" h=
ref=3D"https://mullvad.net/en/guides/beta-app/"><span class=3D"gmail-icon">=
=E2=80=8B</span>Mullvad</a>
 and we&#39;re using a plugin to listen to events from OpenVPN. We have=20
found however that we very much would like to receive an event when=20
authentication fails.<br>
</p>
<p>
The patch at <a class=3D"ext-link" href=3D"https://github.com/mullvad/openv=
pn/pull/1"><span class=3D"gmail-icon">=E2=80=8B</span>https://github.com/mu=
llvad/openvpn/pull/1</a> basically copies the same event on the management =
interface side but sends it to plugins instead.<br>
</p>
<p>
Please note that I&#39;m not a C developer and might be doing some very=20
silly mistakes. I apologize in advance for any glaring faults and humbly
 accept any feedback you might have. </p>Cheers!<br></div>

--001a113eba0cc23474056636103c--

