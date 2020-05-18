References: <1521522224-18829-1-git-send-email-selva.nair@...277...>
 <1521522224-18829-2-git-send-email-selva.nair@...277...>
 <CAKuzo_iZtshFKPdFBwnLHP2Z9_rdKRsZ_jLxPiVyhkNq9xu1iw@...278...>
 <20200513163619.GH1431@...1296...>
 <CAKuzo_gNp+3UDB_48d9vR43SnivSLk8ytsZtaKqLQO4uJOyTQA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <f25d5098-01a4-137f-f4d8-f812ce432130@...1227...>
Date: Mon, 18 May 2020 12:20:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gNp+3UDB_48d9vR43SnivSLk8ytsZtaKqLQO4uJOyTQA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DtKGnT4zbWJoj4kpKo13FcNeInN61jvAf"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Allow repeated cycles through
 remotes when management-query-remote is in use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DtKGnT4zbWJoj4kpKo13FcNeInN61jvAf
Content-Type: multipart/mixed; boundary="xUqOMYVtHxlm937PnHInL6xJmOLMIUZ7Y"

--xUqOMYVtHxlm937PnHInL6xJmOLMIUZ7Y
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 13.05.20 um 19:44 schrieb Selva Nair:
> Hi,
>=20
> On Wed, May 13, 2020 at 12:36 PM Gert Doering <gert@...1296...> wrote:
>>
>> Hi,
>>
>> On Sun, Jun 09, 2019 at 03:33:55PM -0400, Selva Nair wrote:
>>> Ref: https://patchwork.openvpn.net/project/openvpn2/list/?series=3D201
>>>
>>> These patches were meant to help implement choosing the remote through
>>> the GUI. I may not find time for that but the patches by themselves
>>> are still relevant.
>>>
>>> If there is some interest I'll rebase to master.
>>
>> I'm working my way through the patch queue these days, and now I'm
>> at this one :-)
>>
>> Can you elaborate a bit how this would work, and how much work on the
>> GUI side would be needed?  (And, yes, a rebased patch :) ).
>=20
> From what I can recall...
>=20
> Two points to note:
>=20
> (i) With multiple remotes, openvpn exits if no successful connection
> could be made after two cycles through all remotes (undocumented?) .
> (ii) When --management-query-remote is used, the core presents one
> remote at a time and the user has to make a choice to skip, accept or
> replace without knowing which remotes are available.
>=20
> Now, for a user-friendly implementation of selecting the remote from a
> GUI dialog, the plan is to silently cycle through all remotes, make a
> list and then allow the user to make a selection from the list. This
> will be aided by having a safe way to cycle through all remotes
> multiple times without the core exiting --- arguably, one cycle is
> enough to make a list and the list building is complete when the
> second cycle starts. But it would be much easier to do this without
> having to worry about the core exiting unexpectedly. The GUI knows how
> to restart or terminate the core exit if need be.
>=20
> The behaviour is unchanged if management-query-remote is not in use.


I do not like this change. If you want to list all remotes adding an
option to the management interface that list all remotes is a better
idea than to piggyback on skipping and implmenenting this as hack to
list them all. Something like like-remotes.

Also I want skip to count a failure since a UI might have some knowlege
that certain remotes cannot work and skipping therefore should also
count as "have tried this remote".

Arne


--xUqOMYVtHxlm937PnHInL6xJmOLMIUZ7Y--

--DtKGnT4zbWJoj4kpKo13FcNeInN61jvAf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7CYYkACgkQFRhsZwKx
RFTeOhAAs9RfTDxkRcSyhmdGTKWjUWN8QaN2ZDjZFYLXJEE4s5AtV/egF5auVBfm
8jONWrW9i1q5BZHhFaMAxbfUWKYuDSdYQsRdoOspmrvG8GLVB4/Yfjhau8p8WUh6
aTFdAgWdIyZAqlSn/bvMsPha1lcsMOg1c+HNQ+sueQpSROvwNrWrTgpgtMKcDafy
KUdr3g+nPfb6/YI+8reudl6SNbAp/J/E6pMeawUqK4U41JpkMla7XkHUjPHGVsrZ
aHDvHMb3LMkj2eeNv8uCg9kF4PccW1RSHVuW4Ioivb7hsjtdD1BfhNtxe2nXPxWS
27QQ24ExFe928YsD3k9kMfw6uZjRg+H+Hv2lurfKCnyqPmeLZgOp0Ow1VN+Jk5iL
cX39WANduWkEChnHKe7HryK96t3MTPHJ0KRTMvcDhXjvF0dxTSMSAekaKA2xqWpi
PpOelwz0wO1S2YJVq4FBi5cRcFpFP+O3xc0B0gRikvYZjBFFFylGkUkd44fx+rx3
gKWaf3GnFDNqdEvwbEHZCnbuWVPZcC06tY3Dm/gDiikr1rPjsCcKWrYQ3f/ydlac
C8wztcgS+uV/Wb5YCPZFChanL+nEgsiUSfhpfQmIo8ec6Rs6VmmgPeUCkZvT89iQ
QYc5+dwvnTh1bDusgE95hZeAVFdHNgqs0bA+2iyaZ/sDK3FQvhY=
=4rW0
-----END PGP SIGNATURE-----

--DtKGnT4zbWJoj4kpKo13FcNeInN61jvAf--

