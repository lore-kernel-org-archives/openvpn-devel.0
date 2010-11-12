Message-ID: <4CDD7099.9070609@...515...>
Date: Fri, 12 Nov 2010 18:51:37 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4CDD641F.30408@...515...> <20101112163620.27677.qmail@...1287...>
In-Reply-To: <20101112163620.27677.qmail@...1287...>
Subject: Re: [Openvpn-devel] [PATCH] Removed hardcoded signtool	dependency
 from win/build_all.py
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
To: openvpn-devel@lists.sourceforge.net


> Samuli Sepp=C3=A4nen wrote:
>=20=20=20
>> From 57b983dc2a1f4a31d3b7c0e2f6de7f778d234b2e Mon Sep 17 00:00:00 2001
>> From: =3D?utf-8?q?Samuli=3D20Sepp=3DC3=3DA4nen?=3D <samuli@...515...>
>> Date: Fri, 12 Nov 2010 17:32:19 +0200
>> Subject: [PATCH] Removed hardcoded signtool dependency from win/build_al=
l.py
>>
>> Modified win/build_all.py so that build does not fail even if the option=
al
>> signtool python class is not available.
>>=20=20=20=20=20
>
> What is it needed for? Is it really *always* optional? Maybe some
> setting or parameter to the script so that build can fail e.g. at
> openvpn.net if building, where signing should always be done?
>
>
> //Peter
>=20=20=20
As far as I know driver signing is supposed to be optional. From
"win/settings.in":

# Code Signing.
# If undefined, don't sign any files.
!define SIGNTOOL        "../signtool"
!define PRODUCT_SIGN_CN "openvpn"

This "settings.in" contains many other variables used by the
Python-based build system. Looking at the comments one would think that
simply disabling the the SIGNTOOL variable would allow non-signed
builds. This is not the case, hence the patch. I'm as open as it gets to
suggestions how to make the patch better, though :).


--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


