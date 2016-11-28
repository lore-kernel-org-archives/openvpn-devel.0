MIME-Version: 1.0
Sender: zhy001@...2186...
In-Reply-To: <1480371252-3880-1-git-send-email-steffan@...1856...>
References: <68d50540-ec71-5564-99a7-7bb24ae05d17@...1856...>
	<1480371252-3880-1-git-send-email-steffan@...1856...>
From: Zhaomo Yang <zhy001@...2187...>
Date: Mon, 28 Nov 2016 15:00:39 -0800
Message-ID: <CA+0EDdBLaPxX3u07yfg=S-xnVEnFRP7oD=2BnpONtjw7EEkPeQ@...278...>
Content-Type: multipart/alternative; boundary=f403045ec63227b1ac0542647380
Subject: Re: [Openvpn-devel] [PATCH v2] Introduce and use secure_memzero()
 to erase secrets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--f403045ec63227b1ac0542647380
Content-Type: text/plain; charset=UTF-8

Hi folks,

Just wanted to let you know that we have a new implementation of
secure_memzero.h, which is available at
https://compsec.sysnet.ucsd.edu/secure_memzero.h.

The version I sent to you guys has a minor issue in dealing with memset_s.
Also, this implementation synthesizes most of the existing working
solutions for this problem.  It allows you to specify, via macros, which
implementation you prefer. This will let users override our defaults, if
they want.

Thanks,
Zhaomo

--f403045ec63227b1ac0542647380
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi folks,=C2=A0<div><br></div><div>Just wanted to let you =
know that we have a new implementation of secure_memzero.h, which is availa=
ble at=C2=A0</div><div><a href=3D"https://compsec.sysnet.ucsd.edu/secure_me=
mzero.h" target=3D"_blank">https://compsec.sysnet.ucsd.<wbr>edu/secure_memz=
ero.h</a>.<br></div><div><br></div><div>The version I sent to you guys has =
a minor issue in dealing with memset_s. Also, this implementation synthesiz=
es most of the existing working solutions for this problem.=C2=A0 It allows=
 you to specify, via macros, which implementation you prefer. This will let=
 users override our defaults, if they want.</div><div><br></div><div>Thanks=
,</div><div>Zhaomo</div></div>

--f403045ec63227b1ac0542647380--

