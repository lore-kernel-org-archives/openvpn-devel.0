References: <1573234655-905-1-git-send-email-lstipakov@...277...>
 <201911091449.xA9Enpkt081718@...2054...>
 <20191109150057.GJ40538@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <62099134-3d8e-a6d7-867b-b4756fb787da@...2080...>
Date: Tue, 12 Nov 2019 19:39:42 +0100
MIME-Version: 1.0
In-Reply-To: <20191109150057.GJ40538@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ZoUDjJpBKInrzC5fWUPttJGRJIzzQtrTA"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: wintun: add
 --windows-driver config option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZoUDjJpBKInrzC5fWUPttJGRJIzzQtrTA
Content-Type: multipart/mixed; boundary="j5f1BklvIS8SlIixsH2bzUfBd2O8Ki3i6";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>, Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <62099134-3d8e-a6d7-867b-b4756fb787da@...2080...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: wintun: add --windows-driver
 config option
References: <1573234655-905-1-git-send-email-lstipakov@...277...>
 <201911091449.xA9Enpkt081718@...2054...>
 <20191109150057.GJ40538@...1296...>
In-Reply-To: <20191109150057.GJ40538@...1296...>

--j5f1BklvIS8SlIixsH2bzUfBd2O8Ki3i6
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 09/11/2019 16:00, Gert Doering wrote:
> Hi,
>=20
> On Sat, Nov 09, 2019 at 03:49:51PM +0100, Gert Doering wrote:
>>      wintun: add --windows-driver config option
>>
>>      Signed-off-by: Lev Stipakov <lev@...515...>
>>      Acked-by: Simon Rozman <simon@...2293...>
>=20
> Ooops.  Misattributed the ACK, so this was really Steffan's ACK.
>=20
> I am not amending & re-pusing the commit.  This will call more confusion.
>=20
> Sorry.

Wise choice.  However you can use another little git feature ... git notes
<https://web.archive.org/web/20180121193320/http://git-scm.com/blog/2010/08=
/25/notes.html>
<https://git-scm.com/docs/git-notes>

Git notes does not change the commitish, but are more weakly tied to commits
and does not have the same "change traceability" as commits does.  So I
recommend to PGP sign notes (which might need to be handled outside git) if=
 it
important to ensure the note is unchanged.  But a note can be

AFAIK, it doesn't push or fetch notes by default, so that might need to be
handled separately, using:

    $ git push <remote> refs/notes/*

To fetch remote notes:

    $ git fetch <remote> refs/notes/*:refs/notes/*

We already have a few notes in our repo for similar situations or clarifica=
tions.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--j5f1BklvIS8SlIixsH2bzUfBd2O8Ki3i6--

--ZoUDjJpBKInrzC5fWUPttJGRJIzzQtrTA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJdyvx0AAoJEIbPlEyWcf3yHbsP/AsTwD8sKujSq1IcB9C8BKMu
NWzs9wkYimbJ/kjkDI4XawTDGPgtLCZJ/3U7+Hc8wAqqUuk6RPECNSj5qMxzVBdH
rfvPgLK5zazup7TkEU3SGlzA07fXjpNgrx81JzPvddgTVYi8BVc8c1BH5Lc3clDJ
+neOe9mEkGUKsDGeTM+HE1mRP5t6gduO0J1iQnU3Jm5F2WM5L0b7jQlTxLbxgUos
juLNo8sEIP1OQNKbL8EAswmSnDh4GmPcZAuUJjbI4GVcN6nssa9Uv+bq4jeKcXoW
u9de9yWfaDzVqDEtYFROVeo1+idMRwF7PfOIeJTmuT1AMgTGhccUzRA3dgTGP4o4
cVuS9+mLSOeRG49i47rtLqEUGcs8/m+AdKRIekjCJgxllhLIiVcsraZAErr3oGVq
RQnsR9KvdNB633u3UrsdMV+J2toFfoLB6UXUHbvdrtrHiwBqagJDcO7txq+JBL3M
cuB94WlitNMFtQ1ToXjDzw9QuRSsVjvIvVurPmsGegxWv30n9fxMVK5FysAuTXm9
sDYBPjbsGpZvQNzwfZ6hsdsuk5n0LCFfvJjSDznVciPD6gqKW69q+jpPnmEr/Sk2
ROzWJLWvCj2r+xyXuBR0jIteOyDqtRai1SdYQ5jyg6ZZfWHhsyHhuv1BfujaSj7y
XbYMDoHJhrkKx/xRLdGZ
=i3+o
-----END PGP SIGNATURE-----

--ZoUDjJpBKInrzC5fWUPttJGRJIzzQtrTA--

