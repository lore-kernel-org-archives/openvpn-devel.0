Mime-Version: 1.0 (Apple Message framework v1244.3)
From: Davide Guerri <d.guerri@...1502...>
In-Reply-To: <20111008103117.GG8496@...1296...>
Date: Sat, 8 Oct 2011 17:50:13 +0200
Message-Id: <5AB7CBF4-64C6-4EF1-A8A1-A902095F14A1@...1502...>
References: <C8EBC1CC-8304-4A97-A2C6-DE114CB05EFF@...1502...>
	<B96E3F2E-F1EF-41B4-9342-16AE68F53A8D@...1502...>
	<49806E1A-9928-4272-8EF5-55943866941D@...1502...>
	<4E8587EC.1020201@...1114...>
	<20111008103117.GG8496@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Client's routes ageing timer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,
sorry for that.

I've just double checked the patch and there is no other code outside an #i=
fdef P2MP_SERVER=20


Davide.


On 08/ott/2011, at 12:31, Gert Doering wrote:

> Hi,
>=20
> On Fri, Sep 30, 2011 at 11:12:12AM +0200, David Sommerseth wrote:
>> On 15/09/11 23:42, Davide Guerri wrote:
>>> Please find attached a patch for a new stale-routes-check (and remove)
>>> option.
>>=20
>> Applied to the master branch in testing and stable trees.=20=20
>=20
> The way this is currently implemented breaks compilation with=20
> --disable-crypto --disable-ssl (glad we have buildbot to test this :) ),
> because in that case, P2MP_SERVER is not enabled, and=20
> options->stale_routes_ageing_time and options->stale_routes_check_interva=
l=20
> are not defined.
>=20
> The patch below moves the block inside the #ifdef P2MP_SERVER block
> inside options.c - the code is not changed, just moved elsewhere.=20=20
>=20
> Smoke-tested on FreeBSD 8.2 (just compilation, not even started).
>=20
> Please verify, ACK, and commit :-)
>=20
> gert
> --=20
> USENET is *not* the non-clickable part of WWW!
>                                                           //www.muc.de/~g=
ert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...
> <0001-move-block-for-stale-routes-check-config-inside-ifde.patch>


