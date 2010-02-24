Message-ID: <4B84E51D.6070401@...515...>
Date: Wed, 24 Feb 2010 10:36:45 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4B7F1AAA.5090103@...1114...> <1266637180.23846.1@...1207...>
	<1266641197.32062.0@...1207...>
In-Reply-To: <1266641197.32062.0@...1207...>
Subject: [Openvpn-devel] Feature removal policy [WAS: Re: [PATCH v2] Do not
 randomize resolving of IP addresses in getaddr()]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>> If someone who explicitly chooses a functionality
>> needs to get a warning about the default they
>> should get this warning at ./configure time --
>> the time they make the choice.=20
>>=20=20=20=20=20
>
> The only time I can think of that a warning should
> be delivered to those who explicitly choose
> functionality in the process of deprecation
> is to, _after_ the default has changed,
> deliver a ./configure time warning to those
> who explicitly choose the default telling them
> that they no longer have to be explicit because
> they are choosing what is now the default.
>
> It hardly seems worth it.
>
>=20=20=20
Runtime warnings about deprecated features are important for users who
use packages rather than build from source.

Could you guys take a look at the current FRP draft and let me know if
it needs modifications:

http://www.secure-computing.net/wiki/index.php/OpenVPN/Developer_documentat=
ion#Feature_deprecation

We of course need to decide what triggers the move, say, from step 2 to
step 3. One alternative is to use the "stable" release cycle as a basis.
James guestimated that it'd take 12 months to make a new release. So, if
a feature is deprecated in "testing" just after a stable release is
made, it would stay in the code for

12 months (in testing, outputs a runtime warning)
12 months (in stable, outputs a runtime warning)
12 months (in stable + 1, disabled but available)

So it'd take  24 - 36 months to get rid of a feature, depending on when
(in the release cycle) it's deprecated. There are ways to speed up the
process. We could, for example, have two processes depending on feature
type:

1) longer process for features we know people depend on, but which need
to be removed nevertheless (for whatever reason)
2) shorter process for features somebody _might_ use - like the
randomization feature discussed earlier

The full FRP (see the wiki link) with steps 1-4 would suit type 1
features. Type 2 features could skip step 3 ("disabled but available")
to save time. It should be relatively easy to spot type 1 features: a
mail to the -users mailing list should trigger loud complaints if a
feature is widely used. Also, users have plenty of time to react to the
warnings during the 12-24 month period.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


