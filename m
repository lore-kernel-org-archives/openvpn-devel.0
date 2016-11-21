References: <20161121091013.imxgfilt3byyqu7u@...30...>
	<19b05d6f-1eee-87b8-0e2a-ac0803811a2e@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <1187af34-3a3d-766c-94b9-9500c5bfc26b@...2080...>
Date: Mon, 21 Nov 2016 15:37:45 +0100
MIME-Version: 1.0
In-Reply-To: <19b05d6f-1eee-87b8-0e2a-ac0803811a2e@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="onRePn6bdvDC6n4UeC3qkXxaEnc9DLvGu"
Subject: Re: [Openvpn-devel] Preparing 2.4-beta1 upload to Debian
 (Experimental)
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--onRePn6bdvDC6n4UeC3qkXxaEnc9DLvGu
Content-Type: multipart/mixed; boundary="wPkSDnFQqImsFTXja6T5Ge4N3c9SKDg8I";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
	openvpn-devel@lists.sourceforge.net
Message-ID: <1187af34-3a3d-766c-94b9-9500c5bfc26b@...2080...>
Subject: Re: [Openvpn-devel] Preparing 2.4-beta1 upload to Debian
	(Experimental)
References: <20161121091013.imxgfilt3byyqu7u@...30...>
	<19b05d6f-1eee-87b8-0e2a-ac0803811a2e@...515...>
In-Reply-To: <19b05d6f-1eee-87b8-0e2a-ac0803811a2e@...515...>

--wPkSDnFQqImsFTXja6T5Ge4N3c9SKDg8I
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 21/11/16 14:32, Samuli Sepp=E4nen wrote:
> Il 21/11/2016 11:10, Alberto Gonzalez Iniesta ha scritto:
>> Hi,
>>=20
>> I'm preparing an upload to Debian Experimental of 2.4-beta1 in
>> order to get the maximum exposition as possible. In the meantime
>> I'd like to know your opinion on the following patch that I've
>> been applying to Debian's package for some years:=20
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?att=3D1;bug=3D367716;filen=
ame=3Dopenvpn_367716.diff;msg=3D10
>>
>>=20
Fixing this:
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D367716
>>=20
>> Thanks,
>>=20
>> Alberto
>=20
> That bug report is mighty old, from 2008. I wonder if the problem
> still persists at all?

I hope at least Arne can chime in on this one, as he has done
tremendous work on the socket code.  And I'd be surprised if this
patch applies cleanly on top of our master branch.

Yes, it's an old issue.  But from my brief 3 minutes look at socket.c,
I'd say it looks like to me this is still needed.  The explanation in
the patch makes sense.

But lets hear what Arne and others who know these code paths have to say.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--wPkSDnFQqImsFTXja6T5Ge4N3c9SKDg8I--

--onRePn6bdvDC6n4UeC3qkXxaEnc9DLvGu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYMwa5AAoJEIbPlEyWcf3yoC8P/jH1I2KjTu/ZCkH3oLtB3qhL
S9cbPMf/h1JW86DOHyjI5ivMdVX3/iXyEuMp3MaHIAiFWwfoha9D1z8vmvlSRA8w
WDBHQR7MaLTj90GUYfM5F53+tYsk8XORqjfQsUsKTKxoAk5iAkbjPqa0YZUeyVqU
3siGUEicScVay82DCKYUOWzPwlEy/Llz5W2uNex/ydC6qJdYQyWTNQ7kKi0N/Mcd
7+SVB2RkrYv60TKthRtMkEhmVzyPD870SUAywsVtto04njwB+knulIAvpp1oJ2TP
bCP4j4UbfH9Mt+ykxcTbhaxNQWAd6NsF4jgMNzFyN8CaelZvOxB+JqZIXLgXHl1W
sJmi88tmT2NHM4BkdW9yswXy0fmEDOofcWjHJOGNEGjPb42siqLbHsCbBN6/f+gn
sdCzboilifF2AT1mb0zRtLXG6QSgLHTwhIcbuTqaCelarIljVqlRdoENv/SOGcJd
SbBgzJARDo4arkM1BlgReR3dp6ci7UcC0ZW2DERTqMskcqKqGFte8nW0GJSIH3nc
JSJY7iYJANKlz81u5jJcDTrdpiqoRtpOVTGKIJnQl45SgIIBB8nhdTxEdw/dcF59
I6gv+AUN7qzt2UOKRknS90UTdBxm+YzMexzfbakNRdTYz0n+dim6ebvPTSvDIqny
fEri+idDKj+Wqu27GrPB
=bXe9
-----END PGP SIGNATURE-----

--onRePn6bdvDC6n4UeC3qkXxaEnc9DLvGu--

