Message-ID: <4C25EC6E.3080808@...1114...>
Date: Sat, 26 Jun 2010 14:02:54 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4C19ED93.50202@...1380...>	<4C1A0941.5000808@...515...>	<AANLkTinkGgRbX7tY0QZzoC-ru5jhKFdpiEgn-proJecI@...278...>	<4C1A1AE1.5090305@...1380...>	<AANLkTimpz7YASaTfmQ5DItwiMrplAx_G93ez2vHxAWW5@...278...>	<4C1A3658.6090501@...1380...>	<4C1A7E26.4010206@...1114...>	<20100618000120.28120.qmail@...1287...>
	<4C2474EC.6000308@...1380...>
In-Reply-To: <4C2474EC.6000308@...1380...>
Subject: Re: [Openvpn-devel] [PATCH] Choose a different field in X509 to	be
 username
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Emilien Mantel <emilien.mantel@...1380...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 25/06/10 11:20, Emilien Mantel wrote:
> Hi,
>=20
> See attached a very small patch (based on allmerged tree) to fix "sizeof".

Thanks a lot!

commit 031d18fcb8a2a552aecabb41f1afdfe3f51bdd58
Author: Emilien Mantel <emilien.mantel@...1380...>
Date:   Sat Jun 26 13:56:48 2010 +0200

    Fixed static defined length check to use sizeof()

    This comes in addition to commit 935c62be9c0c8a256112d after some
    additional review comments.

    Signed-off-by: Emilien Mantel <emilien.mantel@...1380...>
    Acked-by: Peter Stuge <peter@...1287...>
    Signed-off-by: David Sommerseth <dazo@...384...>

Applied to feat_misc and merged into allmerged.


kind regards,

David Sommerseth



> Le 18/06/2010 02:01, Peter Stuge a =E9crit :
>> David Sommerseth wrote:
>>  =20
>>>> 3) "sizeof(common_name)" is useless... Line 745: char
>>>> common_name[TLS_USERNAME_LEN]; we can use directly TLS_USERNAME_LEN.
>>>>       =20
>>> Thanks a lot for the patch and all rework done.  (Also: thank you to all
>>> reviewers!)
>>>
>>> The third and last patch looks very good!  I've applied it to the
>>> feat_misc branch and merged it into allmerged.
>>>     =20
>> I strongly agree with Alon about sizeof() rather than a second
>> reference to the same define. It is the defensive way.
>>
>>
>> //Peter
>>
>> ------------------------------------------------------------------------=
------
>>
>> ThinkGeek and WIRED's GeekDad team up for the Ultimate
>> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the
>> lucky parental unit.  See the prize list and enter to win:
>> http://p.sf.net/sfu/thinkgeek-promo
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>   =20
>=20
>=20
>=20
> -------------------------------------------------------------------------=
-----
> ThinkGeek and WIRED's GeekDad team up for the Ultimate=20
> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the=20
> lucky parental unit.  See the prize list and enter to win:=20
> http://p.sf.net/sfu/thinkgeek-promo
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkwl7G4ACgkQDC186MBRfroyaACfVDmQ4OI9lQ5JgcWGWyqeWbVu
Ev4An3kjEVIkII14MtTIcFqAazY+2sFC
=3Dpq/V
-----END PGP SIGNATURE-----

