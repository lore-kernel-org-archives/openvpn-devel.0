Date: Tue, 28 Mar 2017 00:04:19 +0200
From: Simon Ruderich <simon@...2161...>
Message-ID: <20170327220419.ezcexojotn4w7ak3@...2161...>
References: <1490444478-13188-1-git-send-email-chipitsine@...277...>
	<20170325131746.GC93896@...1296...>
	<5cbc00da-6297-c90a-611c-63ed9b0136a0@...2080...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="=_zucker.schokokeks.org-27430-1490652259-0001-2"
Content-Disposition: inline
In-Reply-To: <5cbc00da-6297-c90a-611c-63ed9b0136a0@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] resolve format string warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-27430-1490652259-0001-2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, Mar 27, 2017 at 11:40:49PM +0200, David Sommerseth wrote:
> On 25/03/17 14:17, Gert Doering wrote:
>> Hi,
>>
>> On Sat, Mar 25, 2017 at 05:21:18PM +0500, Ilya Shipitsin wrote:
>>> [src/openvpn/options.c:1163]: (warning) %x in format string (no. 1) req=
uires 'unsigned int *' but the argument type is 'signed int *'.
>>
>> Please use "uint8_t" then, and also adapt the "ret[i] =3D (uint8_t)byte"
>> line - the cast would then be obsolete.
>
> I would normally agree to use uint8_t ... but the man page for sscanf()
> on Linux says:
>
>    "Matches an unsigned hexadecimal integer; the next pointer must be a
>     pointer to unsigned int."
>
> And stdint.h declares: typedef unsigned char           uint8_t;
>
> AFAIR, char is defined as 8 bits (hence uint*8*), while unsigned int are
> 32 bits on my system.

man inttypes.h yields the necessary constant for uint8_t : SCNu8

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-27430-1490652259-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAljZjFgACgkQkv79t+RM
MvnL/RAAkg89Xjduuh6Fj/mCD3mokWVXcYQq106url5ep/acu6GUUufPGs/R3GWF
PvwNi45wNLoHLOZL64N9A2vSIyweCrMo8Z3aqTvSeitnckbKmrFreQIMncSZT8y4
jxVO+AY2e0ru/GmllmK5AWx/AYBPlBU+lSmXbqm+q3+wNgdXAcDj/R/4l6BcjbPO
ka5IEEDhd6UlZTRBJCVPng2MH6pska3d7/EZ1eL77lxs8WRbgrlg5jFxfO0lKW9y
j79bMfhMKeUiD/sARU9S0JREjTysCzcdYlc6t3K0b3RO8TrmW2BEhc78ntwsQyhO
fQ4CvUGCrFOd3U8a5tGPo3P+Kj8QylTDCbeiWdgy1X1G6O7D46rtsiYyztMh1Jd9
jKZx66kyLEHfdyE6VBquOeAw392irdnkUaj8oJSkV/SOazLeEbe9B0pvwyfJCPHR
Vua7WdJqYy+iL+vpDVbmZ8BV5CtMPoEiyKHulMJZl7/L4O8YId67X4R5Qvk85rKx
Z63OKkk72JyVt4jDAV/8YqComX3yCOK5Tj31c2wMqSnTG/ta8JiMwv8LyAaHAgjO
RMDckFxZG6+pb6vVVYLJoviwJe8pcxQpr4kpeDphY7cnVVzjCTYWybAmpAY2/eSz
unufYmXhqaXryrBmf/agTkO0mvOHNCzajPkazbyFO2A6ZlKYO48=
=xiZD
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-27430-1490652259-0001-2--

