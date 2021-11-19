MIME-Version: 1.0
References: <YZf4ch72IZYhz5Tb@...1296...>
 <BF86C1C6-216E-4D87-9D88-B5D03F84159D@...277...>
In-Reply-To: <BF86C1C6-216E-4D87-9D88-B5D03F84159D@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 19 Nov 2021 16:27:35 -0500
Message-ID: <CAKuzo_hrpBxCT8NDosi9AbMKFCpGkCF-cE_qYVtuL3Nh-C-pCw@...278...>
Content-Type: multipart/alternative; boundary="00000000000089e73005d12af226"
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000089e73005d12af226
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 19, 2021 at 3:04 PM <lstipakov@...277...> wrote:

> Ok, my idea was to fix only config loading dir. Apparently this is not
> enough, so I=E2=80=99ll look into ENGINESDIR too.


What we need is a proper build that can be safely distributed. Whatever
that takes. My understanding is that if we have to get with prefix and
OPENSSLDIR set to values recommended by OpenSSL on Windows or something
appropriate for our own use and still safe.

Default location of configs, engine dlls, modules etc. depend on those two
definitions -- we can't leave them at arbitrary values that are not write
protected or unusable.

Selva

--00000000000089e73005d12af226
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Fri, Nov 19, 2021 at 3:04 PM &lt;<a href=3D"mai=
lto:lstipakov@...277...">lstipakov@...277...</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Ok, my idea was to fix only con=
fig loading dir. Apparently this is not enough, so I=E2=80=99ll look into E=
NGINESDIR too.</blockquote><div><br></div><div>What we need is a proper bui=
ld that can be safely distributed. Whatever that takes. My understanding is=
 that if we have to get with prefix and OPENSSLDIR set to values recommende=
d by OpenSSL on Windows or something appropriate for our own use and still =
safe.=C2=A0</div><div><br></div><div>Default=C2=A0location of configs, engi=
ne dlls, modules etc. depend on those two definitions -- we can&#39;t leave=
 them at arbitrary values that are not write protected or unusable.</div><d=
iv><br></div><div>Selva</div></div></div>

--00000000000089e73005d12af226--

