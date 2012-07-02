Message-ID: <4FF1B28E.3060601@...1114...>
Date: Mon, 02 Jul 2012 16:39:10 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1341239273-7509-1-git-send-email-samuli@...515...>
	<CAOazyz2kExVHuw0GsyYf-suKmr_2qRbLiNLZjUphEzc=H+NTLw@...278...>
In-Reply-To: <CAOazyz2kExVHuw0GsyYf-suKmr_2qRbLiNLZjUphEzc=H+NTLw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Incrementing version number of
 tap-windows to 9.9.1
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/07/12 16:33, Alon Bar-Lev wrote:
> Hi,
>=20
> If you are not going to release, you should keep the _master or
> _beta or any other suffix.

We're shipping this updated code base with the 2.3-alpha2 release ...
so it's just to prepare the tree for that.

We're aware of the code itself shouldn't have changed much.  But as
the complete build tool is replaced, it's just to make sure all
updates goes properly.  And we want this new code base tested.

I'll make sure we switch back to the a _master tag when we this tree
is tagged properly.


kind regards,

David Sommerseth



> On Mon, Jul 2, 2012 at 5:27 PM,  <samuli@...515...> wrote:
>> From: Samuli Sepp=C3=A4nen <samuli@...515...>
>>=20
>> Tap-windows driver is now built using it's own buildsystem,
>> whereas earlier it was built using the Python-based buildsystem
>> in OpenVPN. Incrementing release date and version number in
>> tap-windows/version.m4 to help differentiate these new drivers
>> from the old ones.
>>=20
>> Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...> ---=20
>> version.m4 |    4 ++-- 1 files changed, 2 insertions(+), 2
>> deletions(-)
>>=20
>> diff --git a/version.m4 b/version.m4 index 2d21396..4ac0561
>> 100644 --- a/version.m4 +++ b/version.m4 @@ -1,6 +1,6 @@ dnl
>> define the TAP version define([PRODUCT_NAME], [TAP-Windows])=20
>> -define([PRODUCT_VERSION], [9.9.0_master])=20
>> +define([PRODUCT_VERSION], [9.9.1])=20
>> define([PRODUCT_VERSION_RESOURCE], [9,0,0,9])=20
>> define([PRODUCT_TAP_WIN_COMPONENT_ID], [tap0901])=20
>> define([PRODUCT_TAP_WIN_MAJOR], [9]) @@ -8,4 +8,4 @@
>> define([PRODUCT_TAP_WIN_MINOR], [9])=20
>> define([PRODUCT_TAP_WIN_PROVIDER], [TAP-Windows Provider V9])=20
>> define([PRODUCT_TAP_WIN_CHARACTERISTICS], [0x81])=20
>> define([PRODUCT_TAP_WIN_DEVICE_DESCRIPTION], [TAP-Windows Adapter
>> V9]) -define([PRODUCT_TAP_WIN_RELDATE], [04/19/2010])=20
>> +define([PRODUCT_TAP_WIN_RELDATE], [07/02/2012]) -- 1.7.5.4
>>=20
>>=20
>> ------------------------------------------------------------------------=
------
>>
>>=20
Live Security Virtual Conference
>> Exclusive live event will cover all the ways today's security
>> and threat landscape has changed and how IT managers can respond.
>> Discussions will include endpoint security, mobile security and
>> the latest in malware threats.
>> http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/=20
>> _______________________________________________ Openvpn-devel
>> mailing list Openvpn-devel@lists.sourceforge.net=20
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
> -------------------------------------------------------------------------=
-----
>
>=20
Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and=20
> threat landscape has changed and how IT managers can respond.
> Discussions will include endpoint security, mobile security and the
> latest in malware threats.
> http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/=20
> _______________________________________________ Openvpn-devel
> mailing list Openvpn-devel@lists.sourceforge.net=20
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/xsosACgkQDC186MBRfrryJQCgsLd/euI+Opbw3ZYr4MtiO386
CrIAnA/8T6dHRRg0qvgeztOjB85YD/64
=3D7dzG
-----END PGP SIGNATURE-----

