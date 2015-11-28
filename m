References: <20151125082651.GT24952@...1296...>
	<1448477731-21421-1-git-send-email-iam@...2070...>
	<56560812.4050008@...2070...>
	<CAKuzo_j+asj4qBeZEPMcOH5coqy2PmXpLzBQQ5Vd6j8jJ2njbQ@...278...>
	<5659C357.8030206@...2070...>
	<CAKuzo_ie5x9Ov_kTwXCtnD2F6QA9p-n710SDntuVovgA59gERg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <565A3985.3030800@...1227...>
Date: Sun, 29 Nov 2015 00:32:22 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_ie5x9Ov_kTwXCtnD2F6QA9p-n710SDntuVovgA59gERg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v5-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>, ValdikSS <iam@...2070...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 28.11.15 um 18:25 schrieb Selva Nair:
> Hi,
>=20
> On Sat, Nov 28, 2015 at 10:08 AM, ValdikSS <iam@...2070...
> <mailto:iam@...2070...>> wrote:
>=20
>     Hi!
>=20
>     You have the point, note is confusing on XP. Changed it to "=85on
>     Windows Vista or later".
>=20
>=20
> That doesn't make it any less confusing. If I run a generic 2.3 (i.e no
> wfp) build on on windows 7. I'll get that warning even though I am on
> "vista or later". So it has to be something like "..not supported in
> this build" or whatever... We can't anticipate on what version of
> windows a build without wfp compiled-in may be run..
> =20
>=20
>=20
>     Non-fatal note message is intended to have one config file on
>     various platforms without any modifications.=20
>=20
>=20
> There is already a way to handle that. So why break it for someone who
> doesn't want to ignore unknown options? In my view a better way is to
> let the existing code in options.c handle it appropriately (as fatal or
> warn depending on other options, whether its being pushed or read from
> config etc..)

I am also voting on fatal error if the option is unknown. You can always
use setenv opt block-outside-dns or use ignore-unknown-option if you do
not want it to fail.

Arne


