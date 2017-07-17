References: <20170716104714.2113-1-a@...2181...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <efbe1728-11a2-2be8-2cdc-4bd845e1e1d2@...515...>
Date: Mon, 17 Jul 2017 10:54:28 +0300
MIME-Version: 1.0
In-Reply-To: <20170716104714.2113-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH openvpn-build] fix test when white space
 is present
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli.seppanen@...277...>

On 16/07/2017 13:47, Antonio Quartulli wrote:
> For some CHOST ret_want and ret_got may contain a whitespace.
> Add double quotes around ret_want to avoid messing up the test.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  generic/gentoo.config-0.9.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/generic/gentoo.config-0.9.8 b/generic/gentoo.config-0.9.8
> index 2361ae6..7051886 100755
> --- a/generic/gentoo.config-0.9.8
> +++ b/generic/gentoo.config-0.9.8
> @@ -45,7 +45,7 @@ if [ "$1" =3D "test" ] ; then
>  		ret_want=3D${c/*|}
>  		ret_got=3D$(CHOST=3D${CHOST} "$0")
>=20=20
> -		if [ ${ret_want} =3D "${ret_got}" ] ; then
> +		if [ "${ret_want}" =3D "${ret_got}" ] ; then
>  			echo "PASS: ${CHOST}"
>  		else
>  			echo "FAIL: ${CHOST}"
>=20

Hi Antonio,

Would you mind sending this and the "add support for aarch64" patch as
GitHub pull requests here:

<https://github.com/OpenVPN/openvpn-build>

Best regards,

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

