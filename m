MIME-Version: 1.0
In-Reply-To: <65AA0B7D-D286-4DF3-94BA-F2EC1ED7413B@...1458...>
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
Date: Sun, 13 May 2012 14:49:35 +0300
Message-ID: <CAOazyz3-kfTDcrajwRm8L=oAir=cSX5n_F2RBM9R964Hh__oEg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [RFC] Split plugins into their own repositories
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
To: Seth Mos <seth.mos@...1458...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hello Seth,

Thank you this is interesting.

I don't know pfSense... do you have the nation of plugin which is
independent from the core?
I mean pre-defined interface, which is backward compatible?
I looked briefly on the source tree and did not find my way...

A counter example of nagios is cacti... which provides plugins as
their own... :)

So basically you think that openvpn or openvpn-plugin package should
install all plugins, and depend on the union of all, right?

Alon.

On Sun, May 13, 2012 at 2:40 PM, Seth Mos <seth.mos@...1458...> wrote:
> Chiming in here,
>
> Although pfSense is basically a giant tarbal, it has the benefit of being=
 sure that all parts of it fit together. We also have installable packages =
and we frequently see issues with that. We are trying to solve some of them=
 using PBI packages just so that each "package" always has it's dependencie=
s in check.
>
> Although we are just a "consumer", we'd rather have a single FreeBSD port=
 that we build then 5 ports we need to update, with all the required depend=
encies.
>
> Our github repo is split into one for packages, tools and pfSense. But ea=
ch is really a standalone thing, because there is no overlap. Which probabl=
y my point, the plugin is useless without the main.
>
> The one git repo for pfSense is pretty manageable, even more so through g=
it with Pull requests. The single biggest jump in commits and patches from =
the community is moving to GitHub. It makes contributions so much easier. T=
hat said, even for us the amount of simultaneous active coders is about 5, =
although we do see small patches and pull requests from about 30 or so peop=
le a year.
>
> I see nagios using nagios-plugins, that has seperate releases from the ma=
in nagios. So there's that too.
>
> Just a few thoughts from the other end.
>
> Really, really, _really_ looking forward to Viscosity and Tunnelblick shi=
pping Ipv6 enabled clients. Pretty please.
>
> Cheers,
>
> Seth
> pfSense developer
>
> Op 13 mei 2012, om 13:12 heeft Gert Doering het volgende geschreven:
>
>> Hi,
>>
>> On Sun, May 13, 2012 at 02:00:32PM +0300, Alon Bar-Lev wrote:
>>>>> Can't we progress?
>>>>
>>>> Why is that progress?
>>>>
>>>> Change always has drawbacks. =C2=A0If the plus sides outweighs the dra=
wbacks,
>>>> change is good. =C2=A0Change for change's sake, "just because you can =
change
>>>> it", is not.
>>>
>>> Yes, but still from your responses I don't see any drawback... maybe I
>>> am slow learner...
>>
>> Drawback to maintainers and sysadmins has already been mentioned by
>> ecrist and me. =C2=A0Try being a sysadmin for a few weeks and figure out
>> which bits of xorg you need to download to install xinit, assuming
>> you have a system without any X libraries and headers yet (in the xorg
>> example: splitting off "xinit" might actually make sense, but splitting
>> the basic infrastructure to build anything into about 50 different
>> "xyz-library" and "xyz-headers" packages is crazyness).
>>
>> But the onus is not particularily on me: you have not put forward
>> convincing arguments why splitting off a very small number of files
>> that only make use in the context of OpenVPN into their own repository
>> has any *advantage*.
>>
>> The handwavy argument "it will attract more users!" can be countered by
>> similarily handwaving "I, as a user, hate to download multiple packages
>> to figure out how to start contributing, and so it will scare *away*
>> users".
>>
>>
>> As a counterexample, look at Apache. =C2=A0They have heaps of modules in
>> the main tarball, and have no issues with frequent release and with
>> attracting developers. =C2=A0And still, modules maintained by non-apache
>> developers can be developed externally, without having to splitt off
>> all existing modules beforehand.
>>
>> gert
>> --
>> USENET is *not* the non-clickable part of WWW!
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //www.muc.de/~g=
ert/
>> Gert Doering - Munich, Germany =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gert@...1296...
>> fax: +49-89-35655025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gert@...1297...
>> ------------------------------------------------------------------------=
------
>> Live Security Virtual Conference
>> Exclusive live event will cover all the ways today's security and
>> threat landscape has changed and how IT managers can respond. Discussions
>> will include endpoint security, mobile security and the latest in malware
>> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/______=
_________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

