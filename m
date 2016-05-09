Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Jens Neuhalfen <openvpn-devel@...2127...>
In-Reply-To: <20160509180427.GL53051@...1296...>
Date: Mon, 9 May 2016 22:39:24 +0200
Message-Id: <58D68395-BFC5-4D6F-91A3-4A973008EB37@...2127...>
References: <280154CA-9468-429B-BCAC-DB632C0AFB32@...2127...>
	<20160509180427.GL53051@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Prevent integration test timeout bc. of
	sudo
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

Hi Gert,

[=E2=80=A6]

>=20
> Git isn't liking the way you send your patches - I'll apply it manually
> (because it makes sense), but please take a look at "git send-email",
> which will ensure that patches and mail headers, blank encoding, and
> everything is perfect?
>=20
> If I try to feed your mail into "git am", it complains about
>=20
> Applying: Prevent integration test timeout bc. of sudo
> fatal: corrupt patch at line 19
> Patch failed at 0001 Prevent integration test timeout bc. of sudo
>=20
> - not sure what it is, but it's usually fixed by "git send-email"... than=
ks.

strange, I use "git format-patch". I guess that "git am=E2=80=9D gets confu=
sed about the =E2=80=9Cduplicate" Subject/From/.. lines (mail header and pa=
tch header).

I=E2=80=99ll switch to send-email

Cheers
Jens=20

[=E2=80=A6]


