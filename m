From: Eric Crist <ecrist@...1286...>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: multipart/signed;
	boundary="Apple-Mail=_E68BA853-BF31-4DCC-B488-4DE8A9753336";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Date: Sun, 13 May 2012 15:49:57 -0400
In-Reply-To: <7D1E078E-186D-449E-9B07-E7DA464F4246@...1286...>
References: <CAOazyz3QDHLxY51u0Ya9PscD8Q5+VqqrSn6M6=XpVUiFJY_ENw@...278...>
	<4FA8D931.70107@...515...>
	<CAOazyz2N744s+VJekGJNK4sqHCONLCzMtsiJyRTkgrpO4RWHzw@...278...>
	<363B57F6-F3E8-4C7D-A19D-0E08541233BD@...1286...>
	<20120513090153.GG1359@...1296...>
	<CAOazyz1FB+JU7QRmeMuxMX7-6fAN28VH1-6ApJnOu7eHDq9jUA@...278...>
	<20120513092355.GH1359@...1296...>
	<CAOazyz0=+ZE6+n-KqyzZSJhbweHb236LjwefvV6BtMvfbh37mQ@...278...>
	<20120513093551.GI1359@...1296...>
	<CAOazyz0bEZMBYcKGvKTux=+7XE43=-4Aw02HGVCNHPoO35wAWg@...278...>
	<20120513111240.GK1359@...1296...>
	<65AA0B7D-D286-4DF3-94BA-F2EC1ED7413B@...1458...>
	<7D1E078E-186D-449E-9B07-E7DA464F4246@...1286...>
Message-Id: <B45A15F1-D91C-4EA4-900A-1B55D9A4A3D4@...1286...>
Subject: Re: [Openvpn-devel] [RFC] Split plugins into their own repositories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_E68BA853-BF31-4DCC-B488-4DE8A9753336
X-Eric-Conspiracy: There is no conspiracy.
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

David,

You misrepresent my opinion.  I do NOT want a split, but will deal with one=
 (as a packager) if it becomes necessary.  I would much prefer there to nev=
er be a split, and for everything to be handled with configure args or ifde=
fs in the make file.

-----
Eric F Crist



On May 13, 2012, at 15:42:10, Eric Crist wrote:

> What I had mentioned might be a good alternative in IRC was to have an op=
envpn package, and an openvpn-contrib.  Two isn't hard, 17 or 500 is.  This=
, still, didn't seem to be liked by Alon (not calling you out, per se, but =
stating fact).
>=20
> Not sure where we should go from here other than to stay where we are.  N=
o point in moving until we're all ready to move in the same direction.  If =
need be, we can enforce a dev-team sack race when we next get together. ;)
>=20
> -----
> Eric F Crist
>=20
>=20
>=20
> On May 13, 2012, at 07:40:07, Seth Mos wrote:
>=20
>> Chiming in here,
>>=20
>> Although pfSense is basically a giant tarbal, it has the benefit of bein=
g sure that all parts of it fit together. We also have installable packages=
 and we frequently see issues with that. We are trying to solve some of the=
m using PBI packages just so that each "package" always has it's dependenci=
es in check.
>>=20
>> Although we are just a "consumer", we'd rather have a single FreeBSD por=
t that we build then 5 ports we need to update, with all the required depen=
dencies.
>>=20
>> Our github repo is split into one for packages, tools and pfSense. But e=
ach is really a standalone thing, because there is no overlap. Which probab=
ly my point, the plugin is useless without the main.
>>=20
>> The one git repo for pfSense is pretty manageable, even more so through =
git with Pull requests. The single biggest jump in commits and patches from=
 the community is moving to GitHub. It makes contributions so much easier. =
That said, even for us the amount of simultaneous active coders is about 5,=
 although we do see small patches and pull requests from about 30 or so peo=
ple a year.
>>=20
>> I see nagios using nagios-plugins, that has seperate releases from the m=
ain nagios. So there's that too.
>>=20
>> Just a few thoughts from the other end.
>>=20
>> Really, really, _really_ looking forward to Viscosity and Tunnelblick sh=
ipping Ipv6 enabled clients. Pretty please.
>>=20
>> Cheers,
>>=20
>> Seth
>> pfSense developer
>>=20
>> Op 13 mei 2012, om 13:12 heeft Gert Doering het volgende geschreven:
>>=20
>>> Hi,
>>>=20
>>> On Sun, May 13, 2012 at 02:00:32PM +0300, Alon Bar-Lev wrote:
>>>>>> Can't we progress?
>>>>>=20
>>>>> Why is that progress?
>>>>>=20
>>>>> Change always has drawbacks.  If the plus sides outweighs the drawbac=
ks,
>>>>> change is good.  Change for change's sake, "just because you can chan=
ge
>>>>> it", is not.
>>>>=20
>>>> Yes, but still from your responses I don't see any drawback... maybe I
>>>> am slow learner...
>>>=20
>>> Drawback to maintainers and sysadmins has already been mentioned by
>>> ecrist and me.  Try being a sysadmin for a few weeks and figure out
>>> which bits of xorg you need to download to install xinit, assuming
>>> you have a system without any X libraries and headers yet (in the xorg
>>> example: splitting off "xinit" might actually make sense, but splitting
>>> the basic infrastructure to build anything into about 50 different
>>> "xyz-library" and "xyz-headers" packages is crazyness).
>>>=20
>>> But the onus is not particularily on me: you have not put forward=20
>>> convincing arguments why splitting off a very small number of files=20
>>> that only make use in the context of OpenVPN into their own repository=
=20
>>> has any *advantage*.
>>>=20
>>> The handwavy argument "it will attract more users!" can be countered by
>>> similarily handwaving "I, as a user, hate to download multiple packages
>>> to figure out how to start contributing, and so it will scare *away*
>>> users".
>>>=20
>>>=20
>>> As a counterexample, look at Apache.  They have heaps of modules in
>>> the main tarball, and have no issues with frequent release and with
>>> attracting developers.  And still, modules maintained by non-apache
>>> developers can be developed externally, without having to splitt off
>>> all existing modules beforehand.
>>>=20
>>> gert
>>> --=20
>>> USENET is *not* the non-clickable part of WWW!
>>>                                                         //www.muc.de/~g=
ert/
>>> Gert Doering - Munich, Germany                             gert@...1726...=
...
>>> fax: +49-89-35655025                        gert@...1297...
>>> -----------------------------------------------------------------------=
-------
>>> Live Security Virtual Conference
>>> Exclusive live event will cover all the ways today's security and=20
>>> threat landscape has changed and how IT managers can respond. Discussio=
ns=20
>>> will include endpoint security, mobile security and the latest in malwa=
re=20
>>> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/_____=
__________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>=20
>>=20
>> ------------------------------------------------------------------------=
------
>> Live Security Virtual Conference
>> Exclusive live event will cover all the ways today's security and=20
>> threat landscape has changed and how IT managers can respond. Discussion=
s=20
>> will include endpoint security, mobile security and the latest in malwar=
e=20
>> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and=20
> threat landscape has changed and how IT managers can respond. Discussions=
=20
> will include endpoint security, mobile security and the latest in malware=
=20
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/_______=
________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--Apple-Mail=_E68BA853-BF31-4DCC-B488-4DE8A9753336
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename=signature.asc
X-Eric-Conspiracy: There is no conspiracy.
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJPsBBlAAoJEHKWQhk5DQ0OkxYIALhShyDdfdMQpGXIkYB6q10C
Ym4rsJ47tq7HrYkQTtLYzLydOWWW1CkA+ej2SuuTX5+2HAG1dIhBddl1DxRVuxxW
0KH69EsyPbAvLz1e80+G/HWjRg/s8W7QSfURy0pDufLwKE4mtyCNVODQOfdR4o49
VNKE3HeZc7kCDxtoIITuDNIC2dXOIjFVTWTEWieoLhernm3KdpeGgh3+aWD1rcqt
TzhkKGI9k4jVmeZ+N+wtMu4ONbrM2NkbWGBbfg7unaoRPafU2QngRJDTrmhKnmbc
7PpQknXO1bA7nphkIHPxwK20Xsxr3WTVHBrmqyxjWfwYvfF1H1AiuyprjFdpVGA=
=wwnO
-----END PGP SIGNATURE-----

--Apple-Mail=_E68BA853-BF31-4DCC-B488-4DE8A9753336--

