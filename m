MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <2610535.JtY05sqIlT@...1526...>
References: <4F4CE4FE.3010009@...515...> <883843028.20120301125911@...449...>
	<2082061.FfdueT8x4P@...1526...> <2610535.JtY05sqIlT@...1526...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Fri, 9 Mar 2012 17:34:19 +0100
Message-ID: <CAP+U6tKQU=_6V--gFoSN68SLFGWBa+J3pTg2tA5G108+iptbFg@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Heiko Hund <heiko.hund@...1489...>
Cc: =?UTF-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>, openvpn-devel@lists.sourceforge.net

Hi Heiko,

Am 9. M=C3=A4rz 2012 14:42 schrieb Heiko Hund <heiko.hund@...1489...>:
> Instead I plan to secure the process (and the probably the pipe handle as
> well) against malicious operations by not granting the user any sophistic=
ated
> access to it, i.e. you can only inject code if you can write the process'
> memory. This will be enforced by the security descriptor assigned to the
> process by the service at creation time. The service account will own the
> process object, so that the user cannot sneak his way in by modifying the
> DACL.

As I'm not very familiar with the Windows nomenclature, I'm not sure
whether I've correctly understood what you're saying. Does your
approach prevent the user from injecting code into the OpenVPN
process? Or does it only prevent the user from directly accessing the
pipe? (IIUC you would need the integrity level approach to prevent the
former so I assume you're describing how the pipe handle will be
protected instead.)

Cheers
Fabian

