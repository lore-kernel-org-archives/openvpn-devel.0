MIME-Version: 1.0
References: <20210922095756.1929-1-chipitsine@...277...>
 <4654662a-587a-ca90-6678-5c5ff71e9c66@...1227...>
In-Reply-To: <4654662a-587a-ca90-6678-5c5ff71e9c66@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 27 Sep 2021 10:58:15 +0300
Message-ID: <CAGyAFMWXBpvo-mxOkNsFrYR9oB9MVRcFEQ6SBs7rP0A6LeNu6Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] BUILD: enable CFG and Spectre
 mitigation for MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>
Cc: Ilya Shipitsin <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I didn't, but here

https://devblogs.microsoft.com/cppblog/spectre-mitigations-in-msvc/

it says that

"On the MSVC team, we=E2=80=99ve reviewed information in detail and conduct=
ed
extensive tests, which showed the performance impact of the new
/Qspectre switch to be negligible."
--=20
-Lev

