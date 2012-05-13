Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: multipart/signed;
	boundary="Apple-Mail=_923B0BC8-A518-4AA8-A77F-DBB013C57C65";
	protocol="application/pgp-signature"; micalg=pgp-sha1
From: Eric Crist <ecrist@...1286...>
In-Reply-To: <65AA0B7D-D286-4DF3-94BA-F2EC1ED7413B@...1458...>
Date: Sun, 13 May 2012 15:42:10 -0400
Message-Id: <7D1E078E-186D-449E-9B07-E7DA464F4246@...1286...>
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
Subject: Re: [Openvpn-devel] [RFC] Split plugins into their own repositories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Seth Mos <seth.mos@...1458...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_923B0BC8-A518-4AA8-A77F-DBB013C57C65
X-Eric-Conspiracy: There is no conspiracy.
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

What I had mentioned might be a good alternative in IRC was to have an open=
vpn package, and an openvpn-contrib.  Two isn't hard, 17 or 500 is.  This, =
still, didn't seem to be liked by Alon (not calling you out, per se, but st=
ating fact).

Not sure where we should go from here other than to stay where we are.  No =
point in moving until we're all ready to move in the same direction.  If ne=
ed be, we can enforce a dev-team sack race when we next get together. ;)

-----
Eric F Crist



On May 13, 2012, at 07:40:07, Seth Mos wrote:

> Chiming in here,
>=20
> Although pfSense is basically a giant tarbal, it has the benefit of being=
 sure that all parts of it fit together. We also have installable packages =
and we frequently see issues with that. We are trying to solve some of them=
 using PBI packages just so that each "package" always has it's dependencie=
s in check.
>=20
> Although we are just a "consumer", we'd rather have a single FreeBSD port=
 that we build then 5 ports we need to update, with all the required depend=
encies.
>=20
> Our github repo is split into one for packages, tools and pfSense. But ea=
ch is really a standalone thing, because there is no overlap. Which probabl=
y my point, the plugin is useless without the main.
>=20
> The one git repo for pfSense is pretty manageable, even more so through g=
it with Pull requests. The single biggest jump in commits and patches from =
the community is moving to GitHub. It makes contributions so much easier. T=
hat said, even for us the amount of simultaneous active coders is about 5, =
although we do see small patches and pull requests from about 30 or so peop=
le a year.
>=20
> I see nagios using nagios-plugins, that has seperate releases from the ma=
in nagios. So there's that too.
>=20
> Just a few thoughts from the other end.
>=20
> Really, really, _really_ looking forward to Viscosity and Tunnelblick shi=
pping Ipv6 enabled clients. Pretty please.
>=20
> Cheers,
>=20
> Seth
> pfSense developer
>=20
> Op 13 mei 2012, om 13:12 heeft Gert Doering het volgende geschreven:
>=20
>> Hi,
>>=20
>> On Sun, May 13, 2012 at 02:00:32PM +0300, Alon Bar-Lev wrote:
>>>>> Can't we progress?
>>>>=20
>>>> Why is that progress?
>>>>=20
>>>> Change always has drawbacks.  If the plus sides outweighs the drawback=
s,
>>>> change is good.  Change for change's sake, "just because you can change
>>>> it", is not.
>>>=20
>>> Yes, but still from your responses I don't see any drawback... maybe I
>>> am slow learner...
>>=20
>> Drawback to maintainers and sysadmins has already been mentioned by
>> ecrist and me.  Try being a sysadmin for a few weeks and figure out
>> which bits of xorg you need to download to install xinit, assuming
>> you have a system without any X libraries and headers yet (in the xorg
>> example: splitting off "xinit" might actually make sense, but splitting
>> the basic infrastructure to build anything into about 50 different
>> "xyz-library" and "xyz-headers" packages is crazyness).
>>=20
>> But the onus is not particularily on me: you have not put forward=20
>> convincing arguments why splitting off a very small number of files=20
>> that only make use in the context of OpenVPN into their own repository=20
>> has any *advantage*.
>>=20
>> The handwavy argument "it will attract more users!" can be countered by
>> similarily handwaving "I, as a user, hate to download multiple packages
>> to figure out how to start contributing, and so it will scare *away*
>> users".
>>=20
>>=20
>> As a counterexample, look at Apache.  They have heaps of modules in
>> the main tarball, and have no issues with frequent release and with
>> attracting developers.  And still, modules maintained by non-apache
>> developers can be developed externally, without having to splitt off
>> all existing modules beforehand.
>>=20
>> gert
>> --=20
>> USENET is *not* the non-clickable part of WWW!
>>                                                          //www.muc.de/~g=
ert/
>> Gert Doering - Munich, Germany                             gert@...1725...=
..
>> fax: +49-89-35655025                        gert@...1297...
>> ------------------------------------------------------------------------=
------
>> Live Security Virtual Conference
>> Exclusive live event will cover all the ways today's security and=20
>> threat landscape has changed and how IT managers can respond. Discussion=
s=20
>> will include endpoint security, mobile security and the latest in malwar=
e=20
>> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/______=
_________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and=20
> threat landscape has changed and how IT managers can respond. Discussions=
=20
> will include endpoint security, mobile security and the latest in malware=
=20
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--Apple-Mail=_923B0BC8-A518-4AA8-A77F-DBB013C57C65
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename=signature.asc
X-Eric-Conspiracy: There is no conspiracy.
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJPsA6TAAoJEHKWQhk5DQ0OVKYIAMfNDOKWSajwtCe4JmHy1fKV
jDIcuUvY0s7DteWkaUkGz+iZdqaHxssj/YkieZKv776gpxozzmHQZFR+no9UXPPP
VZxujIPpKQQdgA5K0oyKTlaQKrcOQJmpF3MKi/ch4ahzuzRTloZtOa1dcnv4kHwq
9f2/981+r2cGWKpMaF3Z6IRxTxdgV2mcom1mbmlKEjwnkJyE4BOTldnH5C0/zFnE
dxjfxSK6X+rvI9UbH0i0LC+V+hPyBARClzQU8yMO2aQ0xzLPUQMe9bnsrotNkaD3
QqyCYK9Q+QKkxv8203G+JvwvIMEYNBrfMrN2g3APR3+Xy0HKOvpymE2excSoz1Y=
=u+jH
-----END PGP SIGNATURE-----

--Apple-Mail=_923B0BC8-A518-4AA8-A77F-DBB013C57C65--

