Message-ID: <4D6BC1D1.7060604@...1114...>
Date: Mon, 28 Feb 2011 16:40:01 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4D6ABF00.8070309@...1449...>
	<4D6B580C.4030606@...515...>	<4D6BAFDC.7040307@...1449...>
	<4D6BB3DD.6090806@...1449...>
In-Reply-To: <4D6BB3DD.6090806@...1449...>
Subject: Re: [Openvpn-devel] [PATCH] plugin.h: update prototype of
 plugin_call dummy in !ENABLE_PLUGIN case [v2]
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
To: Stefan Hellermann <stefan@...1449...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/11 15:40, Stefan Hellermann wrote:
> Am 28.02.2011 15:23, schrieb Stefan Hellermann:
>> Am 28.02.2011 09:08, schrieb Samuli Sepp=E4nen:
>>> Hi Stefan,
>>>
>>> I think you should rebase your patch against the "beta2.2" branch. No
>>> development is done in the "allmerged" branch, it only used to aggregate
>>> code from other branches.
>>>
>> The commit which introduces this build-failure is in the bugfix2.1
>> branch. Could you apply it there and merge the patch to allmerged?
>>
>> Otherwise the weekly snapshots linked on
>> https://community.openvpn.net/openvpn/wiki/TesterDocumentation
>> do not build in the !ENABLE_PLUGIN case.
>>
>> The router distribution Openwrt is using these.
>>
>=20
> plugin.h: update prototype of plugin_call dummy in !ENABLE_PLUGIN case [v=
2]
>=20
> Commit 2db5a0ac3e053857d97e468de53e70a605f54561 adds two arguments to
> plugin_call(...), but missed the !ENABLE_PLUGIN case. With
> !ENABLE_PLUGIN, plugin_call(...) is only a dummy, so add these two
> parameters there too.
>=20
> ---
>  plugin.h |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>=20
>=20
> There is a small copy-paste failure in the patch, the correct one below.
> This one is now really run-time tested.
>=20
> Signed-off-by: Stefan Hellermann <stefan@...1449...>

ACK!

Thanks a lot for this fix.  Good catch!

Applied to bugfix2.1 and merged into allmerged.

commit 4c4b8cedfa98e8892a53eadd154836f8fa8cea7a
Author: Stefan Hellermann <stefan@...1449...>
Date:   Sun Feb 27 22:15:44 2011 +0100

    Signed-off-by: Stefan Hellermann <stefan@...1449...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


You asked earlier if this patch was good, and I see you managed to add the
"Signed-off-by:" line (git commit -s).  So this basically looks good to me!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk1rwdEACgkQDC186MBRfrq+9gCdGgk78cFkcXo+Oc1yEFi7Y5l0
SDkAni0Oa4lDyvK/9OrIwOAIeaEWFpVT
=3DRoHL
-----END PGP SIGNATURE-----

