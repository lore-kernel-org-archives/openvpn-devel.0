Mime-Version: 1.0 (1.0)
From: Marvin Adeff <volleynbike@...277...>
In-Reply-To: <3b9e1a1a-7b61-6edc-1f81-2b42eb5c66c8@...1147...>
Date: Wed, 23 May 2018 09:43:15 -0700
Message-Id: <88509F0A-3CCC-4A33-98AA-4D852FB5368C@...277...>
References: <CAAF3xa85gmN5GEjguVA6cpUPFZuSOKP39g1FKf1hYfmyoo9X5w@...278...>
 <d42dfd0b-8309-2409-0a21-aa97c8a3b651@...2080...>
 <20180522204702.GT79551@...1296...>
 <3b9e1a1a-7b61-6edc-1f81-2b42eb5c66c8@...1147...>
Subject: Re: [Openvpn-devel] Minimum Linux Version for OpenVPN 2.4.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Jan Just Keijser <janjust@...1147...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Thank you Jan, Gert et al for the replies.  Especially Jan for going to all=
 that trouble!

Jan, to all your points =E2=80=94 yes I agree. Upgrading this device to a n=
ewer kernel will be a major undertaking, I won=E2=80=99t bother you all wit=
h the details here. I asked the question to get an idea of how recent we ca=
n go in OpenVPN version in the interim while we plan our overall system upg=
rade (it is currently at 2.3.4 with OpenSSL 1.01h and lzo 2.02).

Thanks again all!  I really appreciate your attention.=20

Best,
Marvin

> On May 23, 2018, at 3:25 AM, Jan Just Keijser <janjust@...1147...> wrote:
>=20
> Hi,
>=20
>=20
>> On 22/05/18 22:47, Gert Doering wrote:
>>> On Tue, May 22, 2018 at 09:10:10PM +0200, David Sommerseth wrote:
>>>> On 22/05/18 19:32, Marvin wrote:
>>>> Can someone tell me the minimum Linux version that OpenVPN 2.4.x will =
build
>>>> and run on?  We have an older appliance the runs on an older 2.4.31 ke=
rnel
>>>> (cannot be upgraded -- but it's very hardened so really doesn't need t=
o be for
>>>> our use.)
>>>=20
>>> But I do know there has been some
>>> code changes over the years which is strictly 2.6 kernel and newer; but=
 its
>>> quite a long time ago so I don't recall exactly what and when.
>> For OpenVPN 2.4, I think we kicked out some old method to set up Linux
>> tunnels.  OTOH, that was 2.2.x stuff, if I remember correctly...
>> (86e2fa5597fd1ad8e010)
>>=20
>>=20
> as usual, Gert is right ...
> I've  dusted off and fired up a really ancient VM running CentOS 3.9, whi=
ch is based on kernel 2.4.21. After falling off my chair in amazement and c=
limbing back on, I then copied over openssl 1.0.2, lzo-2.03 and openvpn 2.4=
.5; openssl builds, as does lzo. As Gert predicted:
> OpenVPN 2.4.5 fails to build on tun.c , line 2092: 'TUNSETGROUP' undeclar=
ed.
>=20
> I then copied over openvpn 2.3.18 and built that: it builds and runs just=
 fine.
> So in short: openvpn 2.3.X is the last version that can be run on a 2.4 k=
ernel.
>=20
> Now stop and think about this:
> - WHY?!?!?!?!!? would you want to do this?
> - as others have said, the 2.4 kernel series is no longer updated , and 2=
.4.31 is not even the last version (that's 2.4.37). I would not  consider a=
ny device running a 2.4 kernel secure enough to run a secure VPN on it, esp=
ecially over the internet.
> - why do would you need openvpn 2.4.x in the first place for such a devic=
e?  if it's AES-GCM that you are looking for then there's a good chance tha=
t  it will be SLOWER on embedded hardware compared to AES-256-CBC+SHA256.
>=20
>=20
> JM2CW,
>=20
> JJK
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

