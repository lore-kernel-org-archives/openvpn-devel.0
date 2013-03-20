From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 20 Mar 2013 10:32:33 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B9013B904FC2D@...1436...>
References: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
	<1363624652-7001-5-git-send-email-steffan.karger@...1435...>
	<20130320085250.GA953@...1296...>
In-Reply-To: <20130320085250.GA953@...1296...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 4/5] Config compatibility patch. Added
 translate_cipher_name.
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Wow, 32 bit. I clearly did not put enough effort in testing polar's newly s=
upported ciphers. I'll take a good look at this.

-Steffan

-----Original Message-----
From: Gert Doering [mailto:gert@...1296...]=20
Sent: woensdag 20 maart 2013 9:53
To: Steffan Karger
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] [PATCH 4/5] Config compatibility patch. Added =
translate_cipher_name.

Hi,

On Mon, Mar 18, 2013 at 05:37:31PM +0100, steffan.karger@...1435... wrote:
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -6223,7 +6223,7 @@ add_option (struct options *options,
>      {
>        VERIFY_PERMISSION (OPT_P_CRYPTO);
>        options->ciphername_defined =3D true;
> -      options->ciphername =3D p[1];
> +      options->ciphername =3D translate_cipher_name(p[1]);
>        if (streq (options->ciphername, "none"))
>  	{
>  	  options->ciphername_defined =3D false;

Uh.  NAK, unfortunately, because while this should work for the actual ciph=
er translation, it fails OCC...

Tue Mar 19 15:45:01 2013 WARNING: 'cipher' is used inconsistently, local=3D=
'cipher BLOWFISH-CBC', remote=3D'cipher BF-CBC'

... incidentially, OCC also gives a hint why the interop test failed...

Tue Mar 19 15:45:01 2013 WARNING: 'keysize' is used inconsistently, local=
=3D'keysize 32', remote=3D'keysize 128'
Tue Mar 19 15:45:01 2013 Data Channel Encrypt: Cipher 'BLOWFISH-CBC' initia=
lized with 32 bit key

"wut?"

gert
--
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

