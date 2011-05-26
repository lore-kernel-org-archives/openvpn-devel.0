Message-ID: <4DDE6623.60307@...515...>
Date: Thu, 26 May 2011 17:39:31 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1306416185-4901-1-git-send-email-samuli@...515...>
	<1306416185-4901-2-git-send-email-samuli@...515...>
	<20110526135308.GU8496@...1296...>
In-Reply-To: <20110526135308.GU8496@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] Fixed a number of fatal build
 errors on Visual Studio 2008
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>> diff --git a/win/config.h.in b/win/config.h.in
>> index 82344a0..ec447a2 100644
>> --- a/win/config.h.in
>> +++ b/win/config.h.in
>> @@ -275,7 +275,7 @@ typedef unsigned long in_addr_t;
>>  #define inline __inline
>>=20=20
>>  /* type to use in place of socklen_t if not defined */
>> -#define socklen_t unsigned int
>> +/*#define socklen_t unsigned int*/
>>=20=20
>>  #ifndef __MINGW32__
>>  /* 32-bit unsigned type */
>>=20=20=20=20=20
>
> This needs to be tested whether it still works with mingw/msys - I have
> my doubts.  So this change also needs to be conditional=20
>
> #ifndef _MSC_VER
> #define socklen_t unsigned int
> #endif
>
> (or vice versa, "#ifdef __MINGW32__").
>=20=20=20
As discussed on the IRC, win/config.h.in is only used by the new build
system and will not affect mingw/msys. The rest of the problems
(hopefully) fixed in the patch I sent a few minutes ago.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


