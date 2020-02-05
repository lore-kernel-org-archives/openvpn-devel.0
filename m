MIME-Version: 1.0
References: <20200205124615.15758-1-domagoj@...2540...>
 <20200205124615.15758-2-domagoj@...2540...>
In-Reply-To: <20200205124615.15758-2-domagoj@...2540...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 5 Feb 2020 17:27:28 +0200
Message-ID: <CAGyAFMU_L4d2KuzefFRLRiZ=j6_qJKPtmE9hk_p1Qf2Xqk9i+g@...278...>
Content-Type: multipart/alternative; boundary="0000000000000702bf059dd5ccdc"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Skip DNS address validation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Domagoj Pensa <domagoj@...2540...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000000702bf059dd5ccdc
Content-Type: text/plain; charset="UTF-8"

Hi,

Built and tested with msvc, works as expected - "validate=no" is added to
netsh command line.

There is a similar commit in Simon's repo (not yet sent to ml) :
https://github.com/rozmansi/openvpn/commit/6b746cb0bf72a75e9963cc1a037c18cfb856702a


I haven't noticed any slowness on my machine, but since fix has been
implemented separately
by two persons and there is similar code for ipv6, I am ok with that.

Acked-by: Lev Stipakov <lstipakov@...277...>

--0000000000000702bf059dd5ccdc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>Built and tested w=
ith msvc, works as expected - &quot;validate=3Dno&quot; is added to netsh c=
ommand line.</div><div><br></div><div>There is a similar commit in Simon&#3=
9;s repo (not yet sent to ml) :=C2=A0<a href=3D"https://github.com/rozmansi=
/openvpn/commit/6b746cb0bf72a75e9963cc1a037c18cfb856702a">https://github.co=
m/rozmansi/openvpn/commit/6b746cb0bf72a75e9963cc1a037c18cfb856702a</a>=C2=
=A0=C2=A0</div><div><br></div><div>I haven&#39;t noticed any slowness on my=
 machine, but since fix has been implemented separately</div><div>by two pe=
rsons and there is similar code for ipv6, I am ok with that.</div><div><br>=
</div><div>Acked-by: Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...277...=
">lstipakov@...277...</a>&gt;</div></div></div>

--0000000000000702bf059dd5ccdc--

