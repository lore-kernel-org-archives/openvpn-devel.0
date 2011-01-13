Message-ID: <4D2F17FA.3020306@...1114...>
Date: Thu, 13 Jan 2011 16:19:22 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4D2C3D0A.2060607@...1114...>
	<4D2E139D.8020809@...1147...>	<4D2ED809.9060008@...1114...>
	<4D2EF9B7.6000303@...515...>
In-Reply-To: <4D2EF9B7.6000303@...515...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN documentation
 (man	page) review
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
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: OpenVPN developers <openvpn-devel@lists.sourceforge.net>, OpenVPN List <openvpn-users@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/01/11 14:10, Samuli Sepp=E4nen wrote:
>=20
>>
>> It should be possible to write a little script which parses the wiki
>> (page content) source text and makes man/html pages and example files
>> based on this.  This could be done before each release.
>>
>> The drawback is that the wiki markup might be too flexible (too many
>> features) and the parsing script might get complicated.
> I'm pretty sure we can get the Wiki contents out in HTML format. And
> there should be plenty of "HTML -> something" converters out there.
>=20

It will probably be just as easy as parsing the wiki markup as the HTML
result.  That parsing code already exists somewhere in Trac.

The problem I was more thinking of is to have a style/layout which
matches man pages, f.ex.  There are certain elements which are required,
and a certain order.  And there are certain things which are not so
easily accessible in man, like how to center text, bullet lists, misc
indentation stuff.

There are several and different "tags" in *roff which are rather
limited, but they work flawlessly when used correctly, in the strict
manner they was designed for.  Wiki-markup/HTML is way more flexible.
Or to say it another way, converting *roff -> HTML is easy as going
downhill, HTML -> *roff is more like going uphill.

However - nothing is impossible, it just takes a bit longer time :)


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0vF/gACgkQDC186MBRfrqO4QCdFzSN7NEbuMkL78TpOE8Ki/H0
zA8AoJe62qdFM25XUK4WjFvSfhhKqXlb
=3D+NCV
-----END PGP SIGNATURE-----

