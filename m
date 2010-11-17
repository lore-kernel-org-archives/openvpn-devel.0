Message-ID: <4CE3C6F7.6040302@...515...>
Date: Wed, 17 Nov 2010 14:13:43 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4CDD641F.30408@...515...>
	<20101112163620.27677.qmail@...1287...>	<4CDD704B.7080505@...1114...>	<20101112165541.29963.qmail@...1287...>	<4CDD7309.3030808@...1114...>
	<4CDD7559.5000604@...515...>	<4CDD77B9.8050606@...1114...>
	<4CDD7D32.2050401@...515...>	<20101112175153.4861.qmail@...1287...>
	<4CE2A7F9.2020402@...515...>
	<20101116155849.23656.qmail@...1287...>
In-Reply-To: <20101116155849.23656.qmail@...1287...>
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

Hi Peter,

Fair points. Me fix and resend.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



> Samuli Sepp=C3=A4nen wrote:
>=20=20=20
>> here's the next version of the patch;
>>=20=20=20=20=20
>
> Functionally fine!
>
>
>=20=20=20
>>  def main(config):
>> +
>> +    # Do a signed build by default
>> +    unsignedBuild=3DFalse
>>=20=20=20=20=20
>
> Maybe name the option signedBuild instead? :)
>
>
>=20=20=20
>> +    # Check if the SignTool module is present. This avoids ImportErrors=
 popping=20
>> +    # up annoyingly _after_ the build.
>> +    if unsignedBuild =3D=3D False:
>> +       try:
>> +          from signtool import SignTool
>> +       except (ImportError):
>> +          print "ERROR: SignTool python module not found! Can't do a si=
gned build."
>> +          sys.exit(1)
>> +
>> +    if unsignedBuild =3D=3D True:
>> +       print "Doing an unsigned build as requested"
>>=20=20=20=20=20
>
> I guess the pythonic way would be simply:
>
> if signedBuild:
>   try import..
> else:
>   print as requested..
>
>
>=20=20=20
>> -    sign(config, 'all')
>> +
>> +    if unsignedBuild =3D=3D False:
>> +       sign(config, 'all')
>> +
>>=20=20=20=20=20
>
> signedBuild would be nicer, then simply:
>
> if signedBuild:
>   sign()
>
>
> //Peter
>
> -------------------------------------------------------------------------=
-----
> Beautiful is writing same markup. Internet Explorer 9 supports
> standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
> Spend less time writing and  rewriting code and more time creating great
> experiences on the web. Be a part of the beta today
> http://p.sf.net/sfu/msIE9-sfdev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=20=20



